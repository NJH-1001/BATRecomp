#include <SDL3/SDL.h>
#include <iostream>
#include <iomanip>

static void quoted(const char* text) {
    std::cout << '"';
    if (text) for (const unsigned char* p=(const unsigned char*)text; *p; ++p) {
        if (*p=='"' || *p=='\\') std::cout << '\\' << *p;
        else if (*p<32) std::cout << ' ';
        else std::cout << *p;
    }
    std::cout << '"';
}
int main() {
    if (!SDL_Init(SDL_INIT_GAMEPAD)) {
        std::cout << "{\"error\":"; quoted(SDL_GetError()); std::cout << "}\n"; return 1;
    }
    // Windows gamepad enumeration can arrive after initialization.
    for (int i=0;i<100;++i) { SDL_PumpEvents(); SDL_Delay(10); }
    int count=0;
    SDL_JoystickID* ids=SDL_GetJoysticks(&count);
    std::cout << "{\"sdl_version\":" << SDL_GetVersion() << ",\"devices\":[";
    for (int i=0;i<count;++i) {
        if(i) std::cout << ',';
        std::cout << "{\"id\":" << ids[i] << ",\"name\":";
        quoted(SDL_GetJoystickNameForID(ids[i]));
        std::cout << ",\"vendor\":" << SDL_GetJoystickVendorForID(ids[i])
                  << ",\"product\":" << SDL_GetJoystickProductForID(ids[i])
                  << ",\"gamepad\":" << (SDL_IsGamepad(ids[i])?"true":"false");
        SDL_Gamepad* pad=SDL_OpenGamepad(ids[i]);
        std::cout << ",\"opened\":" << (pad?"true":"false");
        if(pad) { std::cout << ",\"mapping\":"; char* map=SDL_GetGamepadMapping(pad); quoted(map); SDL_free(map); SDL_CloseGamepad(pad); }
        else { std::cout << ",\"error\":"; quoted(SDL_GetError()); }
        std::cout << '}';
    }
    std::cout << "]}\n";
    SDL_free(ids);SDL_Quit();return 0;
}
