import XMonad
import XMonad.Config
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.EZConfig (additionalKeys)
import System.IO

main = do
  xmproc <- spawnPipe "/home/mmuthanna/.cabal/bin/xmobar /home/mmuthanna/.xmonad/xmobarrc"
  xmonad $ defaultConfig
    {
      borderWidth = 1,
      terminal = "gnome-terminal",
      focusedBorderColor = "#22EE22",
      manageHook = manageDocks <+> manageHook defaultConfig,
      layoutHook = avoidStruts $ layoutHook defaultConfig,
      logHook = dynamicLogWithPP $ xmobarPP
        { ppOutput = hPutStrLn xmproc,
          ppTitle = xmobarColor "green" "" . shorten 50
        }
    } `additionalKeys`
    [ ((mod4Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock") ]
