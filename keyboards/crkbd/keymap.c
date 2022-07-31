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
#include "thanatchaya.h"

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [QWERTY] = LAYOUT_crkbd_wrapper(
    _______, _________________QWERTY_L1_________________,  _________________QWERTY_R1_________________, _______,
    _______, _________________QWERTY_L2_________________,  _________________QWERTY_R2_________________, _______,
    _______, _________________QWERTY_L3_________________,  _________________QWERTY_R3_________________, _______,
                               _______MODIFIER_L________,  _______MODIFIER_R________
  ),

  [COLEMAK] = LAYOUT_crkbd_wrapper(
    _______, _________________COLEMAK_L1________________,  _________________COLEMAK_R1________________, _______,
    _______, _________________COLEMAK_L2________________,  _________________COLEMAK_R2________________, _______,
    _______, _________________COLEMAK_L3________________,  _________________COLEMAK_R3________________, _______,
                               _______MODIFIER_L________,  _______MODIFIER_R________
  ),

  [GAMER] = LAYOUT_crkbd_wrapper(
    ___________________________GAMER_L1_________________,  __________________GAMER_R1_________________, _______,
    ___________________________GAMER_L2_________________,  __________________GAMER_R2_________________, _______,
    ___________________________GAMER_L3_________________,  __________________GAMER_R3_________________, _______,
                               _______MODIFIER_L________,  _______MODIFIER_R________
  ),

  [LOWER] = LAYOUT_crkbd_wrapper(
    _______, __________________LOWER_L1_________________,  __________________LOWER_R1_________________, _______,
    _______, __________________LOWER_L2_________________,  __________________LOWER_R2_________________, _______,
    RESET  , __________________LOWER_L3_________________,  __________________LOWER_R3_________________, _______,
                               _________LOWER_L4________,  _________LOWER_R4________
  ),

  [RAISE] = LAYOUT_crkbd_wrapper(
    _______, __________________RAISE_L1_________________,  __________________RAISE_R1_________________, _______,
    _______, __________________RAISE_L2_________________,  __________________RAISE_R2_________________, _______,
    RESET  , __________________RAISE_L3_________________,  __________________RAISE_R3_________________, _______,
                               _________RAISE_L4________,  _________RAISE_R4________
  ),

  [ADJUST] = LAYOUT_crkbd_wrapper(
    _______, __________________ADJUST_L1________________,  __________________ADJUST_R1________________, _______,
    _______, __________________ADJUST_L2________________,  __________________ADJUST_R2________________, _______,
    RESET  , __________________ADJUST_L3________________,  __________________ADJUST_R3________________, _______,
                               ________ADJUST_L4________,  ________ADJUST_R4________
  ),

  [MOUSE] = LAYOUT_crkbd_wrapper(
    _______, _________________MOUSE_L1__________________,  _________________MOUSE_R1__________________, _______,
    _______, _________________MOUSE_L2__________________,  _________________MOUSE_R2__________________, _______,
    RESET  , _________________MOUSE_L3__________________,  _________________MOUSE_R3__________________, _______,
                               _______MOUSE_L4__________,  _______MOUSE_R4__________
  ),
};
