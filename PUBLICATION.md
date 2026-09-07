# Publication policy

Public releases are setup hosts, emitters, source configuration and an SDK.
They require the player's legally obtained disc. The build workflow clears
all generated code before compiling its setup host; the archive audit removes
screenshots, ROM fixtures, memory cards and development assets before upload.
Each setup ZIP contains RELEASE_AUDIT.json with payload SHA-256 hashes.

Never commit or publish disc images, extracted game executables, generated game
C, compiled playable game executables, saves, memory cards, captures, logs or
Ghidra projects. A build produced after Generate & rebuild is personal output.
The local archive named LOCAL-ONLY is not a public release and must not be uploaded.

The reviewed framework patch contains generic source fixes, synthetic tests and
MIT OpenBIOS metadata. The game seed list contains addresses, not instruction
bytes or decompiled function bodies. Git submodules point to upstream sources.
