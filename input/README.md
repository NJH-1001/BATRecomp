# Controls

SDL3 Gamepad handles Nintendo Switch, supported Switch 2 models, PS4, PS5 and
Xbox devices using positional face buttons. The pinned upstream mapping database
adds the attached PowerA Advantage Wired Controller for Nintendo Switch 2
(USB vendor 20D6, product A720), which SDL 3.4.10 did not recognize by itself.
Launch-BATRecomp.ps1 loads it before SDL initialization. Player one is `auto`;
keyboard remains available, including when no controller is attached.

| PS1 input | Keyboard | Controller position |
|---|---|---|
| D-pad | WASD or arrows | D-pad or left stick |
| Triangle | I | North (Nintendo X / Xbox Y / PlayStation triangle) |
| Square | J | West (Nintendo Y / Xbox X / PlayStation square) |
| Cross | K | South (Nintendo B / Xbox A / PlayStation cross) |
| Circle | L | East (Nintendo A / Xbox B / PlayStation circle) |
| L1 / R1 | Q / E | Left / right shoulder |
| L2 / R2 | 1 / 3 | Left / right trigger |
| Start | Enter | + / Menu / Options |
| Select | Backspace | - / View / Share/Create |

Edit build/keybinds.ini to customize. The launch script copies input/keybinds.ini
only when that file is missing, preserving subsequent customizations.
User-confirmed physical test: attached PowerA controller works after mapping fix.
Other controller models are supported through SDL, but have not been physically
tested on this machine.
