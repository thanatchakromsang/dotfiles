#include "thanatchaya_combos.h"

const uint16_t PROGMEM s_e_esc_combo[] = {LCTL_T(KC_S), KC_E, COMBO_END};
const uint16_t PROGMEM e_s_esc_combo[] = {KC_E, LCTL_T(KC_S), COMBO_END};
const uint16_t PROGMEM i_l_esc_combo[] = {KC_I, LCTL_T(KC_L), COMBO_END};
const uint16_t PROGMEM l_i_esc_combo[] = {LCTL_T(KC_L), KC_I, COMBO_END};

  /* ---------------------------------------------------------------------
   *
   *   Qwerty layout
   *
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │     │     │ C   │     │     │   │     │     │   E │     │     │
   *     ├─────┼─────S─────-─────┼─────┤   ├─────┼─────-─────S─────┼─────┤
   *     │     │   E │     │     │     │   │     │     │     │ C   │     │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │   │     │     │     │     │     │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   */

combo_t key_combos[COMBO_COUNT] = {
  COMBO(s_e_esc_combo, KC_ESC),
  COMBO(e_s_esc_combo, KC_ESC),
  COMBO(i_l_esc_combo, KC_ESC),
  COMBO(l_i_esc_combo, KC_ESC)
};
