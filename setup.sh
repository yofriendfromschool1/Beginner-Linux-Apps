#!/usr/bin/env bash
# ============================================================
#  setup.sh — Beginner Linux bootstrap
#  Updates system, installs GUI software store, sets up
#  Flatpak + Flathub, Flatseal, Warehouse, Timeshift,
#  and optionally a starter pack of beginner apps.
#
#  Supported: Debian, Ubuntu, Mint, Pop!_OS, Fedora,
#             Arch, Manjaro, EndeavourOS, openSUSE.
#  Usage:     sudo ./setup.sh
# ============================================================
set -uo pipefail

# ---------- pretty output ----------
info()  { printf '\033[1;34m[INFO]\033[0m %s\n' "$*"; }
ok()    { printf '\033[1;32m[ OK ]\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m[WARN]\033[0m %s\n' "$*"; }
fail()  { printf '\033[1;31m[FAIL]\033[0m %s\n' "$*"; }

# ---------- remember desktop before elevating ----------
DESKTOP="${XDG_CURRENT_DESKTOP:-}"

# ---------- must be root ----------
if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
  exec sudo env XDG_CURRENT_DESKTOP="$DESKTOP" "$0" "$@"
fi

if [[ ! -t 0 && ! -t 1 ]]; then
  warn "Piping this script into bash disables the app-pack prompt."
  warn "Preferred: clone the repo and run 'sudo ./setup.sh'."
fi

# ---------- distro detection via /etc/os-release ----------
if [[ ! -r /etc/os-release ]]; then
  fail "/etc/os-release not found — can't identify this system."
  echo "  → Install 'flatpak' from your software store, then run:"
  echo "    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo"
  exit 1
fi
# shellcheck disable=SC1091
. /etc/os-release
DISTRO_ID="${ID:-unknown}"
DISTRO_LIKE="${ID_LIKE:-}"
DISTRO_NAME="${NAME:-Unknown}"
info "Detected distro: $DISTRO_NAME (id=$DISTRO_ID, family=${DISTRO_LIKE:-none})"

# ---------- package manager detection ----------
have() { command -v "$1" >/dev/null 2>&1; }

if   have apt;    then PM=apt
elif have dnf;    then PM=dnf
elif have zypper; then PM=zypper
elif have pacman; then PM=pacman
else
  fail "No supported package manager found (apt/dnf/zypper/pacman)."
  echo "  → Unsupported or minimal system. Install 'flatpak' from your"
  echo "    software store, then run the flathub command above, then:"
  echo "    flatpak install flathub com.github.tchx84.Flatseal"
  exit 1
fi
ok "Package manager: $PM"

pkg_install() {
  case "$PM" in
    apt)    apt-get install -y "$@" ;;
    dnf)    dnf install -y "$@" ;;
    zypper) zypper install -y "$@" ;;
    pacman) pacman -S --needed --noconfirm "$@" ;;
  esac
}

# ---------- step 1: full system update ----------
update_system() {
  info "Step 1/5: Updating your system first (always do this before installing anything)..."
  case "$PM" in
    apt)    apt-get update && apt-get upgrade -y ;;
    dnf)    dnf upgrade -y --refresh ;;
    zypper) zypper refresh && zypper dup -y ;;
    pacman) pacman -Syu --noconfirm ;;
  esac
  ok "System updated."
  # Rolling-release warnings
  case "$DISTRO_ID" in
    opensuse-tumbleweed) warn "Tumbleweed tip: always use 'sudo zypper dup' / YaST — never partial upgrades." ;;
    arch)                warn "Arch tip: always 'sudo pacman -Syu' (full sync) — partial upgrades are unsupported." ;;
  esac
}

# ---------- step 2: GUI software store / updater ----------
desktop_is() { [[ "${DESKTOP,,}" == *"$1"* ]]; }

install_gui_updater() {
  info "Step 2/5: Making sure you have a GUI software store/updater..."
  if have gnome-software || have discover || have pamac || have octopi; then
    ok "A GUI software store is already installed."
  else
    if desktop_is KDE || desktop_is Plasma; then
      case "$PM" in
        apt)    pkg_install plasma-discover plasma-discover-backend-flatpak ;;
        dnf)    pkg_install plasma-discover ;;
        zypper) pkg_install plasma-discover ;;
        pacman) pkg_install discover ;;
      esac
    else
      # GNOME or anything else → GNOME Software (Pamac for Manjaro, Octopi for Arch)
      case "$DISTRO_ID" in
        manjaro)                  pkg_install pamac ;;
        arch|endeavouros|garuda)  pkg_install octopi && warn "For Pamac instead: 'yay -S pamac-aur' (AUR)." ;;
        *) case "$PM" in
             apt)    pkg_install gnome-software gnome-software-plugin-flatpak ;;
             dnf)    pkg_install gnome-software ;;
             zypper) pkg_install gnome-software ;;
             pacman) pkg_install gnome-software ;;
           esac ;;
      esac
    fi
    ok "GUI updater installed — find it in your app menu as 'Software', 'Discover', 'Pamac', or 'Octopi'."
  fi
}

