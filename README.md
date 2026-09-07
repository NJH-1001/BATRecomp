# BATRecomp

Local Battle Arena Toshinden USA SCUS-94003 project. The disc boots
SCUS_942.00 (runtime SCUS-94200).

## Windows build

Built: build/Battle_Arena_Toshinden_Recompiled.exe, Windows AMD64,
RelWithDebInfo, SDL3, OpenBIOS LLE. Required DLLs are staged beside it.
Native TCP screenshot verification shows the rendered game story intro.

Run ./Launch-BATRecomp.ps1 in PowerShell. Rebuild existing generated sources
with ./Build-BATRecomp.ps1. The legal disc remains in ../disc.

## Controllers, keyboard, and CRT options

The wired PowerA Advantage Switch 2 controller is confirmed working after
adding its upstream SDL mapping. The launch script loads the pinned controller
database and player one selects the first recognized gamepad. Other Switch,
PlayStation and Xbox models use SDL3 support but have not been physically tested.
See input/README.md for the full mapping. Keyboard: WASD or arrows move;
I/J/K/L are triangle/square/cross/circle; Enter starts; Backspace selects.

Optional CRT presets (saved until changed):

```powershell
.\Launch-BATRecomp.ps1 -Crt JVC
.\Launch-BATRecomp.ps1 -Crt Trinitron
.\Launch-BATRecomp.ps1 -Crt Off
```

These are simplified CRT colour and scanline effects inspired by the MiSTer
JVC and Sony Trinitron presets, not ports of their gamma/sharpness/mask filters.
The default is CRT Off and 4:3. An experimental 16:9 wider-FOV mod is available
and accepted by the user after playtesting. Black areas around arena floors
were acceptable in that test; their exact cause has not been established.
It uses the framework's GTE projection mode, with no per-game code patch.

```powershell
.\Launch-BATRecomp.ps1 -Crt Trinitron -Aspect '16:9'
# Return to the original aspect:
.\Launch-BATRecomp.ps1 -Crt Trinitron -Aspect '4:3'
```

This direct-launch build disables the optional launcher/setup wizard because
the official launcher lacks framework-required API fields. Optional rewind
is disabled because its backend is absent.

## Personal Windows package

`dist/BATRecomp-0.1.0-windows-x64-LOCAL-ONLY.zip` is a local-use package.
Extract it to a writable folder and run `Play.cmd` to select your legal CUE.
`Play-16x9-Trinitron.cmd` selects wider FOV and CRT; `Play-4x3.cmd` restores
4:3 with CRT off. It creates fresh saves; development memory cards are excluded.
Recreate the archive with `python tools/package_local.py` after a build.
The extracted copy boots through OpenBIOS into the game with only packaged
DLLs on the application path. A separate clean Windows PC is not yet tested.
Do not redistribute this archive: its executable contains generated game code.

## Verification

See verification/status.json and verification/openbios-discovery.json.
OpenBIOS discovery and table-bound fixes are in recompiler source; both
registered regression tests pass. No generated code was hand-edited.
Native gameplay and both CRT presets have been visually checked; full Beetle
state comparison, additional physical controller models, and a redistributable
setup package remain pending. 16:9 is user-accepted. Digital controller mode
is locked and hybrid disabled.
The data-track hash matches an external catalog; full 14-track Redump
comparison remains pending.

## Data policy

Disc images, extracted code, generated game code, Ghidra databases, captures,
memory cards and build outputs are ignored. Do not commit or redistribute
the local executable containing generated game code. A release must generate
game code locally from the player's own disc.
