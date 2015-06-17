import XMonad
import XMonad.Actions.GridSelect
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe,hPutStrLn)

myWorkspaces = ["chrome", "terminal", "editor", "other"]

defaultLayouts = tiled ||| Mirror tiled ||| Full ||| Grid
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        delta = 3/100
        ratio = 1/2

editorLayout = noBorders $ Full

myLayout = onWorkspace "editor" editorLayout $ defaultLayouts

-- Custom spawnSelected which adds labels to commands
-- http://ixti.net/software/2013/09/07/xmonad-action-gridselect-spawnselected-with-nice-titles.html
spawnSelected' :: [(String, String)] => X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = defaultGSConfig

main = do
    xmproc <- spawnPipe "`which xmobar` ~/.xmonad/xmobarrc"
    xmonad $ ewmh defaultConfig
        { modMask = mod4Mask -- Set Windows key as meta
        , workspaces = myWorkspaces
        , terminal = "gnome-terminal"
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ myLayout
        , borderWidth = 5
        , focusedBorderColor = "#a3cc7a"
        , normalBorderColor = "#888888"
        , logHook = takeTopFocus <+> dynamicLogWithPP xmobarPP
                { ppOutput = hPutStrLn xmproc
                -- , ppTitle = xmobarColor "#a3cc7a" "" . shorten 50
                , ppTitle = xmobarColor "#a3cc7a" ""
                }
        , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
        }
        `additionalKeysP`
        [ ("M-g", goToSelected defaultGSConfig)
        -- , ("M-s", spawnSelected defaultGSConfig ["google-chrome --disable-gpu", "eclipse44", "~/apps/intellij13/bin/idea.sh"])
        , ("M-s", spawnSelected'
        [ ("Chrome", "google-chrome --disable-gpu")
        , ("Eclipse", "eclipse44")
        , ("IntelliJ", "~/apps/intellij13/bin/idea.sh")
        ])
        ]
