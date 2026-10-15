# 🐧 Beginner Linux Apps — First-Steps, GUI Updaters & Flatpak Setup

![bash](https://img.shields.io/badge/script-bash-4EAA25?logo=gnubash&logoColor=white)
![flatpak](https://img.shields.io/badge/flatpak-ready-FFA033?logo=flatpak&logoColor=white)
![distros](https://img.shields.io/badge/distros-Arch%20%7C%20Debian%20%7C%20Ubuntu%20%7C%20Fedora%20%7C%20openSUSE%20%7C%20Mint-blue)
![license](https://img.shields.io/badge/license-MIT-green)

A one-stop repo for Linux newcomers: **do your first updates, get a GUI updater for your specific distro, set up Flatpak + Flathub, and install a solid starter set of apps — with one script that auto-detects your distro.**

No matter which distro you picked (Ubuntu, Mint, Debian, Fedora, Arch, Manjaro, openSUSE…), the workflow below works everywhere. GUI-first, terminal optional.

---

## 🚀 What To Do First (5 steps, in order)

1. **Update your system** — open your distro's updater (see the table below) or run one command from the Flatpak/distro table. Always do this *before* installing anything, especially on rolling distros like Arch, Manjaro, and openSUSE Tumbleweed.
2. **Enable Flathub** — Flathub is the "app store" that works on *every* distro, so you're never limited by your distro's repo. One command (or one toggle in your software store).
3. **Install Flatseal + Warehouse** — Flatseal manages Flatpak app permissions; Warehouse manages/cleans your Flatpaks. Both are GUI, both are lifesavers.
4. **Set up Timeshift snapshots** — a 5-minute safety net so a bad update never means a reinstall. Snapshot *before* big changes.
5. **Install your apps** — from your GUI software store or the optional "starter pack" in this repo's script.

> 💡 Total time: ~15 minutes. The script at the bottom does steps 1–4 for you automatically.

---

## 🖥️ GUI Updaters by Distro

Every mainstream distro has a GUI way to update — no terminal required. Find yours:

| Distro / Family | Built-in GUI Updater | Also Updates Flatpaks? | Install if missing (terminal) |
|---|---|---|---|
| **Ubuntu** | Software Updater (`update-manager`) + Ubuntu App Center | App Center: yes | `sudo apt install gnome-software gnome-software-plugin-flatpak` |
| **Linux Mint** | Update Manager (mintupdate) | Software Manager: yes | preinstalled |
| **POP!_OS** | Pop!_Shop | yes | preinstalled |
| **Debian** | GNOME Software ("Software") | yes, with plugin | `sudo apt install gnome-software gnome-software-plugin-flatpak` |
| **Fedora** | GNOME Software | yes (enable 3rd-party repos for Flathub) | preinstalled |
| **Arch Linux** | none by default → **Octopi** (repos) or **Pamac** (AUR) | Octopi/Pamac: yes | `sudo pacman -S octopi` |
| **Manjaro** | **Pamac** ("Add/Remove Software") | yes, built-in | preinstalled |
| **EndeavourOS / Garuda** | Octopi / Pacseek (in repos) | Octopi: yes | `sudo pacman -S octopi` |
| **openSUSE Leap** | **YaST** → Online Update | GNOME Software/Discover: apps yes | preinstalled |
| **openSUSE Tumbleweed** | **YaST** (`zypper dup` via GUI) or Myrlyn | apps only — **use YaST for system** | preinstalled |
| **KDE Plasma (any distro)** | **Discover** | yes, with Flatpak backend | `sudo apt install plasma-discover-backend-flatpak` (Debian/Ubuntu) |

Notes:
- On **openSUSE Tumbleweed**, don't use Discover/GNOME Software for *system* updates — partial upgrades can break rolling distros. Use YaST Online Update or `sudo zypper dup`.
- On **pure Arch**, GNOME Software/Discover are weak; Octopi or Pamac are the recommended GUIs. Pamac lives in the AUR (`yay -S pamac-aur`).
- **GNOME Software and Discover are cross-distro**: GNOME Software comes with GNOME desktops, Discover with KDE — both update Flatpaks and native packages from one place.

---

## 📦 Flatpak + Flathub Setup by Distro

Flatpak is installed slightly differently per distro; adding Flathub is the same everywhere. Flatpak apps run identically on every distro, sandboxed and always up to date.

| Distro | 1. Install Flatpak | 2. Add Flathub | 3. GUI for Flatpaks |
|---|---|---|---|
| **Ubuntu / Debian** | `sudo apt install flatpak` | `flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo` | `sudo apt install gnome-software-plugin-flatpak` (GNOME) or `plasma-discover-backend-flatpak` (KDE), then reboot |
| **Linux Mint** | preinstalled | same command (Mint ships a *filtered* Flathub; add the full remote above for every app, or tick "allow unverified flatpaks" in Software Manager → Preferences) | Software Manager |
| **Fedora** | preinstalled | same command — or open GNOME Software → menu → Software Repositories → enable "Third-Party Repositories" | GNOME Software |
| **Arch / EndeavourOS** | `sudo pacman -S flatpak` | same command | Octopi / Pamac / GNOME Software / Discover |
| **Manjaro** | preinstalled | same command, or Pamac → Preferences → enable Flathub | Pamac |
| **openSUSE** | `sudo zypper install flatpak` | same command, then reboot | GNOME Software / Discover (apps) |
| **Kubuntu / KDE spins** | `sudo apt install flatpak` | same command + `sudo apt install plasma-discover-backend-flatpak` | Discover |
| **Other / unsure** | install `flatpak` from your software store | same command | any Flatpak-aware store |

<details>
<summary>📖 Flatpak vs. Snap — which should a beginner use?</summary>

Both are "universal" packages that work on any distro. **Flatpak** is the default on Fedora, Mint, Pop!_OS, and most non-Ubuntu distros, and Flathub has the largest desktop-app catalog. **Snap** is Ubuntu's default and fine if you stay on Ubuntu. This repo focuses on Flatpak because it works *identically everywhere*, but if you're on Ubuntu and the Snap Store already has your app, that's fine too. You can use both side by side.
</details>

### Flatpak quick commands (same on every distro)

```bash
flatpak search vlc                        # find an app
flatpak install flathub org.videolan.VLC  # install by ID
flatpak update                            # update ALL flatpak apps
flatpak list                              # what you have installed
flatpak uninstall org.videolan.VLC       # remove an app
```

---

## 🧰 Recommended Beginner Apps

Install any of these from your GUI software store or via the Flatpak ID. Flatpak versions are listed because they work on every distro and stay current.

| Category | App | Flatpak ID | Why it's recommended |
|---|---|---|---|
| Browser | Firefox | `org.mozilla.firefox` | Privacy-respecting, extension-rich default |
| Office suite | LibreOffice | `org.libreoffice.LibreOffice` | Opens/saves Word, Excel, PowerPoint files |
| Media player | VLC | `org.videolan.VLC` | Plays literally every audio/video format |
| Image editor | GIMP | `org.gimp.GIMP` | Photoshop-class editing, free |
| Notes | Joplin | `net.cozyp.Joplin` | Markdown notes with sync |
| Email | Thunderbird | `org.mozilla.Thunderbird` | Full-featured desktop mail client |
| Chat | Discord | `com.discordapp.Discord` | Voice/text chat for communities & gaming |
| Chat | Telegram | `org.telegram.desktop` | Fast, cross-platform messaging |
| Music | Spotify | `com.spotify.Client` | Streaming music |
| Streaming/recording | OBS Studio | `com.obsproject.Studio` | Screen recording & live streaming |
| Games | Steam | `com.valvesoftware.Steam` | Steam + Proton for Windows games |
| Code editor | VS Code | `com.visualstudio.code` | The default editor for developers |
| **Flatpak permissions** | **Flatseal** | `com.github.tchx84.Flatseal` | **Must-have**: control what each Flatpak can access |
| **Flatpak manager** | **Warehouse** | `io.github.flattool.Warehouse` | Manage remotes, clean leftovers, bulk ops |
| Snapshots | Timeshift | native package | Roll back your whole system if an update goes wrong |

<details>
<summary>🎵 Multimedia codecs (play MP3/MP4/etc.) — often needed on first install</summary>

| Distro | Command |
|---|---|
| Ubuntu/Mint/Debian | `sudo apt install ubuntu-restricted-extras libavcodec-extra` |
| Fedora | `sudo dnf group upgrade --with-optional multimedia` (after enabling 3rd-party repos) |
| Arch | codecs are included with players like VLC/MPV (`sudo pacman -S vlc`) |
| openSUSE | `sudo zypper install ffmpeg` or use Packman repo via YaST |
</details>

---

## ⚡ The Installer Script

`setup.sh` auto-detects your distro, then: **updates your system → installs/verifies a GUI software store for your desktop → installs Flatpak → adds Flathub → installs Flatseal + Warehouse → sets up Timeshift snapshots → (optionally) installs the starter app pack.**

### Run it

```bash
git clone https://github.com/yofriendfromschool1/Beginner-Linux-Apps.git
cd Beginner-Linux-Apps
chmod +x setup.sh
sudo ./setup.sh
```

> The script asks before installing the (large) app pack. Everything else is safe to accept — it only installs official distro packages and Flathub.

### The script

Save as `setup.sh` in your repo root:

```bash
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
```

---

## 🔧 Troubleshooting

| Problem | Fix |
|---|---|
| **Flathub apps don't appear in GNOME Software/Discover** | Install the flatpak plugin: `sudo apt install gnome-software-plugin-flatpak` (GNOME) or `sudo apt install plasma-discover-backend-flatpak` (KDE), then **reboot**. |
| **Fedora only shows a few Flatpaks** | Fedora's built-in Flathub is a filtered subset. Add the full remote: `flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo`, or enable "Third-Party Repositories" in GNOME Software → menu → Software Repositories. |
| **Mint hides "unverified" Flatpaks** | Software Manager → Preferences → tick "Allow unverified flatpaks", or add the full Flathub remote (command above). |
| **openSUSE Tumbleweed update warning** | Use `sudo zypper dup` or YaST Online Update — Discover/GNOME Software are for apps only on Tumbleweed. |
| **Arch: "partial upgrades are unsupported"** | Always run the full `sudo pacman -Syu`; never `pacman -Sy <pkg>` alone. |
| **`flatpak remote-add` asks for a password** | That's normal — it installs system-wide. Use `--user` after `remote-add` if you want a per-user install instead. |
| **Script says "No supported package manager"** | You're on an unusual distro. Install the `flatpak` package from your software store, then run the flathub `remote-add` command above. |
| **`sudo: ./setup.sh: command not found`** | Mark it executable first: `chmod +x setup.sh`. |
| **Timeshift missing on Arch** | It's in the AUR: `yay -S timeshift`. On openSUSE, use the built-in **snapper** instead. |
| **A Flatpak won't start** | Open **Flatseal**, find the app, and check/reset its permissions. |

---

## ❓ FAQ

**Do I have to use the terminal?**
No. Every step here has a GUI path: your distro's software store updates the system and (with the flatpak backend) Flatpaks too. The script and commands are just the fastest way to get everything set up at once.

**Do GUI updaters also update my Flatpak apps?**
Mostly yes — GNOME Software, Discover, Pamac, and Mint's Software Manager all update Flatpaks alongside native packages. YaST on openSUSE handles patches/apps; use `flatpak update` there. Verify in your store's Updates tab.

**Flatpak vs. Snap vs. native packages — what should I install?**
Rule of thumb: use your distro's native packages for core/system stuff, and Flatpak (Flathub) for desktop apps you want always-current and identical across distros. Snaps are fine if you're on Ubuntu. Never mix partial updates from different sources on rolling distros.

**Why update *before* installing anything?**
On rolling distros (Arch, Manjaro, Tumbleweed), installing against stale mirrors causes partial upgrades, which are the #1 way beginners break their systems. On point-release distros (Ubuntu, Mint, Fedora), updates fix security issues and missing-driver problems before they bite.

**Is the script safe to re-run?**
Yes — every step checks whether something is already installed and skips it. `--needed`/`--if-not-exists` flags make it idempotent.

---

## 🤝 Contributing

PRs welcome — especially:
- Verified commands for distros not listed (Alma, Rocky, Void, NixOS, Solus…)
- Corrections if a distro changes its default updater
- More must-have beginner apps for the table

Tested on: Ubuntu 24.04, Linux Mint 22, Debian 12, Fedora 41–43, Arch, Manjaro, EndeavourOS, openSUSE Tumbleweed.

## 📄 License

MIT — do whatever you like, no warranty. Timeshift before big changes, always.
