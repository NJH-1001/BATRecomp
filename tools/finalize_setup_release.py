"""Remove development/game assets from setup archives before any upload."""
import hashlib
import json
from pathlib import Path, PurePosixPath
import sys
import zipfile

root = Path(__file__).resolve().parents[1]
for filename in sys.argv[1:]:
    archive = Path(filename)
    temporary = archive.with_suffix('.audited.zip')
    removed = []
    hashes = {}
    with zipfile.ZipFile(archive) as src, zipfile.ZipFile(temporary, 'w', zipfile.ZIP_DEFLATED) as dst:
        for info in src.infolist():
            path = PurePosixPath(info.filename)
            if path.is_absolute() or '..' in path.parts:
                raise ValueError('Unsafe archive path')
            excluded = bool(set(path.parts) & {
                'docs', 'tests', 'test_data', 'analysis', 'captures', 'generated',
                '.git', '.github', 'saves', 'ghidra', '__pycache__', 'cycle_testrom'})
            excluded |= path.suffix.lower() in {'.rom', '.iso', '.cue', '.mcd', '.mcr', '.chd', '.ips', '.pst'}
            excluded |= path.suffix.lower() == '.bin' and path.name.lower() != 'openbios.bin'
            excluded |= path.name == 'boxart_sonic1.tga'
            if excluded:
                removed.append(info.filename)
                continue
            if path.name in {'gamecontrollerdb.txt', 'keybinds.ini'} and len(path.parts) == 1:
                continue
            data = src.read(info)
            dst.writestr(info, data)
            if not info.is_dir():
                hashes[info.filename] = hashlib.sha256(data).hexdigest()
        for source, destination in [('input/gamecontrollerdb.txt', 'gamecontrollerdb.txt'),
                                    ('input/keybinds.ini', 'keybinds.ini')]:
            data = (root / source).read_bytes()
            dst.writestr(destination, data)
            hashes[destination] = hashlib.sha256(data).hexdigest()
        dst.writestr('RELEASE_AUDIT.json', json.dumps({
            'format': 1, 'type': 'setup-host: generate game code locally',
            'removed_development_assets': len(removed), 'sha256': hashes}, indent=2))
    with zipfile.ZipFile(temporary) as check:
        if check.testzip() is not None:
            raise ValueError('Archive integrity failed')
        required = {'CMakeLists.txt', 'display_mods.c', 'game.toml', 'gamecontrollerdb.txt',
                    'keybinds.ini', 'psxrecomp/runtime/runtime.cmake', 'psxrecomp/bios/openbios.bin'}
        if not required.issubset(check.namelist()):
            raise ValueError('Required setup payload missing: ' + str(required - set(check.namelist())))
    temporary.replace(archive)
    print(f'{archive.name}: audited {len(hashes)} files, excluded {len(removed)} development/game assets')
