--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

-- Default Stuff
import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Hooks
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks)
import XMonad.Hooks.EwmhDesktops ( ewmh )
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, xmobarPP, xmobarColor, PP(..)) -- Xmobar stuff
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat) -- Fullscreen
import XMonad.Hooks.InsertPosition -- Attatch aside thing

-- Layouts
import XMonad.Layout.ResizableTile 
import XMonad.Layout.Spiral
import XMonad.Layout.Fullscreen (fullscreenEventHook, fullscreenManageHook )
import qualified XMonad.Layout.MultiToggle as MT
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL)) -- Fullscreen layout
import XMonad.Layout.Spacing --Gaps
import XMonad.Layout.LayoutModifier --Gaps
import XMonad.Layout.IndependentScreens -- xmobars for each screen

-- Actions
import XMonad.Actions.CycleWS (nextScreen, prevScreen) -- Screen keybindings
import XMonad.Actions.UpdatePointer -- Mouse Warping

-- Media Keys
import Graphics.X11.ExtraTypes.XF86 ( xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute, xF86XK_MonBrightnessDown, xF86XK_MonBrightnessUp )

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#00ff9c"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)

    -- launch rofi
    , ((modm.|. shiftMask,               xK_d     ), spawn "rofi -show drun -show-icons")

    -- launch dmenu
    , ((modm , xK_d     ), spawn "dmenu_run")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_Tab ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    -- , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_comma ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_period), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm .|. shiftMask, xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm  .|. shiftMask, xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_r   ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

    -- Shrink the master area
    , ((modm,               xK_h     ), nextScreen)

    -- Expand the master area
    , ((modm,               xK_l), prevScreen)

    -- Toggle floating for focused window 
    , ((modm .|. shiftMask, xK_space), withFocused $ windows . W.sink)

    -- Fullscreen keyboard shortcut
    -- , ((modm, xK_f), sendMessage $ Toggle FULL)
    , ((modm, xK_f), sendMessage (MT.Toggle NBFULL))

    -- Spawn picom
    , ((modm, xK_o), spawn "picom")
    -- Kill picom 
    , ((modm .|. shiftMask, xK_o), spawn "pkill picom")
    -- Application shortcuts 
    , ((modm, xK_w), spawn "firefox")
    , ((modm, xK_s), spawn "spotify")
    , ((modm, xK_a), spawn "~/Joplin")
    -- Scripts dmenu prompt
    , ((modm, xK_r), spawn "~/scripts/run_scripts")

    -- Media Keys
    -- Audio Keys
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +5%")
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -5%")
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")
    , ((0, xF86XK_MonBrightnessUp), spawn "light -A 5%")
    , ((0, xF86XK_MonBrightnessDown), spawn "light -U 5%")

    , ((modm, xK_i), spawn (myTerminal ++ " --class \"dropdown-term\" -e pulsemixer"))
    
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-[1..9] (numpad), Switch to workspace N
    -- mod-shift-[1..9] (numpad), Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_KP_End, xK_KP_Down, xK_KP_Next, xK_KP_Left, xK_KP_Begin, xK_KP_Right, xK_KP_Home, xK_KP_Up, xK_KP_Prior]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++
    
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True


myLayoutHook = MT.mkToggle (NBFULL MT.?? MT.EOT) $ avoidStruts ( tall ||| Full ||| spirals ) 
  where 
     -- Better Tile layout
     tall = mySpacing 4 $ ResizableTall nmaster delta ratio []

     -- Fibonacci Spiral Layout
     spirals  = mySpacing 4 $ spiral (6/7)

     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "dropdown-term"  --> doFloat
    , resource  =? "pavucontrol"    --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , isFullscreen --> doFullFloat 
    , fullscreenManageHook 
    , manageDocks 
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = composeAll 
    [ docksEventHook
    , fullscreenEventHook
    ]

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.

myLogHook = composeAll 
    [ updatePointer (0.5, 0.5) (0, 0) ]

xmobarCommand (S s) = unwords ["xmobar", "-x", show s] 
pp h s = xmobarPP
  { ppOutput = hPutStrLn h
  , ppHiddenNoWindows = xmobarColor "#c792ea" ""        -- Hidden workspaces (no windows)
  } 
------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawnOnce "$HOME/.autostart.sh"
  spawnOnce "variety &"
  spawnOnce "picom"
  spawnOnce "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 --tint 0x282c34  --height 18 &"



------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    -- xmproc <- spawnPipe "xmobar -x 0 /home/alex/.config/xmobar/xmobarrc"
    -- xmproc1 <- spawnPipe "xmobar -x 1 /home/alex/.config/xmobar/xmobarrc"
    nScreens    <- countScreens
    hs          <- mapM (spawnPipe . xmobarCommand) [0 .. nScreens-1]
    xmonad $ ewmh def { 
        -- simple stuff
          terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , clickJustFocuses   = myClickJustFocuses
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor

        --  key bindings
        , keys               = myKeys
        , mouseBindings      = myMouseBindings

        --  hooks, layouts
        , layoutHook         = myLayoutHook
        --  insertPostition gives attach bottom functionality
        , manageHook         = insertPosition End Newer <+> myManageHook
        , handleEventHook    = myEventHook
        , logHook            = myLogHook <+> (mapM_ dynamicLogWithPP $ zipWith pp hs [0..nScreens])
        -- , logHook            = myLogHook <+> dynamicLogWithPP xmobarPP
        --                         { ppOutput = \x -> hPutStrLn xmproc x -- >> hPutStrLn xmproc1 x
        --                         , ppHiddenNoWindows = xmobarColor "#c792ea" ""        -- Hidden workspaces (no windows)
        --                         } 
        , startupHook        = myStartupHook
      }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
