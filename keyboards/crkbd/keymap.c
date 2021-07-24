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
  [QWERTY_LAYER] = LAYOUT_crkbd_wrapper(
    _______, _________________QWERTY_L1_________________,  _________________QWERTY_R1_________________, _______,
    _______, _________________QWERTY_L2_________________,  _________________QWERTY_R2_________________, _______,
    _______, _________________QWERTY_L3_________________,  _________________QWERTY_R3_________________, _______,
                               _______MODIFIER_L________,  _______MODIFIER_R________
  ),

  [COLEMAK_LAYER] = LAYOUT_crkbd_wrapper(
    _______, _________________COLEMAK_L1________________,  _________________COLEMAK_R1________________, _______,
    _______, _________________COLEMAK_L2________________,  _________________COLEMAK_R2________________, _______,
    _______, _________________COLEMAK_L3________________,  _________________COLEMAK_R3________________, _______,
                               _______MODIFIER_L________,  _______MODIFIER_R________
  ),

  [NUMBER_LAYER] = LAYOUT_crkbd_wrapper(
    _______, _________________NUMBER_L1_________________,  _________________NUMBER_R1_________________, _______,
    _______, _________________NUMBER_L2_________________,  _________________NUMBER_R2_________________, _______,
    RESET  , _________________NUMBER_L3_________________,  _________________NUMBER_R3_________________, _______,
                               _______NUMBER_L4_________,  _______NUMBER_R4_________
  ),

  [SYMBOL_LAYER] = LAYOUT_crkbd_wrapper(
    _______, _________________SYMBOL_L1_________________,  _________________SYMBOL_R1_________________, _______,
    _______, _________________SYMBOL_L2_________________,  _________________SYMBOL_R2_________________, _______,
    RESET  , _________________SYMBOL_L3_________________,  _________________SYMBOL_R3_________________, _______,
                               _______SYMBOL_L4_________,  _______SYMBOL_R4_________
  ),

  [FUNCTION_LAYER] = LAYOUT_crkbd_wrapper(
    _______, _________________FUNCTION_L1_______________,  _________________FUNCTION_R1_______________, _______,
    _______, _________________FUNCTION_L2_______________,  _________________FUNCTION_R2_______________, _______,
    RESET  , _________________FUNCTION_L3_______________,  _________________FUNCTION_R3_______________, _______,
                               _______FUNCTION_L4_______,  _______FUNCTION_R4_______
  ),

  [NAVIGATION_LAYER] = LAYOUT_crkbd_wrapper(
    _______, _________________NAVIGATION_L1_____________,  _________________NAVIGATION_R1_____________, _______,
    _______, _________________NAVIGATION_L2_____________,  _________________NAVIGATION_R2_____________, _______,
    RESET  , _________________NAVIGATION_L3_____________,  _________________NAVIGATION_R3_____________, _______,
                               _______NAVIGATION_L4_____,  _______NAVIGATION_R4_____
  ),

  [MOUSE_LAYER] = LAYOUT_crkbd_wrapper(
    _______, _________________MOUSE_L1__________________,  _________________MOUSE_R1__________________, _______,
    _______, _________________MOUSE_L2__________________,  _________________MOUSE_R2__________________, _______,
    RESET  , _________________MOUSE_L3__________________,  _________________MOUSE_R3__________________, _______,
                               _______MOUSE_L4__________,  _______MOUSE_R4__________
  ),

  [MEDIA_LAYER] = LAYOUT_crkbd_wrapper(
    _______, _________________MEDIA_L1__________________,  _________________MEDIA_R1__________________, _______,
    _______, _________________MEDIA_L2__________________,  _________________MEDIA_R2__________________, _______,
    RESET  , _________________MEDIA_L3__________________,  _________________MEDIA_R3__________________, _______,
                               _______MEDIA_L4__________,  _______MEDIA_R4__________
  )
};
