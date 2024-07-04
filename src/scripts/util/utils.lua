local Utils = {}

function Utils.SecondFormat(time)
    time = math.ceil(time)
    if 0 == time then
        return '00:00'
    end
    local second = math.mod(time, 60)
    local minute = math.floor(time / 60)
    local timeText = minute
    if minute < 10 then
        timeText = '0' .. timeText
    end
    timeText = timeText .. ':'
    if second < 10 then
        timeText = timeText .. "0"
    end
    return timeText .. second
end

function Utils.TimeFormat(time)
    local timeText
    time = math.ceil(time)
    if 0 == time then
        return '00:00:00'
    end
    local second = math.mod(time, 60)
    time = math.floor(time / 60)
    local minute = math.mod(time, 60)
    local hour = math.floor(time / 60)
    if hour < 10 then
        timeText = "0" .. hour .. ":"
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

function Utils.loadStrings(name)
    local current
    for key in string.gmatch(name, "[^.]+") do
        if key == "STRINGS" and not current then
            current = STRINGS
        elseif current[key] then
            current = current[key]
        else
            current = nil
            break
        end
    end
    return current or name
end

function Utils.contains(table, item)
    for _, v in pairs(table) do
        if v and v == item then
            return true
        end
    end
    return false
end

return Utils