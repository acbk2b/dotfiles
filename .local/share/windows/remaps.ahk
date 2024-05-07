#Requires AutoHotkey v2.0
; Swap caps lock and escape
Capslock::Esc
Esc::Capslock
; Map right alt to Windows
RAlt::RWin

; Kill window
#+c::
{
    WinKill "A"
}

; Emulated numpad using Ctrl+Alt as a modifier, and the 9 key box around the j key
^!Space::
{
    Send "{Numpad0}"
}
^!n::
{
    Send "{Numpad1}"
}
^!m::
{
    Send "{Numpad2}"
}
^!,::
{
    Send "{Numpad3}"
}
^!h::
{
    Send "{Numpad4}"
}
^!j::
{
    Send "{Numpad5}"
}
^!k::
{
    Send "{Numpad6}"
}
^!y::
{
    Send "{Numpad7}"
}
^!u::
{
    Send "{Numpad8}"
}
^!i::
{
    Send "{Numpad9}"
}
; Allows backspacing without lifing off numpad modifier
^!BS::
{
    Send "{BS}"
}

; Media keys re-bind for Mac keyboard (Use ctrl as a modifier)
^F7::
{
    Send "{Media_Prev}"
}
^F8::
{
    Send "{Media_Play_Pause}"
}
^F9::
{
    Send "{Media_Next}"
}
^F10::
{
    Send "{Volume_Mute}"
}
^F11::
{
    Send "{Volume_Down}"
}
^F12::
{
    Send "{Volume_Up}"
}
