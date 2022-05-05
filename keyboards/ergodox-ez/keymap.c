/* Copyright 2020 Thanatchaya Kromsaneng thanatchakromsang@gmail.com @thanatchakromsang
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H
#include "version.h"
#include "thanatchaya.h"

enum custom_keycodes {
#ifdef ORYX_CONFIGURATOR
  VRSN = EZ_SAFE_RANGE,
#else
  VRSN = SAFE_RANGE,
#endif
  RGB_SLD
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
[QWERTY] = LAYOUT_ergodox_ez_wrapper(
  _______,  _______,  _______,  _______,  _______,  _______,  _______,             _______,  _______,  _______,  _______,  _______,  _______,  _______,
  _______,  _________________QWERTY_L1_________________,      _______,             _______,      _________________QWERTY_R1_________________,  _______,
  _______,  _________________QWERTY_L2_________________,                                         _________________QWERTY_R2_________________,  _______,
  _______,  _________________QWERTY_L3_________________,      _______,             _______,      _________________QWERTY_R3_________________,  _______,
  _______,  _______,  _______,  _______,  _MODL1_,                                                     _MODR1_,  _______,  _______,  _______,  _______,

                                                     _______, _______,             _______, _______,
                                                              _______,             _______,
                                            ______MODL2_____, _______,             _______, ______MODR2_____
),

[COLEMAK] = LAYOUT_ergodox_ez_wrapper(
  _______,  _______,  _______,  _______,  _______,  _______,  _______,             _______,  _______,  _______,  _______,  _______,  _______,  _______,
  _______,  _________________COLEMAK_L1________________,      _______,             _______,      _________________COLEMAK_R1________________,  _______,
  _______,  _________________COLEMAK_L2________________,                                         _________________COLEMAK_R2________________,  _______,
  _______,  _________________COLEMAK_L3________________,      _______,             _______,      _________________COLEMAK_R3________________,  _______,
  _______,  _______,  _______,  _______,  _MODL1_,                                                     _MODR1_,  _______,  _______,  _______,  _______,

                                                     _______, _______,             _______, _______,
                                                              _______,             _______,
                                            ______MODL2_____, _______,             _______, ______MODR2_____
),

[LOWER] = LAYOUT_ergodox_ez_wrapper(
  _______,  _______,  _______,  _______,  _______,  _______,  _______,             _______,  _______,  _______,  _______,  _______,  _______,  _______,
  _______,  __________________LOWER_L1_________________,        RESET,               RESET,      __________________LOWER_R1_________________,  _______,
  _______,  __________________LOWER_L2_________________,                                         __________________LOWER_R2_________________,  _______,
  _______,  __________________LOWER_L3_________________,      _______,             _______,      __________________LOWER_R3_________________,  _______,
  _______,  _______,  _______,  _______,  _LOWL1_,                                                     _LOWL1_,  _______,  _______,  _______,  _______,

                                                     _______, _______,             _______, _______,
                                                              _______,             _______,
                                            ______LOWL2_____, _______,             _______, ______LOWR2_____
),

[RAISE] = LAYOUT_ergodox_ez_wrapper(
  _______,  _______,  _______,  _______,  _______,  _______,  _______,             _______,  _______,  _______,  _______,  _______,  _______,  _______,
  _______,  __________________RAISE_L1_________________,        RESET,               RESET,      __________________RAISE_R1_________________,  _______,
  _______,  __________________RAISE_L2_________________,                                         __________________RAISE_R2_________________,  _______,
  _______,  __________________RAISE_L3_________________,      _______,             _______,      __________________RAISE_R3_________________,  _______,
  _______,  _______,  _______,  _______,  _RAIL1_,                                                     _RAIR1_,  _______,  _______,  _______,  _______,

                                                     _______, _______,             _______, _______,
                                                              _______,             _______,
                                            ______RAIL2_____, _______,             _______, ______RAIR2_____
),

[ADJUST] = LAYOUT_ergodox_ez_wrapper(
  _______,  _______,  _______,  _______,  _______,  _______,  _______,             _______,  _______,  _______,  _______,  _______,  _______,  _______,
  _______,  __________________ADJUST_L1________________,        RESET,               RESET,      __________________ADJUST_R1________________,  _______,
  _______,  __________________ADJUST_L2________________,                                         __________________ADJUST_R2________________,  _______,
  _______,  __________________ADJUST_L3________________,      _______,             _______,      __________________ADJUST_R3________________,  _______,
  _______,  _______,  _______,  _______,  _ADJL1_,                                                     _ADJR1_,  _______,  _______,  _______,  _______,

                                                     _______, _______,             _______, _______,
                                                              _______,             _______,
                                            ______ADJL2_____, _______,             _______, ______ADJR2_____
),

[MOUSE] = LAYOUT_ergodox_ez_wrapper(
  _______,  _______,  _______,  _______,  _______,  _______,  _______,             _______,  _______,  _______,  _______,  _______,  _______,  _______,
  _______,  _________________MOUSE_L1__________________,        RESET,             RESET  ,      _________________MOUSE_R1__________________,  _______,
  _______,  _________________MOUSE_L2__________________,                                         _________________MOUSE_R2__________________,  _______,
  _______,  _________________MOUSE_L3__________________,      _______,             _______,      _________________MOUSE_R3__________________,  _______,
  _______,  _______,  _______,  _______,  _MOUL1_,                                                     _MOUR1_,  _______,  _______,  _______,  _______,

                                                     _______, _______,             _______, _______,
                                                              _______,             _______,
                                            ______MOUL2_____, _______,             _______, ______MOUR2_____
),

};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
    switch (keycode) {
      case VRSN:
        SEND_STRING (QMK_KEYBOARD "/" QMK_KEYMAP " @ " QMK_VERSION);
        return false;
      #ifdef RGBLIGHT_ENABLE
      case RGB_SLD:
        rgblight_mode(1);
        return false;
      #endif
    }
  }
  return true;
}

/* // Runs just one time when the keyboard initializes. */
/* void keyboard_post_init_user(void) { */
/* #ifdef RGBLIGHT_COLOR_LAYER_0 */
/*   rgblight_setrgb(RGBLIGHT_COLOR_LAYER_0); */
/* #endif */
/* }; */

