local notchBlocker = nil

local function blockNotchArea()
	local screen = hs.screen.primaryScreen()
	local fullFrame = screen:fullFrame()
	local safeFrame = screen:frame()
	local topInset = safeFrame.y - fullFrame.y

	local blocker = hs.drawing.rectangle(hs.geometry.rect(fullFrame.x, fullFrame.y, fullFrame.w, topInset + 5))

	blocker:setFillColor({ red = 0, green = 0, blue = 0, alpha = 1 }) -- solid black
	blocker:setLevel(hs.drawing.windowLevels["screenSaver"])
	blocker:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
	blocker:setStroke(false)
	blocker:show()

	return blocker
end

-- Function to toggle the blocker
local function toggleNotchBlocker()
	if notchBlocker then
		notchBlocker:delete()
		notchBlocker = nil
		hs.alert.show("🟢 Menu bar visible")
	else
		notchBlocker = blockNotchArea()
		hs.alert.show("⚫️ Menu bar hidden")
	end
end

-- Optional: auto-apply blocker on startup
notchBlocker = blockNotchArea()

-- Reapply when screens change
hs.screen.watcher
	.newWithActiveScreen(function()
		if notchBlocker then
			notchBlocker:delete()
			notchBlocker = blockNotchArea()
		end
	end)
	:start()

-- 🔥 Hotkey to toggle the bar — Cmd + Ctrl + N
hs.hotkey.bind({ "cmd", "ctrl" }, "N", toggleNotchBlocker)

-- Auto-send Cmd+W when Notification Center is frontmost
hs.application.watcher
	.new(function(appName, eventType)
		if appName == "NotificationCenter" and eventType == hs.application.watcher.activated then
			hs.timer.doAfter(0.1, function()
				hs.eventtap.keyStroke({ "cmd" }, "w")
			end)
		end
	end)
	:start()
