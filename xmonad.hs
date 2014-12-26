import XMonad
import XMonad.Util.Paste
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Hooks.ManageHelpers
import Control.Monad (liftM2)
import XMonad.Actions.CycleWS
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import qualified XMonad.StackSet as W

-- Custom Manage Hook
customManageHook :: ManageHook
customManageHook = composeAll
    [ (role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
    , className =? "Gimp" --> viewShift "5>gimp"
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ] where
        role = stringProperty "WM_WINDOW_ROLE" 
        viewShift = doF . liftM2 (.) W.greedyView W.shift

main = do
   xmproc <- spawnPipe "/usr/bin/xmobar /home/sshihata/.xmobarrc"
   xmonad $ defaultConfig
	{ manageHook = customManageHook <+> manageDocks <+> manageHook defaultConfig
	, layoutHook = avoidStruts $ smartBorders $ layoutHook defaultConfig
	, logHook = dynamicLogWithPP xmobarPP
				{ ppOutput = hPutStrLn xmproc
				, ppTitle = xmobarColor "green" "" . shorten 50
				}
	, terminal    = "urxvt"
	, borderWidth = 1
	, focusedBorderColor = "light blue"
  , startupHook = setWMName "LG3D"
	} `additionalKeysP`	
	[ (("<XF86AudioLowerVolume>"), spawn "amixer -q set Master unmute && amixer -q set Master 1%-")
	, (("<XF86AudioRaiseVolume>"), spawn "amixer -q set Master unmute && amixer -q set Master 1%+")
	, (("<XF86AudioMute>"), spawn "amixer -q set Master toggle")
	, (("M-<Down>"), nextWS)
	, (("M-<Up>"), prevWS)
	, (("M-<Right>"), moveTo Next EmptyWS)
	, (("M-<Tab>"), toggleWS)
	, (("M-<Print>"), spawn "scrot ~/screen_%Y-%m-%d-%H-%M-%S.png -d 1")
	]