/* // Runs whenever there is a layer state change. */
/* layer_state_t layer_state_set_user(layer_state_t state) { */
/*   ergodox_board_led_off(); */
/*   ergodox_right_led_1_off(); */
/*   ergodox_right_led_2_off(); */
/*   ergodox_right_led_3_off(); */

/*   uint8_t layer = get_highest_layer(state); */
/*   switch (layer) { */
/*       case 0: */
/*         #ifdef RGBLIGHT_COLOR_LAYER_0 */
/*           rgblight_setrgb(RGBLIGHT_COLOR_LAYER_0); */
/*         #endif */
/*         break; */
/*       case 1: */
/*         ergodox_right_led_1_on(); */
/*         #ifdef RGBLIGHT_COLOR_LAYER_1 */
/*           rgblight_setrgb(RGBLIGHT_COLOR_LAYER_1); */
/*         #endif */
/*         break; */
/*       case 2: */
/*         ergodox_right_led_2_on(); */
/*         #ifdef RGBLIGHT_COLOR_LAYER_2 */
/*           rgblight_setrgb(RGBLIGHT_COLOR_LAYER_2); */
/*         #endif */
/*         break; */
/*       case 3: */
/*         ergodox_right_led_3_on(); */
/*         #ifdef RGBLIGHT_COLOR_LAYER_3 */
/*           rgblight_setrgb(RGBLIGHT_COLOR_LAYER_3); */
/*         #endif */
/*         break; */
/*       case 4: */
/*         ergodox_right_led_1_on(); */
/*         ergodox_right_led_2_on(); */
/*         #ifdef RGBLIGHT_COLOR_LAYER_4 */
/*           rgblight_setrgb(RGBLIGHT_COLOR_LAYER_4); */
/*         #endif */
/*         break; */
/*       case 5: */
/*         ergodox_right_led_1_on(); */
/*         ergodox_right_led_3_on(); */
/*         #ifdef RGBLIGHT_COLOR_LAYER_5 */
/*           rgblight_setrgb(RGBLIGHT_COLOR_LAYER_5); */
/*         #endif */
/*         break; */
/*       case 6: */
/*         ergodox_right_led_2_on(); */
/*         ergodox_right_led_3_on(); */
/*         #ifdef RGBLIGHT_COLOR_LAYER_6 */
/*           rgblight_setrgb(RGBLIGHT_COLOR_LAYER_6); */
/*         #endif */
/*         break; */
/*       case 7: */
/*         ergodox_right_led_1_on(); */
/*         ergodox_right_led_2_on(); */
/*         ergodox_right_led_3_on(); */
/*         #ifdef RGBLIGHT_COLOR_LAYER_7 */
/*           rgblight_setrgb(RGBLIGHT_COLOR_LAYER_7); */
/*         #endif */
/*         break; */
/*       default: */
/*         break; */
/*     } */

/*   return state; */
/* }; */
