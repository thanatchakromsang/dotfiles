#include "thanatchaya_combos.h"

// Horizontal combo
const uint16_t PROGMEM k_l_quot_combo[] = {LALT_T(KC_K), LCTL_T(KC_L), COMBO_END};
const uint16_t PROGMEM s_d_mins_combo[] = {LCTL_T(KC_S), LALT_T(KC_D), COMBO_END};

const uint16_t PROGMEM s_e_esc_combo[] = {LCTL_T(KC_S), KC_E, COMBO_END};
const uint16_t PROGMEM i_l_esc_combo[] = {KC_I, LCTL_T(KC_L), COMBO_END};

  /* ---------------------------------------------------------------------
   *
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │     │     │ C   │     │     │   │     │     │   E │     │     │
   *     ├─────┼─────S─────┼─────┼─────┤   ├─────┼─────┼─────S─────┼─────┤
   *     │     │   E -     │     │     │   │     │     │  QUOT C   │     │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │   │     │     │     │     │     │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   */

combo_t key_combos[COMBO_COUNT] = {
  COMBO(s_e_esc_combo, KC_ESC),
  COMBO(i_l_esc_combo, KC_ESC),
  COMBO(k_l_quot_combo, KC_QUOT),
  COMBO(s_d_mins_combo, KC_MINS),
};