# ---------- step 3: Flatpak + Flathub ----------
FLATHUB_URL="https://dl.flathub.org/repo/flathub.flatpakrepo"

install_flatpak() {
  info "Step 3/5: Setting up Flatpak + Flathub..."
  if have flatpak; then
    ok "Flatpak is already installed."
  else
    pkg_install flatpak || { fail "Flatpak install failed."; return 1; }
    ok "Flatpak installed."
  fi
  # Debian/Ubuntu split the GUI integration into a plugin
  if [[ "$PM" == "apt" ]]; then
    pkg_install gnome-software-plugin-flatpak 2>/dev/null \
      || pkg_install plasma-discover-backend-flatpak 2>/dev/null \
      || warn "Couldn't add a flatpak GUI plugin — GNOME Software/Discover may not show flatpaks until reboot."
  fi
  # Flathub remote
  if flatpak remotes 2>/dev/null | grep -q '^flathub'; then
    ok "Flathub remote already configured."
  else
    info "Adding the Flathub app repository..."
    flatpak remote-add --if-not-exists flathub "$FLATHUB_URL" \
      && ok "Flathub added — every Flatpak app is now one click away." \
      || fail "Couldn't add Flathub. Try: flatpak remote-add --if-not-exists flathub $FLATHUB_URL"
  fi
}

# ---------- step 4: Flatpak management tools + Timeshift ----------
install_extras() {
  info "Step 4/5: Installing Flatseal, Warehouse, and Timeshift..."
  flatpak install -y flathub com.github.tchx84.Flatseal 2>/dev/null \
    && ok "Flatseal installed (manage Flatpak app permissions)." \
    || warn "Flatseal install failed — try: flatpak install flathub com.github.tchx84.Flatseal"
  flatpak install -y flathub io.github.flattool.Warehouse 2>/dev/null \
    && ok "Warehouse installed (manage/clean your Flatpaks)." \
    || warn "Warehouse install failed — try: flatpak install flathub io.github.flattool.Warehouse"

  if have timeshift; then
    ok "Timeshift already installed — open it and create your first snapshot."
  else
    case "$DISTRO_ID" in
      arch|endeavouros|garuda)
        warn "On pure Arch, Timeshift is in the AUR: yay -S timeshift (skipping)." ;;
      opensuse*)
        warn "openSUSE: 'snapper' is the native snapshot tool — configuring via YaST instead (skipping timeshift)." ;;
      *)
        pkg_install timeshift 2>/dev/null \
          && ok "Timeshift installed — open it and create your first snapshot." \
          || warn "Timeshift not in repos — grab it from your software store." ;;
    esac
  fi
}

# ---------- step 5 (optional): starter app pack ----------
install_app_pack() {
  info "Step 5/5: Optional starter pack of recommended apps (~several GB):"
  echo "  Firefox, VLC, LibreOffice, GIMP, Discord, Spotify, Telegram, OBS, Steam"
  local REPLY="n"
  read -r -p "Install these now via Flathub? [y/N] " REPLY </dev/tty 2>/dev/null || REPLY="n"
  if [[ "${REPLY,,}" == "y" ]]; then
    flatpak install -y flathub \
      org.mozilla.firefox \
      org.videolan.VLC \
      org.libreoffice.LibreOffice \
      org.gimp.GIMP \
      com.discordapp.Discord \
      com.spotify.Client \
      org.telegram.desktop \
      com.obsproject.Studio \
      com.valvesoftware.Steam \
      && ok "Starter pack installed — find the apps in your app menu." \
      || warn "App pack had issues — install individually from your software store."
  else
    ok "Skipped app pack — install apps any time from your software store or flathub.org."
  fi
}

# ---------- run everything ----------
update_system
install_gui_updater
install_flatpak
install_extras
install_app_pack

echo
ok "All done! 🎉 Next steps:"
echo "   1. Reboot once so software stores pick up Flathub."
echo "   2. Open Timeshift and create your first snapshot."
echo "   3. Browse apps in your software store (or flathub.org)."
echo "   4. Update everything any time: flatpak update  (plus your GUI updater)."
