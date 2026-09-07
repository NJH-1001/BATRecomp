#include "mod_plugins.h"
#include <string.h>
extern void gpu_ws_set_gte_game_mode(int on);
extern void psx_ws_set_native_wide(int on);

static void activate_wide_projection(void) {
    gpu_ws_set_gte_game_mode(1);
    (void)psx_mod_set_fixed_display_aspect(16, 9);
    psx_ws_set_native_wide(0);
}
PSX_MOD_CONSTRUCTOR(register_bat_wide_projection) {
    (void)psx_mod_register_activation_plugin("bat.wide-projection", activate_wide_projection);
}

static void activate_crt(void) {
    char preset[32] = "jvc";
    (void)psx_mod_option_value("bat.presentation", "crt", "preset", preset, sizeof preset);
    if (strcmp(preset, "trinitron") == 0)
        (void)psx_mod_set_crt_presentation(3, 0.40f);
    else
        (void)psx_mod_set_crt_presentation(1, 0.30f);
}
PSX_MOD_CONSTRUCTOR(register_bat_display_mods) {
    (void)psx_mod_register_activation_plugin("bat.crt", activate_crt);
}
