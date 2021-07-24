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

#pragma once

#include "quantum.h"
#include "version.h"

enum user_layers {
  QWERTY_LAYER,
  COLEMAK_LAYER,
  NUMBER_LAYER,
  SYMBOL_LAYER,
  FUNCTION_LAYER,
  NAVIGATION_LAYER,
  MOUSE_LAYER,
  MEDIA_LAYER
};

/* enum user_keycodes { */
/*   QWERTY = SAFE_RANGE, */
/*   WORKMAN */
/* }; */

// Alias layout macros that expand groups of keys.
#define LAYOUT_ergodox_ez_wrapper(...) LAYOUT_ergodox_pretty(__VA_ARGS__)
#define LAYOUT_keyboardio_atreus_wrapper(...) LAYOUT(__VA_ARGS__)
#define LAYOUT_crkbd_wrapper(...) LAYOUT(__VA_ARGS__)

  /* ---------------------------------------------------------------------
   *
   *   Qwerty Layout
   *
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │  Q  │  W  │  E  │  R  │  T  │   │  Y  │  U  │  I  │  O  │  P  │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │ A/⇧ │ S/^ │ D/⌥ │ F/⌘ │  G  │   │  H  │ J/⌘ │ K/⌥ │ L/^ │ ;/⇧ │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │  Z  │  X  │  C  │  V  │  B  │   │  N  │  M  │  ,  │  .  │  /  │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   */

#define _________________QWERTY_L1_________________ KC_Q,         KC_W,         KC_E,         KC_R,         KC_T
#define _________________QWERTY_L2_________________ LSFT_T(KC_A), LCTL_T(KC_S), LALT_T(KC_D), LGUI_T(KC_F), KC_G
#define _________________QWERTY_L3_________________ KC_Z,         KC_X,         KC_C,         KC_V,         KC_B

#define _________________QWERTY_R1_________________ KC_Y, KC_U,         KC_I,         KC_O,         KC_P
#define _________________QWERTY_R2_________________ KC_H, LGUI_T(KC_J), LALT_T(KC_K), LCTL_T(KC_L), LSFT_T(KC_SCLN)
#define _________________QWERTY_R3_________________ KC_N, KC_M,         KC_COMM,      KC_DOT,       KC_SLSH

  /* ---------------------------------------------------------------------
   *
   *   Colemak Layout
   *
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │  Q  │  W  │  F  │  P  │  B  │   │  J  │  L  │  U  │  Y  │  ;  │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │ A/⇧ │ R/^ │ S/⌥ │ T/⌘ │  G  │   │  M  │ N/⌘ │ E/⌥ │ I/^ │ O/⇧ │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │  Z  │  X  │  C  │  D  │  V  │   │  K  │  H  │  ,  │  .  │  /  │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   */

#define _________________COLEMAK_L1________________ KC_Q,         KC_W,         KC_F,         KC_P,         KC_B
#define _________________COLEMAK_L2________________ LSFT_T(KC_A), LCTL_T(KC_R), LALT_T(KC_S), LGUI_T(KC_T), KC_G
#define _________________COLEMAK_L3________________ KC_Z,         KC_X,         KC_C,         KC_D,         KC_V

#define _________________COLEMAK_R1________________ KC_J, KC_L,         KC_U,         KC_Y,         KC_SCLN
#define _________________COLEMAK_R2________________ KC_M, LGUI_T(KC_N), LALT_T(KC_E), LCTL_T(KC_I), LSFT_T(KC_O)
#define _________________COLEMAK_R3________________ KC_K, KC_H,         KC_COMM,      KC_DOT,       KC_SLSH

  /* ---------------------------------------------------------------------
   *
   *   Modifier on base layer
   *                 ┌─────┬─────┬─────┐   ┌─────┬─────┬─────┐
   *                 │ Esc │BSpc │ Tab │   │Enter│ Spc │  '  │
   *                 └─────┴─────┴─────┘   └─────┴─────┴─────┘
   *                    |     |     |         |     |     |
   *                    V     |     |         V     |     |
   *              TG(MEDIA_LAYER)   |   TG(SYMBOL_LAYER)  |
   *                          |     |               |     |
   *                          V     |               V     |
   *                  TG(NAVIGATION_LAYER)    TG(NUMBER_LAYER)
   *                                |                     |
   *                                V                     V
   *                        TG(MOUSE_LAYER)       TG(FUNCTION_LAYER)
   */

