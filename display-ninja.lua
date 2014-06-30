local M = {}

local function deg2rad(v)
	return v * math.pi / 180.0
end

local function rad2deg(v) 
	return v * 180.0 / math.pi
end

local MAX_ARC_STEPS = math.floor((720 / 360) * 2 * math.pi)

local function getPointOnCircle(centerX, centerY, radius, angle)
	return {
		x = centerX + math.cos(angle) * radius,
		y = centerY + math.sin(angle) * radius
	}
end

function M.newArc(centerX, centerY, radius, startAngle, arcAngle)
	startAngle = deg2rad(startAngle)
	arcAngle = deg2rad(arcAngle)
	
	local segment = nil
	local startPoint = getPointOnCircle(centerX, centerY, radius, startAngle)
	local steps = math.floor(MAX_ARC_STEPS * arcAngle)
	local angleStep = arcAngle / steps
		
	for i = 1, steps, 1 do
		local angle = startAngle + i * angleStep
		local point = getPointOnCircle(centerX, centerY, radius, angle)
		
		if segment then
			segment:append(point.x, point.y)
		else
			segment = display.newLine(startPoint.x, startPoint.y, point.x, point.y)
		end
	end
	
	return segment
end

return M
