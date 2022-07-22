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
  QWERTY,
  COLEMAK,
  LOWER,
  RAISE,
  ADJUST,
  MOUSE,
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
   *   QWERTY Layout
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
   *   COLEMAK Layout
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
   *                 │ Esc │ NAV │ Tab │   │Enter│ SPC │  '  │
   *                 └─────┴─────┴─────┘   └─────┴─────┴─────┘
   *                          |                     |
   *                          |                     |
   *                          |                     |
   *                          |                     |
   *                          V                     V
   *                      MO(LOWER)         LT(RAISE, KC_SPC)
   *
   *
   *
   */

#define _MODL1_ KC_ESC
#define ______MODL2_____ MO(LOWER), KC_TAB
#define _______MODIFIER_L________ _MODL1_, ______MODL2_____

#define ______MODR2_____ KC_ENT, LT(RAISE, KC_SPC)
#define _MODR1_ KC_QUOT
#define _______MODIFIER_R________ ______MODR2_____, _MODR1_


  /* ---------------------------------------------------------------------
   *
   *   LOWER
   *     ┌─────┬─────┬─────┬─────┬─────┐    ┌─────┬─────┬─────┬─────┬─────┐
   *     │ DEL │MOUSE│     │     │     │    │Home │PgDn │PgUp │ End │ DEL │
   *     ├─────┼─────┼─────┼─────┼─────┤    ├─────┼─────┼─────┼─────┼─────┤
   *     │BSPC │     │     │     │     │    │  ←  │  ↓  │  ↑  │  →  │BSPC │
   *     ├─────┼─────┼─────┼─────┼─────┤    ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │    │ XXX │ XXX │ XXX │ XXX │ XXX │
   *     └─────┴─────┴─────┴─────┴─────┘    └─────┴─────┴─────┴─────┴─────┘
   *                ┌─────┐┌─────┬─────┐    ┌─────┬─────┐┌─────┐
   *                │     ││     │     │    │     │     ││     │
   *                └─────┘└─────┴─────┘    └─────┴─────┘└─────┘
   */

#define __________________LOWER_L1_________________ KC_DEL, LT(MOUSE, KC_7), KC_8, KC_9, KC_0
#define __________________LOWER_L2_________________ LSFT_T(KC_BSPC), LCTL_T(KC_4), LALT_T(KC_5), LGUI_T(KC_6), KC_EQL
#define __________________LOWER_L3_________________ __________________RAISE_L3_________________

#define _LOWL1_ _______
#define ______LOWL2_____ _______, _______
#define _________LOWER_L4________ _LOWL1_, ______LOWL2_____

#define __________________LOWER_R1_________________ KC_HOME,    KC_PGDN,   KC_PGUP,     KC_END,     KC_DEL
#define __________________LOWER_R2_________________ KC_LEFT,    KC_DOWN,   KC_UP,       KC_RGHT,    KC_BSPC
#define __________________LOWER_R3_________________ _________________TRANSPARENT_______________

#define ______LOWR2_____ _______, _______
#define _LOWR1_ _______
#define _________LOWER_R4________ ______LOWR2_____, _LOWR1_


  /* ---------------------------------------------------------------------
   *
   *  RAISE
   *      ┌─────┬─────┬─────┬─────┬─────┐  ┌─────┬─────┬─────┬─────┬─────┐
   *      │  [  │  7  │  8  │  9  │  ]  │  │     │     │     │     │     │
   *      ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤
   *      │ 0/⇧ │ 4/^ │ 5/⌥ │ 6/⌘ │  =  │  │     │     │     │     │ ←/⇧ │
   *      ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤
   *      │  `  │  1  │  2  │  3  │  \  │  │     │     │     │     │     │
   *      └─────┴─────┴─────┴─────┴─────┘  └─────┴─────┴─────┴─────┴─────┘
   *                 ┌─────┐┌─────┬─────┐  ┌─────┬─────┐┌─────┐
   *                 │     ││     │  -  │  │     │     ││     │
   *                 └─────┘└─────┴─────┘  └─────┴─────┘└─────┘
   */

#define __________________RAISE_L1_________________ KC_LBRC, KC_7, KC_8, KC_9, KC_RBRC
#define __________________RAISE_L2_________________ LSFT_T(KC_0), LCTL_T(KC_4), LALT_T(KC_5), LGUI_T(KC_6), KC_EQL
#define __________________RAISE_L3_________________ KC_GRV,  KC_1, KC_2, KC_3, KC_BSLS

