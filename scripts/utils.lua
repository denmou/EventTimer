local Utils = {}

function Utils.timeFormat(time)
    local timeText = nil
    local second = math.mod(time, 60)
    time = math.floor(time / 60)
    local minute = math.mod(time, 60)
    local hour = math.floor(time / 60)
    if hour < 10 then
        timeText = '0' .. hour .. ':'
    else
        timeText = hour .. ':'
    end
    if minute < 10 then
        timeText = timeText .. '0'
    end
    timeText = timeText .. minute .. ':'
    if second < 10 then
        timeText = timeText .. '0'
    end
    return timeText .. second
end

return Utils