# Battle Arena Toshinden Recompiled

An unofficial, noncommercial [PSXRecomp](https://github.com/mstan/psxrecomp)
compatibility project for **Battle Arena Toshinden (USA)**, also called **BATRecomp**.

**[Download the setup kits](https://github.com/NJH-1001/BATRecomp/releases/latest)** ·
[Build status](https://github.com/NJH-1001/BATRecomp/actions/workflows/release.yml) ·
[Report a problem](https://github.com/NJH-1001/BATRecomp/issues)

You supply your legally obtained disc and generate the playable executable on
your computer. Releases contain setup tools and **OpenBIOS**, not the game.
No disc images, extracted game executable, generated game code, retail BIOS,
memory cards, captures, or analysis databases are distributed.

## Downloads and requirements

| Platform | Setup archive | Requirements |
|---|---|---|
| Windows | `BATRecomp-0.1.0-windows-x64.zip` | Windows 10/11, 64-bit Intel or AMD |
| Linux | `BATRecomp-0.1.0-linux-x64.zip` | x86-64; built on Ubuntu 24.04 |
| Mac, Apple Silicon | `BATRecomp-0.1.0-macos-arm64.zip` | macOS 15 or newer |
| Mac, Intel | `BATRecomp-0.1.0-macos-x64.zip` | macOS 15 or newer |

Python **3.11 or newer**, a writable installation folder, disk space for your
disc and generated build, and a compatible CMake/Ninja/Clang toolchain are
needed for first-time setup. The wizard can download its supported toolchain.
The Mac generator tools set the macOS 15 minimum. macOS binaries are ad-hoc
signed, not notarized; Windows binaries are unsigned.

## Supported disc

Use the USA Redump-style **CUE plus all 14 BIN tracks**. Keep the tracks beside
the CUE and select the CUE in setup, rather than an individual BIN.

- Catalog identifier: **SCUS-94003**; this supported disc boots **SCUS_942.00**.
- Runtime game ID: **SCUS-94200**. That difference is expected for this dump.
- Data Track 01 size: `14662368` bytes.
- Data Track 01 MD5: `70b362b3b09d0a3c3999ce9f055620e6`.
- Data Track 01 SHA-1: `cb03e66d2a5e68f402f9c64741a94c02ca78d4c5`.

The data-track digest has been checked against an external catalog. A complete
independent Redump comparison of all audio tracks remains pending. Other regions
and revisions are not supported by this configuration.

## First-time setup

1. Download your platform ZIP from [Releases](https://github.com/NJH-1001/BATRecomp/releases).
   Use the setup archive, not GitHub's automatic source-code ZIP.
2. Extract the **entire** archive into a writable folder.
3. On Windows, run `Battle_Arena_Toshinden_Recompiled.exe`. On Linux or Mac,
   open a terminal in that folder and run `./Battle_Arena_Toshinden_Recompiled`.
4. Keep **OpenBIOS** selected, choose your legal USA CUE, and select
   **Generate & rebuild**. Game code is generated and compiled locally.
5. Reopen the same setup executable when the build finishes. It forwards to the
   playable build under `build-release/`.

Keep the extracted kit together. `README-SETUP.txt` explains the toolchain flow.
The preparation step copies your disc tracks into the local working directory.
Back up your locally created saves before replacing an installation.
Connect your controller before launching and check Player 1's device setting.

## Controls

Modern controllers use SDL3 and positional PlayStation button mappings. Player 1
selects a recognized controller automatically. The emulated controller is locked
to **digital mode** (`lock_mode=true`, `allow_hybrid=false`).

| PlayStation input | Keyboard | Switch / Switch 2 | PS4 / PS5 | Xbox |
|---|---|---|---|---|
| D-pad | WASD or arrows | D-pad / left stick | D-pad / left stick | D-pad / left stick |
| Cross / Circle | K / L | B / A | Cross / Circle | A / B |
| Square / Triangle | J / I | Y / X | Square / Triangle | X / Y |
| L1 / R1 | Q / E | L / R | L1 / R1 | LB / RB |
| L2 / R2 | 1 / 3 | ZL / ZR | L2 / R2 | LT / RT |
| Start / Select | Enter / Backspace | Plus / Minus | Options / Share or Create | Menu / View |

The **PowerA Advantage Wired Controller for Nintendo Switch 2** (`20D6:A720`)
was tested over USB and confirmed working by the user. Its upstream SDL mapping
is included. Switch, DualShock 4, DualSense and Xbox support comes through SDL3;
those models, Bluetooth operation and extra controller features have not been
physically tested here. See [input/README.md](input/README.md).

## Optional display mods

Open the launcher's **Mods** page before starting the game.

- **16:9 Wider View (Experimental)** expands the GTE field of view in 3D scenes.
  It is disabled by default and was accepted in the user's playtest. Black areas
  around arena edges were acceptable in that test; their exact cause is unproven.
- **CRT Display** offers JVC-inspired colour with 30% scanlines, or
  Trinitron-inspired colour with 40% scanlines. These are simplified effects
  inspired by MiSTer presets, not exact gamma/sharpness/phosphor-mask ports.
  Use OpenGL for scanlines.

Default presentation is **4:3, CRT off, OpenGL**. Netplay and rewind are disabled.
No generated game code is hand-edited for these options.

## Building from source

Clone the pinned submodules and apply the reviewed framework patch once:

```sh
git clone --recurse-submodules https://github.com/NJH-1001/BATRecomp.git
cd BATRecomp
git -C psxrecomp apply ../patches/psxrecomp.patch
python psxrecomp/psxrecomp_cli.py generate --project-root . --config game.toml --disc "/path/to/Battle Arena Toshinden (USA).cue"
python psxrecomp/psxrecomp_cli.py rebuild --project-root . --config game.toml --build-dir build-release --target psx-runtime --exe-basename Battle_Arena_Toshinden_Recompiled --no-pgo
```

On Windows, replace the example disc path with a Windows path. Install Python
3.11+ and the supported toolchain first. Release kits already contain the patched
SDK and emitters: use their setup launcher instead of applying the patch again.
See [PUBLICATION.md](PUBLICATION.md) for the separation between public setup tools
and locally generated game files.

## Verification and reporting

Windows development playtests reached menus and an actual match with keyboard
and the wired PowerA controller; wider FOV and CRT presets were accepted.
The extracted setup kit also regenerated and compiled a player executable.
This is **not a full-game completion claim**.

All four setup-host CI builds passed, including package filtering and dependency
checks. Linux/macOS gameplay, physical devices on those platforms, save/load
round trips, separate Windows 10/11 systems, and AMD hardware need further testing.
Full deterministic Beetle comparison remains pending. See [VERIFICATION.md](VERIFICATION.md).

When reporting an issue, include release version, OS/CPU architecture, controller
model and connection, renderer, enabled mods, and reproduction steps. Do not
attach disc data, generated game code, saves, memory cards, captures, or analysis
databases to this repository.

## Credits and licensing

Built on [PSXRecomp](https://github.com/mstan/psxrecomp),
[recomp-ui](https://github.com/mstan/recomp-ui),
[PCSX-Redux OpenBIOS](https://github.com/grumpycoders/pcsx-redux),
[SDL3](https://github.com/libsdl-org/SDL), and
[SDL_GameControllerDB](https://github.com/mdqinc/SDL_GameControllerDB).
CRT references: [MiSTer display presets](https://github.com/MiSTer-devel/Presets_MiSTer).

Components retain their licenses; see [THIRD_PARTY.md](THIRD_PARTY.md).
Game-project files do not currently assert a new license. Names and trademarks
identify compatibility only. This project is not affiliated with or endorsed by
Sony or the game's original developers, publishers, or rights holders.
