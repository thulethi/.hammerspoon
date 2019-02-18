local mash         = {"ctrl", "cmd"}
local mashShift    = {"ctrl", "cmd", "shift"}
local mashAlt      = {"ctrl", "cmd", "alt"}
local mashAltShift = {"ctrl", "cmd", "alt", "shift"}

hs.window.animationDuration = 0
hs.grid.setMargins({0, 0})
hs.grid.setGrid('12x4')
hs.grid.HINTS = {
  {'f1', 'f2','f3', 'f4', 'f5', 'f6', 'f7', 'f8'},
  {'1', '2', '3', '4', '7', '8', '9', '0'},
  {'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I'},
  {'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K'},
  {'Z', 'X', 'C', 'V', 'B', 'N', 'M', ','}
}

local gw = hs.grid.GRIDWIDTH
local gh = hs.grid.GRIDHEIGHT
local gm = gw / 2
local gb = 7
local gs = 5

local gridset = function(x, y, w, h)
    return function()
        local curWindow = hs.window.focusedWindow()
        hs.grid.set(
            curWindow,
            {x=x, y=y, w=w, h=h},
            curWindow:screen()
        )
    end
end

hs.hotkey.bind(mashAlt, 'z', hs.grid.pushWindowNextScreen)
hs.hotkey.bind(mashAlt, 'h', function() hs.grid.toggleShow() end)
-- hs.hotkey.bind(mash, 'i', function() hs.hints.appHints(appfinder.appFromName("iTerm")) end)

local resizeMash = mashAltShift
local resizeKeys = { 'u', 'i', 'o', 'p' } -- Qwerty
hs.hotkey.bind(resizeMash, resizeKeys[1], hs.grid.resizeWindowThinner)
hs.hotkey.bind(resizeMash, resizeKeys[2], hs.grid.resizeWindowShorter)
hs.hotkey.bind(resizeMash, resizeKeys[3], hs.grid.resizeWindowTaller)
hs.hotkey.bind(resizeMash, resizeKeys[4], hs.grid.resizeWindowWider)

local moveMash = mashAlt
local moveKeys = { 'j', 'k', 'l', ';' } -- Qwerty
hs.hotkey.bind(moveMash, moveKeys[1], hs.grid.pushWindowLeft)
hs.hotkey.bind(moveMash, moveKeys[2], hs.grid.pushWindowUp)
hs.hotkey.bind(moveMash, moveKeys[3], hs.grid.pushWindowDown)
hs.hotkey.bind(moveMash, moveKeys[4], hs.grid.pushWindowRight)

local gridMash = mashAlt
local gridKeys = { 'q', 'w', 'e', 'r', 't', 'a' } -- Qwerty
hs.hotkey.bind(gridMash, gridKeys[1], gridset(0,  0, gm, gh))
hs.hotkey.bind(gridMash, gridKeys[2], gridset(0,  0, gb, gh))
hs.hotkey.bind(gridMash, gridKeys[3], gridset(gs, 0, gb,  gh))
hs.hotkey.bind(gridMash, gridKeys[4], gridset(gm, 0, gm, gh))
hs.hotkey.bind(gridMash, gridKeys[5], gridset(gb, 0, gs,  gh))
hs.hotkey.bind(gridMash, gridKeys[6], hs.grid.maximizeWindow)

-- Launch applications
-- hs.hotkey.bind(mash, '5', function () hs.application.launchOrFocus("iterm") end)
-- hs.hotkey.bind(mash, '4', function () hs.application.launchOrFocus("Sublime Text 2") end)
hs.hotkey.bind(mash, '3', function () hs.application.launchOrFocus("Safari") end)
hs.hotkey.bind(mash, '2', function () hs.application.launchOrFocus("Google Chrome") end)
-- hs.hotkey.bind(mash, '1', function () hs.application.launchOrFocus("SourceTree") end)
-- hs.hotkey.bind(mash, '[', function () hs.application.launchOrFocus("Slack") end)
hs.hotkey.bind(mash, '1', function () hs.application.launchOrFocus("Finder") end)

-- slow
hs.hotkey.bind(mash, 'h', hs.hints.windowHints)

-- slow
hs.hotkey.bind(mashShift, 'left',  function() hs.window.focusedWindow():focusWindowWest()  end)
hs.hotkey.bind(mashShift, 'right', function() hs.window.focusedWindow():focusWindowEast()  end)
hs.hotkey.bind(mashShift, 'up',    function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(mashShift, 'down',  function() hs.window.focusedWindow():focusWindowSouth() end)

-- hs.hotkey.bind(mash, 'q', function() Action.MoveToUnit(0.0, 0.0, 0.5, 1.0)(focusedWin()) end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
