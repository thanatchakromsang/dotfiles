#include "thanatchaya.h"

layer_state_t layer_state_set_user(layer_state_t state) {
   return update_tri_layer_state(state, LOWER, RAISE, ADJUST);
}

uint16_t get_tapping_term(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case LGUI_T(KC_J):
        case LGUI_T(KC_F):
        case LALT_T(KC_D):
        case LALT_T(KC_K):
        /* case LCTL_T(KC_S): */
        /* case LCTL_T(KC_L): */
            return TAPPING_TERM + 50;
        default:
            return TAPPING_TERM;
    }
}
