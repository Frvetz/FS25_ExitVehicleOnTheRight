-- by Frvetz
-- Contact: ExtendedVehicleMaintenance@gmail.com
-- Date 09.05.2022

--[[
Changelog Version 1.0.0.1:

--]]

-- Thanks to Dr_Schwiizer for testing!

registerExitVehicleOnTheRight = {}
registerExitVehicleOnTheRight.specName = "ExitVehicleOnTheRight"
registerExitVehicleOnTheRight.className = "ExitVehicleOnTheRight"
registerExitVehicleOnTheRight.fileName = g_currentModDirectory.."ExitVehicleOnTheRight.lua"

function registerExitVehicleOnTheRight:registerSpecialization()

	local specName = registerExitVehicleOnTheRight.specName

	if g_specializationManager:getSpecializationByName(specName) == nil then
		g_specializationManager:addSpecialization(registerExitVehicleOnTheRight.specName, registerExitVehicleOnTheRight.className, registerExitVehicleOnTheRight.fileName, "")

		for vehicleType, vehicle in pairs(g_vehicleTypeManager.types) do

			if vehicle ~= nil and vehicleType ~= "locomotive" and vehicleType ~= "ConveyorBelt" and vehicleType ~= "woodCrusherTrailerDrivable" then

				local isDrivable = false;
				local hasNotExitVehicleOnTheRight = true;

				for name, spec in pairs(vehicle.specializationsByName) do
					if name == "drivable" then
						isDrivable = true;
					elseif name == "ExitVehicleOnTheRight" then
						hasNotExitVehicleOnTheRight = false;
					end
				end
				if hasNotExitVehicleOnTheRight and isDrivable then
					print("  adding ExitVehicleOnTheRight to vehicleType '"..tostring(vehicleType).."'")

					local specObject = g_specializationManager:getSpecializationObjectByName(specName);

					vehicle.specializationsByName[specName] = specObject;
					table.insert(vehicle.specializationNames, specName);
					table.insert(vehicle.specializations, specObject);
				end
			end
		end
	end
end
TypeManager.finalizeTypes = Utils.appendedFunction(TypeManager.finalizeTypes, registerExitVehicleOnTheRight.registerSpecialization)