#define _RAIL1_ _______
#define ______RAIL2_____ _______, KC_MINS
#define _________RAISE_L4________ _RAIL1_, ______RAIL2_____

#define __________________RAISE_R1_________________ _________________TRANSPARENT_______________
#define __________________RAISE_R2_________________ _______, _______, _______, _______, LSFT_T(KC_BSPC)
#define __________________RAISE_R3_________________ _________________TRANSPARENT_______________

#define ______RAIR2_____ _______, _______
#define _RAIR1_ _______
#define _________RAISE_R4________ ______RAIR2_____, _RAIR1_


  /* ---------------------------------------------------------------------
   *
   *   ADJUST
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │ F12 │ F7  │ F8  │ F9  │PrScn│   │     │     │    │QWRTY│CLKMK│
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │ F10 │ F4  │ F5  │ F6  │     │   │  ◀  │    │    │  ▶  │    │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │ F11 │ F1  │ F2  │ F3  │     │   │     │     │    │     │     │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   *
   *                ┌─────┐┌─────┬─────┐   ┌─────┬─────┐┌─────┐
   *                │     ││     │     │   │     │     ││     │
   *                └─────┘└─────┴─────┘   └─────┴─────┘└─────┘
   */

#define __________________ADJUST_L1________________ KC_F12, KC_F7, KC_F8, KC_F9, KC_PSCR
#define __________________ADJUST_L2________________ KC_F10, KC_F4, KC_F5, KC_F6, _______
#define __________________ADJUST_L3________________ KC_F11, KC_F1, KC_F2, KC_F3, _______

#define _ADJL1_ _______
#define ______ADJL2_____ _______, _______
#define ________ADJUST_L4________ _ADJL1_, ______ADJL2_____

#define __________________ADJUST_R1________________ _______, _______, KC_F20, TO(QWERTY), TO(COLEMAK)
#define __________________ADJUST_R2________________ KC_MPRV, KC_VOLD, KC_VOLU, KC_MNXT, KC_MUTE
#define __________________ADJUST_R3________________ XXXXXXX, XXXXXXX, KC_MPLY, XXXXXXX, XXXXXXX
#define ______ADJR2_____ _______, _______
#define _ADJR1_ _______
#define ________ADJUST_R4________ ______ADJR2_____, _ADJR1_

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
   *   Transparent
   *     ┌─────┬─────┬─────┬─────┬─────┐
   *     │     │     │     │     │     │
   *     └─────┴─────┴─────┴─────┴─────┘
   */

#define _________________TRANSPARENT_______________ _______, _______, _______, _______, _______

  /* ---------------------------------------------------------------------
   *
   *   Mouse Layer
   *     ┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
   *     │     │     │     │     │     │   │ WH↑ │ XXX │ M ↑ │ XXX │ XXX │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │   │ WH← │ M ← │ M ↓ │ M → │ WH→ │
   *     ├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
   *     │     │     │     │     │     │   │ WH↓ │ XXX │ XXX │ XXX │ XXX │
   *     └─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘
   *                ┌─────┐┌─────┬─────┐   ┌─────┬─────┐┌─────┐
   *                │     ││     │     │   │R-BTN│L-BTN││     │
   *                └─────┘└─────┴─────┘   └─────┴─────┘└─────┘
   */

#define _________________MOUSE_L1__________________ _________________TRANSPARENT_______________
#define _________________MOUSE_L2__________________ _________________TRANSPARENT_______________
#define _________________MOUSE_L3__________________ _________________TRANSPARENT_______________

#define _MOUL1_ _______
#define ______MOUL2_____ _______, _______
#define _______MOUSE_L4__________ _MOUL1_, ______MOUL2_____

#define _________________MOUSE_R1__________________ KC_WH_U, XXXXXXX, KC_MS_U, XXXXXXX, XXXXXXX
#define _________________MOUSE_R2__________________ KC_WH_L, KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_R
#define _________________MOUSE_R3__________________ KC_WH_D, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX

#define _MOUR1_ _______
#define ______MOUR2_____ KC_BTN2, KC_BTN1
#define _______MOUSE_R4__________ ______MOUR2_____, _MOUR1_
