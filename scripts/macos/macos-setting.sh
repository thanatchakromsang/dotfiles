#!/usr/bin/env bash

# Custom Shortcut for chrome and kitty to behave more like Linux
defaults write -g NSUserKeyEquivalents '{
    Copy = "^c";
    Cut = "^x";
    Paste = "^v";
    Redo = "^$z";
    Undo = "^z";

    "Actual Size" = "^=";
    Back = "^\U2190";
    "Bookmark This Tab..." = "^d";
    "Close Tab" = "^w";
    "Close Window" = "^q";
    "Find Next" = "^g";
    "Find Previous" = "^$g";
    "Find..." = "^f";
    Forward = "^\U2192";
    Minimize = "@~^$m";
    "New Incognito Window" = "^$n";
    "New Tab" = "^t";
    "New Window" = "^n";
    "Open File..." = "^o";
    "Open Location..." = "^l";
    "Paste and Match Style" = "^$v";
    "Print..." = "^p";
    "Reload This Page" = "^r";
    "Reopen Closed Tab" = "^$t";
    "Select All" = "^a";
    "Zoom In" = "^+";
    "Zoom Out" = "^-";

    Settings = "@~^$$";
    "Preferences..." = "@~^$p";
    "New OS window" = "@~^$l";
    "Hide Google Chrome" = "@~^$l";
    "Hide kitty" = "@~^$l";
}'

# # Export current macOS shortcut to symbolichotkeys
# defaults export com.apple.symbolichotkeys $HOME/.dotfiles/scripts/symbolichotkeys.plist
defaults import com.apple.symbolichotkeys $HOME/.dotfiles/scripts/symbolichotkeys.plist
