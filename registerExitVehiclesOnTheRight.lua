-- by Frvetz
-- Contact: ExtendedVehicleMaintenance@gmail.com
-- Date 09.05.2022

--[[
Changelog Version 1.0.0.1:

--]]

-- Thanks to Dr_Schwiizer for testing!

registerExitVehiclesOnTheRight = {}
registerExitVehiclesOnTheRight.specName = "ExitVehiclesOnTheRight"
registerExitVehiclesOnTheRight.className = "ExitVehiclesOnTheRight"
registerExitVehiclesOnTheRight.fileName = g_currentModDirectory.."ExitVehiclesOnTheRight.lua"

function registerExitVehiclesOnTheRight:registerSpecialization()

	local specName = registerExitVehiclesOnTheRight.specName

	if g_specializationManager:getSpecializationByName(specName) == nil then
		g_specializationManager:addSpecialization(registerExitVehiclesOnTheRight.specName, registerExitVehiclesOnTheRight.className, registerExitVehiclesOnTheRight.fileName, "")

		for vehicleType, vehicle in pairs(g_vehicleTypeManager.types) do

			if vehicle ~= nil and vehicleType ~= "locomotive" and vehicleType ~= "ConveyorBelt" and vehicleType ~= "woodCrusherTrailerDrivable" then

				local isDrivable = false;
				local hasNotExitVehiclesOnTheRight = true;

				for name, spec in pairs(vehicle.specializationsByName) do
					if name == "drivable" then
						isDrivable = true;
					elseif name == "ExitVehiclesOnTheRight" then
						hasNotExitVehiclesOnTheRight = false;
					end
				end
				if hasNotExitVehiclesOnTheRight and isDrivable then
					print("  adding ExitVehiclesOnTheRight to vehicleType '"..tostring(vehicleType).."'")

					local specObject = g_specializationManager:getSpecializationObjectByName(specName);

					vehicle.specializationsByName[specName] = specObject;
					table.insert(vehicle.specializationNames, specName);
					table.insert(vehicle.specializations, specObject);
				end
			end
		end
	end
end
TypeManager.finalizeTypes = Utils.appendedFunction(TypeManager.finalizeTypes, registerExitVehiclesOnTheRight.registerSpecialization)