#define _MODL1_ LT(MEDIA_LAYER, KC_ESC)
#define ______MODL2_____ LT(NAVIGATION_LAYER, KC_BSPC), LT(MOUSE_LAYER, KC_TAB)
#define _______MODIFIER_L________ _MODL1_, ______MODL2_____

#define ______MODR2_____ LT(SYMBOL_LAYER, KC_ENT), LT(NUMBER_LAYER, KC_SPC)
#define _MODR1_ LT(FUNCTION_LAYER, KC_QUOT)
#define _______MODIFIER_R________ ______MODR2_____, _MODR1_

  /* ---------------------------------------------------------------------
   *
   *   Number Layer
   *      ┌─────┬─────┬─────┬─────┬─────┐  ┌─────┬─────┬─────┬─────┬─────┐
   *      │  [  │  7  │  8  │  9  │  ]  │  │     │     │     │     │     │
   *      ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤
   *      │ XXX │  4  │  5  │  6  │  =  │  │     │     │     │     │     │
   *      ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤
   *      │  `  │  1  │  2  │  3  │  \  │  │     │     │     │     │     │
   *      └─────┴─────┴─────┴─────┴─────┘  └─────┴─────┴─────┴─────┴─────┘
   *                 ┌─────┐┌─────┬─────┐  ┌─────┬─────┐┌─────┐
   *                 │  .  ││  0  │  -  │  │     │ XXX ││     │
   *                 └─────┘└─────┴─────┘  └─────┴─────┘└─────┘
   */

#define _________________NUMBER_L1_________________ KC_LBRC, KC_7, KC_8, KC_9, KC_RBRC
#define _________________NUMBER_L2_________________ XXXXXXX, KC_4, KC_5, KC_6, KC_EQL
#define _________________NUMBER_L3_________________ KC_GRV,  KC_1, KC_2, KC_3, KC_BSLS

#define _NUML1_ KC_DOT
#define ______NUML2_____ KC_0, KC_MINS
#define _______NUMBER_L4_________ _NUML1_, ______NUML2_____

#define _________________NUMBER_R1_________________ _________________TRANSPARENT_______________
#define _________________NUMBER_R2_________________ _________________TRANSPARENT_______________
#define _________________NUMBER_R3_________________ _________________TRANSPARENT_______________

#define ______NUMR2_____ _______, _______
#define _NUMR1_ _______
#define _______NUMBER_R4_________ ______NUMR2_____, _NUMR1_

  /* ---------------------------------------------------------------------
   *
   *   Symbol Layer
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │  {  │  &  │  *  │  (  │  }  │   │     │     │     │     │     │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │ XXX │  $  │  %  │  ^  │  +  │   │     │     │     │     │     │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │  ~  │  !  │  @  │  #  │  |  │   │     │     │     │     │     │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   *                ┌─────┐┌─────┬─────┐   ┌─────┬─────┐┌─────┐
   *                │  >  ││  )  │  _  │   │ XXX │     ││     │
   *                └─────┘└─────┴─────┘   └─────┴─────┘└─────┘
   */

#define _________________SYMBOL_L1_________________ KC_LCBR,  KC_AMPR, KC_ASTR, KC_LPRN, KC_RCBR
#define _________________SYMBOL_L2_________________ XXXXXXX, KC_DLR,  KC_PERC, KC_CIRC, KC_PLUS
#define _________________SYMBOL_L3_________________ KC_TILDE, KC_EXLM, KC_AT,   KC_HASH, KC_PIPE

