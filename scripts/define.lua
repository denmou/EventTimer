local Define = {
	english = {
		aporkalypse = "Aporkalypse",
		happening = "happening",
		landing = "landing",
		coming = "coming",
		attacking = "coming",
		appearing = "appearing",
		endIn = "end",
		ready = "ready",
		nextAttacking = "next attacking"
	},
	chinese = {
		aporkalypse = "大灾变",
		happening = "危在旦夕",
		landing = "高歌猛进",
		coming = "乘风破浪",
		attacking = "来势汹汹",
		appearing = "肆意横行",
		endIn = "在劫难逃",
		ready = "厉兵秣马",
		nextAttacking = "暗度陈仓"
	}
}

function Define:timeFormat(time)
    local timeText = nil
    local second = math.mod(time, 60)
    time = math.floor(time / 60)
    local minute = math.mod(time, 60)
    local hour = math.floor(time / 60)
    if hour < 10 then
        timeText = "0".. hour .. ":"
    else 
        timeText = hour .. ":"
    end 
    if minute < 10 then
        timeText = timeText .. "0"
    end 
    timeText = timeText .. minute .. ":"
    if second < 10 then
        timeText = timeText .. "0"
    end 
    return timeText .. second
end

function Define:getColorByTime(time)
    local color = 0
    if time <= 60 then
        color = 1
    elseif time <= 120 then
        color = 4
    end
    return color
end

return Define