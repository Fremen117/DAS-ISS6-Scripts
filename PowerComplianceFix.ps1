#Check what the currently active power plan is and get just the GUID
$activePowerPlan = (powercfg /getactivescheme | Select-String -Pattern '\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b' -AllMatches).Matches.Value

#Update the settings to fix the power issues. This only affects PCs while plugged into power

#Fixes Networking connectivity in Standby
powercfg /setacvalueindex $activePowerPlan fea3413e-7e05-4911-9a71-700331f1c294 f15576e8-98b7-4186-b944-eafa664402d9 0x00000001

#Fixes Wireless Adapter Power Saving Mode
powercfg /setacvalueindex $activePowerPlan 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a 0x00000000

#Fixes USB selective suspend setting
powercfg /setacvalueindex $activePowerPlan 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0x00000000