#define _SYML1_ KC_GT
#define ______SYML2_____ KC_RPRN, KC_UNDS
#define _______SYMBOL_L4_________ _SYML1_, ______SYML2_____

#define _________________SYMBOL_R1_________________ _________________TRANSPARENT_______________
#define _________________SYMBOL_R2_________________ _________________TRANSPARENT_______________
#define _________________SYMBOL_R3_________________ _________________TRANSPARENT_______________

#define _SYMR1_ _______
#define ______SYMR2_____ _______, _______
#define _______SYMBOL_R4_________ ______SYMR2_____, _SYMR1_

  /* ---------------------------------------------------------------------
   *
   *   Function / Window Layer
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │ F12 │ F7  │ F8  │ F9  │PrScn│   │     │     │     │     │     │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │ F11 │ F4  │ F5  │ F6  │ Del │   │     │     │     │     │     │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │ F10 │ F1  │ F2  │ F3  │Pause│   │     │     │     │     │     │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   *
   *                ┌─────┐┌─────┬─────┐   ┌─────┬─────┐┌─────┐
   *                │ ESC ││BSpc │ Tab │   │     │     ││ XXX │
   *                └─────┘└─────┴─────┘   └─────┴─────┘└─────┘
   */

#define _________________FUNCTION_L1_______________ KC_F12, KC_F7, KC_F8, KC_F9, KC_PSCR
#define _________________FUNCTION_L2_______________ KC_F11, KC_F4, KC_F5, KC_F6, KC_DEL
#define _________________FUNCTION_L3_______________ KC_F10, KC_F1, KC_F2, KC_F3, KC_PAUSE

#define _FUNL1_ KC_ESC
#define ______FUNL2_____ KC_BSPC, KC_TAB
#define _______FUNCTION_L4_______ _FUNL1_, ______FUNL2_____

#define _________________FUNCTION_R1_______________ _________________TRANSPARENT_______________
#define _________________FUNCTION_R2_______________ _________________TRANSPARENT_______________
#define _________________FUNCTION_R3_______________ _________________TRANSPARENT_______________
#define ______FUNR2_____ _______, _______
#define _FUNR1_ _______
#define _______FUNCTION_R4_______ ______FUNR2_____, _FUNR1_

  /* ---------------------------------------------------------------------
   *
   *   Disabled
   *     ┌─────┬─────┬─────┬─────┬─────┐
   *     │ XXX │ XXX │ XXX │ XXX │ XXX │
   *     └─────┴─────┴─────┴─────┴─────┘
   */

#define _________________DISABLED__________________ XXXXXXX,    XXXXXXX,   XXXXXXX,     XXXXXXX,     XXXXXXX

  /* ---------------------------------------------------------------------
   *
   *   Layer Switcher
   *     ┌─────┬─────┬─────┬─────┬─────┐
   *     │LANG │QWRTY│     │     │COLE │
   *     └─────┴─────┴─────┴─────┴─────┘
   */

#define _________________LANGUAGE_SWITCHER_________ LALT(KC_SPC),    TO(QWERTY_LAYER),   XXXXXXX,     XXXXXXX,     TO(COLEMAK_LAYER)

  /* ---------------------------------------------------------------------
   *
   *   Transparent
   *     ┌─────┬─────┬─────┬─────┬─────┐
   *     │     │     │     │     │     │
   *     └─────┴─────┴─────┴─────┴─────┘
   */

#define _________________TRANSPARENT_______________ _______, _______, _______, _______, _______

  /* ---------------------------------------------------------------------
   *
   *   Navigation Layer
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │     │     │     │     │     │   │Home │PgDn │PgUp │ End │ XXX │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │   │  ←  │  ↓  │  ↑  │  →  │ XXX │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │   │ XXX │ XXX │ XXX │ XXX │ XXX │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   *                ┌─────┐┌─────┬─────┐   ┌─────┬─────┐┌─────┐
   *                │     ││ XXX │     │   │Enter│ Spc ││     │
   *                └─────┘└─────┴─────┘   └─────┴─────┘└─────┘
   */

