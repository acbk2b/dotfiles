#!/usr/bin/env bash
# ~/.local/bin/toggle-capslock-escape

CURRENT=$(hidutil property --get "UserKeyMapping" 2>/dev/null)

# Check if our mapping is already active
if echo "$CURRENT" | grep -q "30064771129"; then
    echo "Reverting: Caps Lock and Escape back to normal"
    hidutil property --set '{"UserKeyMapping": []}'
else
    echo "Swapping: Caps Lock <-> Escape"
    hidutil property --set '{"UserKeyMapping":[
        {"HIDKeyboardModifierMappingSrc": 0x700000039, "HIDKeyboardModifierMappingDst": 0x700000029},
        {"HIDKeyboardModifierMappingSrc": 0x700000029, "HIDKeyboardModifierMappingDst": 0x700000039}
    ]}'
fi
