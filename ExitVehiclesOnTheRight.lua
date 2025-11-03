-- by Gerrit
-- Contact: ModHelpGerrit@gmail.com
-- Date 09.05.2022

--[[
Changelog Version 1.0.0.1:

--]]

ExitVehiclesOnTheRight = {};

function ExitVehiclesOnTheRight.prerequisitesPresent(specializations)
	return true;
end;

function ExitVehiclesOnTheRight.registerEventListeners(vehicleType)
	SpecializationUtil.registerEventListener(vehicleType, "onLoad", ExitVehiclesOnTheRight);
	SpecializationUtil.registerEventListener(vehicleType, "onRegisterActionEvents", ExitVehiclesOnTheRight);
	SpecializationUtil.registerEventListener(vehicleType, "onEnterVehicle", ExitVehiclesOnTheRight);
end;

-- action event
function ExitVehiclesOnTheRight:onRegisterActionEvents()
    if self.getIsEntered ~= nil and self:getIsEntered() then
		ExitVehiclesOnTheRight.actionEvents = {}
		_, ExitVehiclesOnTheRight.exitotherside = self:addActionEvent(ExitVehiclesOnTheRight.actionEvents, 'EXIT_RIGHT', self, ExitVehiclesOnTheRight.EXIT_RIGHT, false, true, false, true, nil)
		g_inputBinding:setActionEventTextPriority(ExitVehiclesOnTheRight.exitotherside, GS_PRIO_NORMAL)
		g_inputBinding:setActionEventTextVisibility(ExitVehiclesOnTheRight.exitotherside, true)
	end
end

-- save original exit position
function ExitVehiclesOnTheRight:onLoad(savegame)
	local spec= self.spec_ExitVehiclesOnTheRight

	spec.Exit_X, spec.Exit_Y, spec.Exit_Z = getTranslation(self:getExitNode())
end

-- enter vehicle
function ExitVehiclesOnTheRight:onEnterVehicle()
	local spec= self.spec_ExitVehiclesOnTheRight
	setTranslation(self:getExitNode(), spec.Exit_X, spec.Exit_Y, spec.Exit_Z) -- reset exit point to its original position in case it switched
end

-- exit on other side
function ExitVehiclesOnTheRight:EXIT_RIGHT()
	local x, y, z = getTranslation(self:getExitNode())
	setTranslation(self:getExitNode(), -x, y, z) -- set exit position to other side
	self:doLeaveVehicle() -- exit vehicle
end