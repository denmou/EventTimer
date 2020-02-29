local Define = {
	english = {
        sleep = "Not Active",
        come = "Coming",
        escape = "Escaping",
        reset = "Resetting",
        ready = "Ready",
        rage = "Raging",
        circle = "Circling",
        attack = "Attacking",
        appear = "Appearing",
        land = "Landing",
        forage = "Foraging",
        end_in = "End in",
        sneeze = "Sneeze",
        flow = "flowing",
        dry = "drying",
        wither = "Withered",
        stop_grow = "Stop Growing",
        pick = "Picked",
        generate = "Generated"
	},
	chinese = {
        sleep = "未激活",
        come = "抵达计时",
        escape = "逃亡中",
        reset = "重生中",
        ready = "就绪",
        rage = "出没中",
        circle = "盘旋降落",
        attack = "攻击计时",
        appear = "即将到达",
        land = "正在着陆",
        forage = "正在觅食",
		end_in = "结束计时",
        sneeze = "打喷嚏",
        flow = "流动中",
        dry = "已干涸",
        wither = "已枯萎",
        stop_grow = "停止生长",
        pick = "可摘取",
        generate = "已生成"
    },
	idiom = {
        sleep = "蓄势待发",
        come = "危机四伏",
        escape = "东逃西窜",
        reset = "修养生息",
        ready = "厉兵秣马",
        rage = "肆虐横行",
        circle = "四面楚歌",
        attack = "猪突豨勇",
        appear = "大厦将倾",
        land = "兵临城下",
        forage = "饥肠辘辘",
		end_in = "劫后余生",
        sneeze = "戳心灌髓",
        flow = "奔流不息",
        dry = "甘井先竭",
        wither = "枯枝败叶",
        stop_grow = "中道而止",
        pick = "硕果累累",
        generate = "忽隐忽现"
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

return Define