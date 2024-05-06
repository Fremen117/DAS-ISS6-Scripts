#Check what the currently active power plan is and extract just the GUID
$activePowerPlan = (powercfg /getactivescheme | Select-String -Pattern '\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b' -AllMatches).Matches.Value

#Gets the value for Networking connectivity in Standby
$NetConSetting = powercfg /qh $activePowerPlan fea3413e-7e05-4911-9a71-700331f1c294 f15576e8-98b7-4186-b944-eafa664402d9

#This regular expression extracts the current AC power setting index number
$NetConSettingIndex = [regex]::Match($NetConSetting, "Current AC Power Setting Index: (\w+)").Groups[1].Value

#Gets the index value for Wireless Adapter Power Saving Mode
$WifiPSMSetting = powercfg /qh $activePowerPlan 19cbb8fa-5279-450e-9fac-8a3d5fedd0c1 12bbebe6-58d6-4636-95bb-3217ef867c1a
$WifiPSMSettingIndex = [regex]::Match($WifiPSMSetting, "Current AC Power Setting Index: (\w+)").Groups[1].Value

#Gets the index value for selective suspend setting
$USBSSSetting = powercfg /qh $activePowerPlan 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226
$USBSSSettingIndex = [regex]::Match($USBSSSetting, "Current AC Power Setting Index: (\w+)").Groups[1].Value

#Checks if it has the correct value
Write-Output (($USBSSSettingIndex -like "0x00000000") -and ($WifiPSMSettingIndex -like "0x00000000") -and ($NetConSettingIndex -like "0x00000001"))