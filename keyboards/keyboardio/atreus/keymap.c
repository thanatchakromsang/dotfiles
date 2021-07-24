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
  [QWERTY_LAYER] = LAYOUT_keyboardio_atreus_wrapper(
    _________________QWERTY_L1_________________,                    _________________QWERTY_R1_________________,
    _________________QWERTY_L2_________________,                    _________________QWERTY_R2_________________,
    _________________QWERTY_L3_________________, _______,  _______, _________________QWERTY_R3_________________,
    _______, _______, _______, _______MODIFIER_L________,  _______MODIFIER_R________, _______, _______, _______
  ),

  [COLEMAK_LAYER] = LAYOUT_keyboardio_atreus_wrapper(
    _________________COLEMAK_L1________________,                    _________________COLEMAK_R1________________,
    _________________COLEMAK_L2________________,                    _________________COLEMAK_R2________________,
    _________________COLEMAK_L3________________, _______,  _______, _________________COLEMAK_R3________________,
    _______, _______, _______, _______MODIFIER_L________,  _______MODIFIER_R________, _______, _______, _______
  ),

  [NUMBER_LAYER] = LAYOUT_keyboardio_atreus_wrapper(
    _________________NUMBER_L1_________________,                    _________________NUMBER_R1_________________,
    _________________NUMBER_L2_________________,                    _________________NUMBER_R2_________________,
    _________________NUMBER_L3_________________, _______,  _______, _________________NUMBER_R3_________________,
    RESET  , _______, _______, _______NUMBER_L4_________,  _______NUMBER_R4_________, _______, _______, _______
  ),

  [SYMBOL_LAYER] = LAYOUT_keyboardio_atreus_wrapper(
    _________________SYMBOL_L1_________________,                    _________________SYMBOL_R1_________________,
    _________________SYMBOL_L2_________________,                    _________________SYMBOL_R2_________________,
    _________________SYMBOL_L3_________________, _______,  _______, _________________SYMBOL_R3_________________,
    RESET  , _______, _______, _______SYMBOL_L4_________,  _______SYMBOL_R4_________, _______, _______, _______
  ),

  [FUNCTION_LAYER] = LAYOUT_keyboardio_atreus_wrapper(
    _________________FUNCTION_L1_______________,                    _________________FUNCTION_R1_______________,
    _________________FUNCTION_L2_______________,                    _________________FUNCTION_R2_______________,
    _________________FUNCTION_L3_______________, _______,  _______, _________________FUNCTION_R3_______________,
    RESET  , _______, _______, _______FUNCTION_L4_______,  _______FUNCTION_R4_______, _______, _______, _______
  ),

  [NAVIGATION_LAYER] = LAYOUT_keyboardio_atreus_wrapper(
    _________________NAVIGATION_L1_____________,                    _________________NAVIGATION_R1_____________,
    _________________NAVIGATION_L2_____________,                    _________________NAVIGATION_R2_____________,
    _________________NAVIGATION_L3_____________, _______,  _______, _________________NAVIGATION_R3_____________,
    RESET  , _______, _______, _______NAVIGATION_L4_____,  _______NAVIGATION_R4_____, _______, _______, _______
  ),

  [MOUSE_LAYER] = LAYOUT_keyboardio_atreus_wrapper(
    _________________MOUSE_L1__________________,                    _________________MOUSE_R1__________________,
    _________________MOUSE_L2__________________,                    _________________MOUSE_R2__________________,
    _________________MOUSE_L3__________________, _______,  _______, _________________MOUSE_R3__________________,
    RESET  , _______, _______, _______MOUSE_L4__________,  _______MOUSE_R4__________, _______, _______, _______
  ),

  [MEDIA_LAYER] = LAYOUT_keyboardio_atreus_wrapper(
    _________________MEDIA_L1__________________,                    _________________MEDIA_R1__________________,
    _________________MEDIA_L2__________________,                    _________________MEDIA_R2__________________,
    _________________MEDIA_L3__________________, _______,  _______, _________________MEDIA_R3__________________,
    RESET  , _______, _______, _______MEDIA_L4__________,  _______MEDIA_R4__________, _______, _______, _______
  )
};
