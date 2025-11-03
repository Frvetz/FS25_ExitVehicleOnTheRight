-- by Gerrit
-- Contact: ModHelpGerrit@gmail.com
-- Date 09.05.2022

--[[
Changelog Version 1.0.0.1:

--]]

ExitVehicleOnTheRight = {};

function ExitVehicleOnTheRight.prerequisitesPresent(specializations)
	return true;
end;

function ExitVehicleOnTheRight.registerEventListeners(vehicleType)
	SpecializationUtil.registerEventListener(vehicleType, "onLoad", ExitVehicleOnTheRight);
	SpecializationUtil.registerEventListener(vehicleType, "onRegisterActionEvents", ExitVehicleOnTheRight);
	SpecializationUtil.registerEventListener(vehicleType, "onEnterVehicle", ExitVehicleOnTheRight);
end;

-- action event
function ExitVehicleOnTheRight:onRegisterActionEvents()
    if self.getIsEntered ~= nil and self:getIsEntered() then
		ExitVehicleOnTheRight.actionEvents = {}
		_, ExitVehicleOnTheRight.exitotherside = self:addActionEvent(ExitVehicleOnTheRight.actionEvents, 'EXIT_RIGHT', self, ExitVehicleOnTheRight.EXIT_RIGHT, false, true, false, true, nil)
		g_inputBinding:setActionEventTextPriority(ExitVehicleOnTheRight.exitotherside, GS_PRIO_NORMAL)
		g_inputBinding:setActionEventTextVisibility(ExitVehicleOnTheRight.exitotherside, true)
	end
end

-- save original exit position
function ExitVehicleOnTheRight:onLoad(savegame)
	local spec= self.spec_ExitVehicleOnTheRight

	spec.Exit_X, spec.Exit_Y, spec.Exit_Z = getTranslation(self:getExitNode())
end

-- enter vehicle
function ExitVehicleOnTheRight:onEnterVehicle()
	local spec= self.spec_ExitVehicleOnTheRight
	setTranslation(self:getExitNode(), spec.Exit_X, spec.Exit_Y, spec.Exit_Z) -- reset exit point to its original position in case it switched
end

-- exit on other side
function ExitVehicleOnTheRight:EXIT_RIGHT()
	local x, y, z = getTranslation(self:getExitNode())
	setTranslation(self:getExitNode(), -x, y, z) -- set exit position to other side
	self:doLeaveVehicle() -- exit vehicle
end