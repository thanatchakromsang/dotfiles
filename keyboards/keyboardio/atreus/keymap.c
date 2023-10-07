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
  [QWERTY] = LAYOUT_keyboardio_atreus_wrapper(
    _________________QWERTY_L1_________________,                    _________________QWERTY_R1_________________,
    _________________QWERTY_L2_________________,                    _________________QWERTY_R2_________________,
    _________________QWERTY_L3_________________, _______,  _______, _________________QWERTY_R3_________________,
    _______, _______, _______, _______MODIFIER_L________,  _______MODIFIER_R________, _______, _______, _______
  ),

  [COLEMAK] = LAYOUT_keyboardio_atreus_wrapper(
    _________________COLEMAK_L1________________,                    _________________COLEMAK_R1________________,
    _________________COLEMAK_L2________________,                    _________________COLEMAK_R2________________,
    _________________COLEMAK_L3________________, _______,  _______, _________________COLEMAK_R3________________,
    _______, _______, _______, _______MODIFIER_L________,  _______MODIFIER_R________, _______, _______, _______
  ),

  [GAMER] = LAYOUT_keyboardio_atreus_wrapper(
    __________________GAMER_L1_________________,                    __________________GAMER_R1_________________,
    __________________GAMER_L2_________________,                    __________________GAMER_R2_________________,
    __________________GAMER_L3_________________, _______,  _______, __________________GAMER_R3_________________,
    _______, _______, _______, _______GAMER_L4__________,  _______GAMER_R4__________, _______, _______, _______
  ),

  [LOWER] = LAYOUT_keyboardio_atreus_wrapper(
    __________________LOWER_L1_________________,                    __________________LOWER_R1_________________,
    __________________LOWER_L2_________________,                    __________________LOWER_R2_________________,
    __________________LOWER_L3_________________, _______,  _______, __________________LOWER_R3_________________,
    RESET  , _______, _______, _________LOWER_L4________,  _________LOWER_R4________, _______, _______, _______
  ),

  [RAISE] = LAYOUT_keyboardio_atreus_wrapper(
    __________________RAISE_L1_________________,                    __________________RAISE_R1_________________,
    __________________RAISE_L2_________________,                    __________________RAISE_R2_________________,
    __________________RAISE_L3_________________, _______,  _______, __________________RAISE_R3_________________,
    RESET  , _______, _______, _________RAISE_L4________,  _________RAISE_R4________, _______, _______, _______
  ),

  [ADJUST] = LAYOUT_keyboardio_atreus_wrapper(
    __________________ADJUST_L1________________,                    __________________ADJUST_R1________________,
    __________________ADJUST_L2________________,                    __________________ADJUST_R2________________,
    __________________ADJUST_L3________________, _______,  _______, __________________ADJUST_R3________________,
    _______, _______, _______, ________ADJUST_L4________,  ________ADJUST_R4________, _______, _______, _______
  ),


  [MOUSE] = LAYOUT_keyboardio_atreus_wrapper(
    _________________MOUSE_L1__________________,                    _________________MOUSE_R1__________________,
    _________________MOUSE_L2__________________,                    _________________MOUSE_R2__________________,
    _________________MOUSE_L3__________________, _______,  _______, _________________MOUSE_R3__________________,
    RESET  , _______, _______, _______MOUSE_L4__________,  _______MOUSE_R4__________, _______, _______, _______
  ),
};
