import XMonad
import XMonad.Actions.GridSelect
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe,hPutStrLn)

myWorkspaces = ["chrome","terminal","eclipse"]

defaultLayouts = tiled ||| Mirror tiled ||| Full ||| Grid
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        delta = 3/100
        ratio = 1/2

eclipseLayout = noBorders $ Full

myLayout = onWorkspace "eclipse" eclipseLayout $ defaultLayouts

main = do
    xmproc <- spawnPipe "`which xmobar` ~/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { modMask = mod4Mask
        , workspaces = myWorkspaces
        , terminal = "gnome-terminal"
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ myLayout
        , borderWidth = 5
        , focusedBorderColor = "#a3cc7a"
        , normalBorderColor = "#888888"
        , logHook = dynamicLogWithPP $ xmobarPP
                { ppOutput = hPutStrLn xmproc
                -- , ppTitle = xmobarColor "#a3cc7a" "" . shorten 50
                , ppTitle = xmobarColor "#a3cc7a" ""
                }
        }
        `additionalKeysP`
        [ ("M-g", goToSelected defaultGSConfig)
        , ("M-s", spawnSelected defaultGSConfig ["google-chrome", "eclipse44"])
        ]
