-- MODERNGADGETS CPU CONFIG SCRIPT
-- Written by iamanai

function Initialize()

  cpuSettingsPath = SKIN:GetVariable('cpuSettingsPath')
  cpuMeterPath = SKIN:GetVariable('cpuMeterPath')

end

function Update() end

function ConfigCores(threads, showAvgCpu)

  for i=1,20 do
    if (i <= threads) then
      SKIN:Bang('!ShowMeterGroup', 'CpuCore' .. i)
      SKIN:Bang('!SetOption', 'Core' .. i .. 'LabelString', 'Y', '#rowSpacing#R')
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'LabelString', 'Y', '#rowSpacing#R')
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'LabelString', 'Hidden', '0')
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'TempString', 'Hidden', '0')
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'ValueString', 'Hidden', '0')
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'Bar', 'Hidden', '0')
    elseif (i > threads) then
      SKIN:Bang('!HideMeterGroup', 'CpuCore' .. i)
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'LabelString', 'Hidden', '1')
      SKIN:Bang('!SetOption', 'Core' .. i .. 'LabelString', 'Y', 'R')
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'LabelString', 'Y', 'R')
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'TempString', 'Hidden', '1')
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'ValueString', 'Hidden', '1')
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'Bar', 'Hidden', '1')
    end
  end

  if showAvgCpu == 0 then
    if (threads == 20) then
      SKIN:Bang('!SetOption', 'GraphLines', 'LineColor', '#*colorCore20*#')
      SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor', '#*colorCore20*#')
    else
      SKIN:Bang('!SetOption', 'GraphLines', 'LineColor', '0,0,0,0')
      SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor', '0,0,0,0')
    end
    c = 19
    for i=2,20 do
      if (c <= threads) then
        SKIN:Bang('!SetOption', 'GraphLines', 'LineColor' .. i, '#*colorCore' .. c .. '*#')
        SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor' .. i, '#*colorCore' .. c .. '*#')
      elseif (c > threads) then
        SKIN:Bang('!SetOption', 'GraphLines', 'LineColor' .. i, '0,0,0,0')
        SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor' .. i, '0,0,0,0')
      end

      c = (c - 1)
    end
  else
    SKIN:Bang('!SetOption', 'GraphLines', 'LineColor21', '#*colorAvgCpu*#')
    SKIN:Bang('!WriteKeyValue', 'GraphLines', 'LineColor21', '#*colorAvgCpu*#')
  end

  SKIN:Bang('!Log', 'Finished core configuration', 'Debug')

  SKIN:Bang('!SetVariable', 'cpuCores', threads)
  SKIN:Bang('!WriteKeyValue', 'Variables', 'cpuCores', threads, cpuMeterPath)
  SKIN:Bang('!WriteKeyValue', 'Variables', 'threadCount', threads, cpuSettingsPath)
end

function ToggleTemps(threads, mode)

  threads = tonumber(threads)

  -- SKIN:Bang('!Log', 'ToggleTemps threads: ' .. threads .. ' | mode: ' .. tostring(mode), 'Debug')

  if mode then
    for i=1,20 do
      if (i <= threads) then
        SKIN:Bang('!ShowMeter', 'Core' .. i .. 'TempString')
        SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'TempString', 'Hidden', '0')
      else
        SKIN:Bang('!HideMeter', 'Core' .. i .. 'TempString')
        SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'TempString', 'Hidden', '1')
      end
    end
  else
    for i=1,20 do
      SKIN:Bang('!HideMeter', 'Core' .. i .. 'TempString')
      SKIN:Bang('!WriteKeyValue', 'Core' .. i .. 'TempString', 'Hidden', '1')
    end
  end

  SKIN:Bang('!UpdateMeterGroup', 'CoreTemps')
  -- SKIN:Bang('!Redraw')

end

function SetLineGraphY(showLineGraph, showCpuFan, showCpuClock)

  -- SKIN:Bang('!Log', showLineGraph .. ', ' .. showCpuFan .. ', ' .. showCpuClock, 'Debug')

  if showCpuFan == 1 or showCpuClock == 1 then
    if showLineGraph == 1 then
      SKIN:Bang('!SetOption', 'GraphLines', 'Y', '#*contentWidth*#R')
    else
      SKIN:Bang('!SetOption', 'GraphLines', 'Y', '#*contentWidth*#R')
    end
  else
    if showLineGraph == 1 then
      SKIN:Bang('!SetOption', 'GraphLines', 'Y', '#*contentWidth*#R')
    else
      SKIN:Bang('!SetOption', 'GraphLines', 'Y', '#*contentWidth*#R')
    end
  end

end

function ConfigCpuIcon(state)

  -- SKIN:Bang('!Log', 'Configuring CPU Icon with state \'' .. state .. '\'', 'Debug')
  if state == 'GenuineIntel' then
    SKIN:Bang('!SetOption', 'CpuImage', 'ImageName', '#*imgPath*#cpu.png')
    SKIN:Bang('!SetOption', 'CpuImage', 'ImageTint', '#*colorIntel*#')
    SKIN:Bang('!SetOption', 'CpuImage', 'X', '(#*contentMargin*# + 1)')
    SKIN:Bang('!SetOption', 'CpuImage', 'Y', '(#*contentMargin*# + 1)')
    SKIN:Bang('!SetOption', 'CpuImage', 'W', '13')
    SKIN:Bang('!SetOption', 'CpuImage', 'H', '13')
    SKIN:Bang('!UpdateMeter', 'CpuImage')
    -- SKIN:Bang('!Redraw')
  elseif state ~= 'GenuineAMD' and state ~= 'AuthenticAMD' then
    SKIN:Bang('!SetOption', 'CpuImage', 'ImageName', '#*imgPath*#amd.png')
    SKIN:Bang('!SetOption', 'CpuImage', 'X', '(#*contentMargin*# + 2)')
    SKIN:Bang('!SetOption', 'CpuImage', 'Y', '(#*contentMargin*# + 2)')
    SKIN:Bang('!SetOption', 'CpuImage', 'W', '11')
    SKIN:Bang('!SetOption', 'CpuImage', 'H', '11')
    SKIN:Bang('!UpdateMeter', 'CpuImage')
    -- SKIN:Bang('!Redraw')
  end

end