#define _________________NAVIGATION_L1_____________ _________________TRANSPARENT_______________
#define _________________NAVIGATION_L2_____________ _________________TRANSPARENT_______________
#define _________________NAVIGATION_L3_____________ _________________TRANSPARENT_______________

#define _NAVL1_ _______
#define ______NAVL2_____ _______, _______
#define _______NAVIGATION_L4_____ _NAVL1_, ______NAVL2_____

#define _________________NAVIGATION_R1_____________ KC_HOME,    KC_PGDN,   KC_PGUP,     KC_END,     XXXXXXX
#define _________________NAVIGATION_R2_____________ KC_LEFT,    KC_DOWN,   KC_UP,       KC_RGHT,    XXXXXXX
#define _________________NAVIGATION_R3_____________ _________________DISABLED__________________

#define ______NAVR2_____ KC_ENT, KC_SPC
#define _NAVR1_ _______
#define _______NAVIGATION_R4_____ ______NAVR2_____, _NAVR1_

  /* ---------------------------------------------------------------------
   *
   *   Mouse Layer
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │     │     │     │     │     │   │ WH↑ │ XXX │ M ↑ │ XXX │ WH→ │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │   │ WH↓ │ M ← │ M ↓ │ M → │ WH← │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │   │ XXX │ XXX │ XXX │ XXX │ XXX │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   *                ┌─────┐┌─────┬─────┐   ┌─────┬─────┐┌─────┐
   *                │     ││     │     │   │M-BTN│L-BTN││R-BTN│
   *                └─────┘└─────┴─────┘   └─────┴─────┘└─────┘
   */

#define _________________MOUSE_L1__________________ _________________TRANSPARENT_______________
#define _________________MOUSE_L2__________________ _________________TRANSPARENT_______________
#define _________________MOUSE_L3__________________ _________________TRANSPARENT_______________

#define _MOUL1_ _______
#define ______MOUL2_____ _______, _______
#define _______MOUSE_L4__________ _MOUL1_, ______MOUL2_____

#define _________________MOUSE_R1__________________ KC_WH_U, XXXXXXX, KC_MS_U, XXXXXXX, KC_WH_R
#define _________________MOUSE_R2__________________ KC_WH_D, KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_L
#define _________________MOUSE_R3__________________ _________________DISABLED__________________

#define _MOUR1_ KC_BTN2
#define ______MOUR2_____ KC_BTN3, KC_BTN1
#define _______MOUSE_R4__________ ______MOUR2_____, _MOUR1_

  /* ---------------------------------------------------------------------
   *
   *   Media Layer
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │     │     │     │     │     │   │ XXX │ XXX │ XXX │ XXX │    │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │   │  ◀  │    │    │  ▶  │    │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │   │ XXX │ XXX │ XXX │ XXX │ XXX │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   *                ┌─────┐┌─────┬─────┐   ┌─────┬─────┐┌─────┐
   *                │     ││     │     │   │    │    ││     │
   *                └─────┘└─────┴─────┘   └─────┴─────┘└─────┘
   */

#define _________________MEDIA_L1__________________ _________________LANGUAGE_SWITCHER_________
#define _________________MEDIA_L2__________________ _________________TRANSPARENT_______________
#define _________________MEDIA_L3__________________ _________________TRANSPARENT_______________

#define _MEDL1_ _______
#define ______MEDL2_____ _______, _______
#define _______MEDIA_L4__________ _MEDL1_, ______MEDL2_____

#define _________________MEDIA_R1__________________ XXXXXXX,    XXXXXXX,       XXXXXXX,       XXXXXXX,    KC_F20
#define _________________MEDIA_R2__________________ KC_MPRV,    KC__VOLDOWN,   KC__VOLUP,     KC_MNXT,    KC__MUTE
#define _________________MEDIA_R3__________________ _________________DISABLED__________________

#define ______MEDR2_____ KC_MSTP, KC_MPLY
#define _MEDR1_ _______
#define _______MEDIA_R4__________ ______MEDL2_____, _MEDL1_
