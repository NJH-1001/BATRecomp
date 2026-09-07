# Verification status — 0.1.0

- Disc: USA SCUS-94003 catalog identity, SCUS_942.00 boot executable, data-track
  size/MD5/SHA-1 match; all 14 tracks preserved locally. Full external audio-track
  digest comparison is pending.
- OpenBIOS: LLE development boot reaches the game. Ghidra verified seed/data and
  jump-table corrections; both focused emitter/seed regressions pass.
- Windows development: title/menu, actual bout, keyboard and wired PowerA
  Switch 2 controls tested. User accepted 16:9 wider FOV and CRT presentation.
- Player setup: extracted game-data-free kit generated OpenBIOS and 22 game
  shards from the legal disc, then compiled the player executable with the
  supported Clang toolchain. The final player's visual boot check was interrupted;
  it is not counted as a new completed playtest.
- CI: Windows x64, Ubuntu 24.04 x64, macOS arm64 and macOS x64 setup hosts build
  and package successfully in run 34093957838 at source d6d9ef9.
- macOS: hosts link only OS libraries; SDL is static; ad-hoc signatures verified.
  Generator Mach-O minimum OS is 15.0, so kits require macOS 15+.
- Archives: all payload hashes, ZIP integrity and architecture headers checked;
  development/game-data fixtures removed before upload. Published documentation
  may be refreshed after CI without changing the built executables.

Not established: full-game completion, deterministic native-versus-Beetle state
parity, full save/load coverage, Linux/macOS gameplay, all controller models,
wireless/rumble features, or every supported Windows/CPU combination.

See [the successful CI run](https://github.com/NJH-1001/BATRecomp/actions/runs/34093957838)
and [OpenBIOS evidence](verification/openbios-discovery.json).
