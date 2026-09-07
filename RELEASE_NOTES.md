# BATRecomp 0.1.0

Initial setup-kit release for Battle Arena Toshinden USA, catalog SCUS-94003,
boot executable SCUS_942.00.

## Downloads

- Windows 10/11 x86-64: BATRecomp-0.1.0-windows-x64.zip
- Linux x86-64 (Ubuntu 24.04 build): BATRecomp-0.1.0-linux-x64.zip
- macOS 15+ Apple Silicon: BATRecomp-0.1.0-macos-arm64.zip
- macOS 15+ Intel: BATRecomp-0.1.0-macos-x64.zip
- SHA256SUMS.txt verifies the downloaded archives.

These are setup kits, not prebuilt copies of the game. Extract the entire ZIP,
install Python 3.11+, run Battle_Arena_Toshinden_Recompiled (.exe on Windows),
select your legal USA 14-track CUE, keep OpenBIOS selected, and choose Generate
& rebuild. The wizard can download the supported compiler toolchain. Reopen
the setup executable after compilation to launch your local game build.

## Included

OpenBIOS LLE setup, SDL3 controller support with the tested wired PowerA Switch 2
mapping, WASD/arrow keyboard controls, digital controller locking, experimental
16:9 wider FOV, and JVC/Trinitron-inspired CRT options. Display mods are opt-in
through the launcher's Mods page. See the README for button mappings.

## Verification and limits

All four native setup builds and package checks passed in
https://github.com/NJH-1001/BATRecomp/actions/runs/34093957838 (source d6d9ef9).
Windows development gameplay, keyboard/PowerA input, CRT and wider FOV were
playtested. An extracted setup kit regenerated and compiled the player game.
Linux/macOS gameplay and wider device coverage remain unverified. This is not
a full-game completion or full deterministic oracle-parity claim.

Mac hosts use OS-only dynamic dependencies and are ad-hoc signed, not notarized.
The generator binaries require macOS 15+. Windows binaries are unsigned.
Documentation was refreshed after CI; the built host executables are unchanged.

No game disc, generated game code, retail BIOS, memory cards, captures or
analysis databases are included. Each archive carries RELEASE_AUDIT.json.
Do not redistribute the playable executable generated from your own disc.
