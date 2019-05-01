-- LaunchPad S ReDrum Mapping by DJSem

-- Originally by SonicDetours: http://sonicdetours.com/2014/05/09/remote-codec-for-launchpad-mini/
-- Tweaked by TONAL AXiS: http://tonalaxis.wordpress.com/
-- Pads-as-Keyboard + ReDrum & Kong backlight feedback by Koshdukai: http://KoshdukaiMusicReason.BlogSpot.com/
-- And even further tweaked and changed the layout: DJSem

-- global vars for upper row bar indicator (by TONAL AXIS). I left it in just because its nice :)
g_bars_display_index = -1
g_current_bar = -1
g_delivered_bar = -1

-- global array for indexId mapping of items
g_controls = {}

-- global array for easy access to cc values for all mapped launchpad buttons
-- (change these if your launchpad has different cc values for the buttons)
g_cc_for_buttons = {

	button_a = "08",
	button_b = "18",
	button_c = "28",
	button_d = "38",
	button_e = "48",
	button_f = "58",
	button_g = "68",
	button_h = "78",

	button_1_1 = "00",
	button_1_2 = "01",
	button_1_3 = "02",
	button_1_4 = "03",
	button_1_5 = "04",
	button_1_6 = "05",
	button_1_7 = "06",
	button_1_8 = "07",

	button_2_1 = "10",
	button_2_2 = "11",
	button_2_3 = "12",
	button_2_4 = "13",
	button_2_5 = "14",
	button_2_6 = "15",
	button_2_7 = "16",
	button_2_8 = "17",

	button_3_1 = "20",
	button_3_2 = "21",
	button_3_3 = "22",
	button_3_4 = "23",
	button_3_5 = "24",
	button_3_6 = "25",
	button_3_7 = "26",
	button_3_8 = "27",

	button_4_1 = "30",
	button_4_2 = "31",
	button_4_3 = "32",
	button_4_4 = "33",
	button_4_5 = "34",
	button_4_6 = "35",
	button_4_7 = "36",
	button_4_8 = "37",

	button_5_1 = "40",
	button_5_2 = "41",
	button_5_3 = "42",
	button_5_4 = "43",
	button_5_5 = "44",
	button_5_6 = "45",
	button_5_7 = "46",
	button_5_8 = "47",

	button_6_1 = "50",
	button_6_2 = "51",
	button_6_3 = "52",
	button_6_4 = "53",
	button_6_5 = "54",
	button_6_6 = "55",
	button_6_7 = "56",
	button_6_8 = "57",

	button_7_1 = "60",
	button_7_2 = "61",
	button_7_3 = "62",
	button_7_4 = "63",
	button_7_5 = "64",
	button_7_6 = "65",
	button_7_7 = "66",
	button_7_8 = "67",

	button_8_1 = "70",
	button_8_2 = "71",
	button_8_3 = "72",
	button_8_4 = "73",
	button_8_5 = "74",
	button_8_6 = "75",
	button_8_7 = "76",
	button_8_8 = "77",
}

function remote_init()
	init_items()
	init_inputs()
	init_outputs()
end


-- Defines Array of controller items (buttons ...)
function init_items()

	local items = {

			{name = "Keyboard",   input = "keyboard", indexId = "Keyboard"},

-- Right hand special button row
			-- Play
			{name = "Button A", input = "button", output="value", indexId = "Vol_button"},
			-- Stop
			{name = "Button B", input = "button", output="value", indexId = "Pan_button"},
			-- Loop
			{name = "Button C", input = "button", output="value", indexId = "SndA_button"},
			-- Record
			{name = "Button D", input = "button", output="value", indexId = "SndB_button"},
			-- not used
			{name = "Button E", input = "button", output="value", indexId = "Stop_button"},
			-- Step Position Value Indicator
			{name = "Button F", input = "noinput", output="value", min=0, max=64, indexId = "TrkOn_button"},
			-- Previous Track
			{name = "Button G", input = "button", output="value", indexId = "Solo_button"},
			-- Next Track
			{name = "Button H", input = "button", output="value", indexId = "Arm_button"},

-- Step Sequencer row 1 and 2
		  {name = "Button 1-1", input = "button", output="value", min = 0, max = 127, indexId = "Button1_1"},
			{name = "Button 1-2", input = "button", output="value", min = 0, max = 127, indexId = "Button1_2"},
			{name = "Button 1-3", input = "button", output="value", min = 0, max = 127, indexId = "Button1_3"},
			{name = "Button 1-4", input = "button", output="value", min = 0, max = 127, indexId = "Button1_4"},
			{name = "Button 1-5", input = "button", output="value", min = 0, max = 127, indexId = "Button1_5"},
			{name = "Button 1-6", input = "button", output="value", min = 0, max = 127, indexId = "Button1_6"},
			{name = "Button 1-7", input = "button", output="value", min = 0, max = 127, indexId = "Button1_7"},
			{name = "Button 1-8", input = "button", output="value", min = 0, max = 127, indexId = "Button1_8"},

			{name = "Button 2-1", input = "button", output="value", min = 0, max = 127, indexId = "Button2_1"},
			{name = "Button 2-2", input = "button", output="value", min = 0, max = 127, indexId = "Button2_2"},
			{name = "Button 2-3", input = "button", output="value", min = 0, max = 127, indexId = "Button2_3"},
			{name = "Button 2-4", input = "button", output="value", min = 0, max = 127, indexId = "Button2_4"},
			{name = "Button 2-5", input = "button", output="value", min = 0, max = 127, indexId = "Button2_5"},
			{name = "Button 2-6", input = "button", output="value", min = 0, max = 127, indexId = "Button2_6"},
			{name = "Button 2-7", input = "button", output="value", min = 0, max = 127, indexId = "Button2_7"},
			{name = "Button 2-8", input = "button", output="value", min = 0, max = 127, indexId = "Button2_8"},

-- Select active ReDrum Channel
			{name = "Button 3-1", input = "button", output="value", min = 0, max = 127, indexId = "Button3_1"},
			{name = "Button 3-2", input = "button", output="value", min = 0, max = 127, indexId = "Button3_2"},
			{name = "Button 3-3", input = "button", output="value", min = 0, max = 127, indexId = "Button3_3"},
			{name = "Button 3-4", input = "button", output="value", min = 0, max = 127, indexId = "Button3_4"},
			{name = "Button 3-5", input = "button", output="value", min = 0, max = 127, indexId = "Button3_5"},
			{name = "Button 3-6", input = "button", output="value", min = 0, max = 127, indexId = "Button3_6"},
			{name = "Button 3-7", input = "button", output="value", min = 0, max = 127, indexId = "Button3_7"},
			{name = "Button 3-8", input = "button", output="value", min = 0, max = 127, indexId = "Button3_8"},

-- Mute ReDrum Channels
			{name = "Button 4-1", input = "button", output="value", min = 0, max = 127, indexId = "Button4_1"},
			{name = "Button 4-2", input = "button", output="value", min = 0, max = 127, indexId = "Button4_2"},
			{name = "Button 4-3", input = "button", output="value", min = 0, max = 127, indexId = "Button4_3"},
			{name = "Button 4-4", input = "button", output="value", min = 0, max = 127, indexId = "Button4_4"},
			{name = "Button 4-5", input = "button", output="value", min = 0, max = 127, indexId = "Button4_5"},
			{name = "Button 4-6", input = "button", output="value", min = 0, max = 127, indexId = "Button4_6"},
			{name = "Button 4-7", input = "button", output="value", min = 0, max = 127, indexId = "Button4_7"},
			{name = "Button 4-8", input = "button", output="value", min = 0, max = 127, indexId = "Button4_8"},

-- 5th row not used
			{name = "Button 5-1", input = "button", output="value", min = 0, max = 127, indexId = "Button5-1"},
			{name = "Button 5-2", input = "button", output="value", min = 0, max = 127, indexId = "Button5-2"},
			{name = "Button 5-3", input = "button", output="value", min = 0, max = 127, indexId = "Button5-3"},
			{name = "Button 5-4", input = "button", output="value", min = 0, max = 127, indexId = "Button5-4"},
			{name = "Button 5-5", input = "button", output="value", min = 0, max = 127, indexId = "Button5_5"},
			{name = "Button 5-6", input = "button", output="value", min = 0, max = 127, indexId = "Button5_6"},
			{name = "Button 5-7", input = "button", output="value", min = 0, max = 127, indexId = "Button5_7"},
			{name = "Button 5-8", input = "button", output="value", min = 0, max = 127, indexId = "Button5_8"},

-- Pattern Selection
			{name = "Button 6-1", input = "button", output="value", min = 0, max = 127, indexId = "Button6-1"},
			{name = "Button 6-2", input = "button", output="value", min = 0, max = 127, indexId = "Button6-2"},
			{name = "Button 6-3", input = "button", output="value", min = 0, max = 127, indexId = "Button6-3"},
			{name = "Button 6-4", input = "button", output="value", min = 0, max = 127, indexId = "Button6-4"},
			{name = "Button 6-5", input = "button", output="value", min = 0, max = 127, indexId = "Button6_5"},
			{name = "Button 6-6", input = "button", output="value", min = 0, max = 127, indexId = "Button6_6"},
			{name = "Button 6-7", input = "button", output="value", min = 0, max = 127, indexId = "Button6_7"},
			{name = "Button 6-8", input = "button", output="value", min = 0, max = 127, indexId = "Button6_8"},

-- Pattern Run Button, buttons 2, 3 and 4 not used
			{name = "Button 7-1", input = "button", output="value", min = 0, max = 127, indexId = "Button7_1"},
			{name = "Button 7-2", input = "button", output="value", min = 0, max = 127, indexId = "Button7_2"},
			{name = "Button 7-3", input = "button", output="value", min = 0, max = 127, indexId = "Button7_3"},
			{name = "Button 7-4", input = "button", output="value", min = 0, max = 127, indexId = "Button7_4"},

-- Pattern Bank Selection
			{name = "Button 7-5", input = "button", output="value", min = 0, max = 127, indexId = "Button7_5"},
			{name = "Button 7-6", input = "button", output="value", min = 0, max = 127, indexId = "Button7_6"},
			{name = "Button 7-7", input = "button", output="value", min = 0, max = 127, indexId = "Button7_7"},
			{name = "Button 7-8", input = "button", output="value", min = 0, max = 127, indexId = "Button7_8"},

-- Drum Pads 1-8
			{name = "Button 8-1", input = "noinput", output="value", min = 0, max = 1, indexId = "Button8_1"},
			{name = "Button 8-2", input = "noinput", output="value", min = 0, max = 1, indexId = "Button8_2"},
			{name = "Button 8-3", input = "noinput", output="value", min = 0, max = 1, indexId = "Button8_3"},
			{name = "Button 8-4", input = "noinput", output="value", min = 0, max = 1, indexId = "Button8_4"},
			{name = "Button 8-5", input = "noinput", output="value", min = 0, max = 1, indexId = "Button8_5"},
			{name = "Button 8-6", input = "noinput", output="value", min = 0, max = 1, indexId = "Button8_6"},
			{name = "Button 8-7", input = "noinput", output="value", min = 0, max = 1, indexId = "Button8_7"},
			{name = "Button 8-8", input = "noinput", output="value", min = 0, max = 1, indexId = "Button8_8"}
	}

	table.insert(items, { name="Bars Display", input="noinput", output="text" })
	g_bars_display_index = table.getn(items)

-- get the indices of each item and store it in global array g_controls
-- later, we can access each item via its "indexId" attribute (provided in the item definition above)
-- to get its index (like g_controls.vol_button) ...
-- thx to user "catblack" from the official propellerhead dev forum for this nice trick :) !
	for it=1,table.getn(items),1 do
		if items[it].indexId then
			if items[it].indexId ~= nil then
				g_controls[items[it].indexId]=it
			end
		end
	end

	remote.define_items(items)

end

function init_inputs()

	local inputs = {

-- Right column special buttons
			{pattern="<100x>? " .. g_cc_for_buttons.button_a .. " 7F", name="Button A"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_b .. " 7F", name="Button B"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_c .. " 7F", name="Button C"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_d .. " 7F", name="Button D"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_e .. " 7F", name="Button E"},
		-- {pattern="<100x>? " .. g_cc_for_buttons.button_f .. " 7F", name="Button F"},No input, Button used for tracking of pattern step
			{pattern="<100x>? " .. g_cc_for_buttons.button_g .. " 7F", name="Button G"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_h .. " 7F", name="Button H"},

-- Sequencer
			{pattern="<100x>? " .. g_cc_for_buttons.button_1_1 .. " 7F", name="Button 1-1"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_1_2 .. " 7F", name="Button 1-2"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_1_3 .. " 7F", name="Button 1-3"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_1_4 .. " 7F", name="Button 1-4"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_1_5 .. " 7F", name="Button 1-5"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_1_6 .. " 7F", name="Button 1-6"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_1_7 .. " 7F", name="Button 1-7"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_1_8 .. " 7F", name="Button 1-8"},

			{pattern="<100x>? " .. g_cc_for_buttons.button_2_1 .. " 7F", name="Button 2-1"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_2_2 .. " 7F", name="Button 2-2"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_2_3 .. " 7F", name="Button 2-3"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_2_4 .. " 7F", name="Button 2-4"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_2_5 .. " 7F", name="Button 2-5"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_2_6 .. " 7F", name="Button 2-6"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_2_7 .. " 7F", name="Button 2-7"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_2_8 .. " 7F", name="Button 2-8"},

-- Select acive ReDrum Channel
			{pattern="<100x>? " .. g_cc_for_buttons.button_3_1 .. " 7F", name="Button 3-1"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_3_2 .. " 7F", name="Button 3-2"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_3_3 .. " 7F", name="Button 3-3"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_3_4 .. " 7F", name="Button 3-4"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_3_5 .. " 7F", name="Button 3-5"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_3_6 .. " 7F", name="Button 3-6"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_3_7 .. " 7F", name="Button 3-7"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_3_8 .. " 7F", name="Button 3-8"},

-- Mute ReDrum Channels
			{pattern="<100x>? " .. g_cc_for_buttons.button_4_1 .. " 7F", name="Button 4-1"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_4_2 .. " 7F", name="Button 4-2"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_4_3 .. " 7F", name="Button 4-3"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_4_4 .. " 7F", name="Button 4-4"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_4_5 .. " 7F", name="Button 4-5"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_4_6 .. " 7F", name="Button 4-6"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_4_7 .. " 7F", name="Button 4-7"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_4_8 .. " 7F", name="Button 4-8"},

-- not used
		-- {pattern="<100x>? " .. g_cc_for_buttons.button_5_5 .. " 7F", name="Button 5-5"},
		-- {pattern="<100x>? " .. g_cc_for_buttons.button_5_6 .. " 7F", name="Button 5-6"},
		-- {pattern="<100x>? " .. g_cc_for_buttons.button_5_7 .. " 7F", name="Button 5-7"},
		-- {pattern="<100x>? " .. g_cc_for_buttons.button_5_8 .. " 7F", name="Button 5-8"},

-- Pattern Selection
			{pattern="<100x>? " .. g_cc_for_buttons.button_6_1 .. " 7F", name="Button 6-1"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_6_2 .. " 7F", name="Button 6-2"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_6_3 .. " 7F", name="Button 6-3"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_6_4 .. " 7F", name="Button 6-4"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_6_5 .. " 7F", name="Button 6-5"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_6_6 .. " 7F", name="Button 6-6"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_6_7 .. " 7F", name="Button 6-7"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_6_8 .. " 7F", name="Button 6-8"},

-- Run
		{pattern="<100x>? " .. g_cc_for_buttons.button_7_1 .. " 7F", name="Button 7-1"},
		-- {pattern="<100x>? " .. g_cc_for_buttons.button_7_2 .. " 7F", name="Button 7-2"},
		-- {pattern="<100x>? " .. g_cc_for_buttons.button_7_3 .. " 7F", name="Button 7-3"},
		-- {pattern="<100x>? " .. g_cc_for_buttons.button_7_4 .. " 7F", name="Button 7-4"},

-- ReDrum Bank Selection
			{pattern="<100x>? " .. g_cc_for_buttons.button_7_5 .. " 7F", name="Button 7-5"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_7_6 .. " 7F", name="Button 7-6"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_7_7 .. " 7F", name="Button 7-7"},
			{pattern="<100x>? " .. g_cc_for_buttons.button_7_8 .. " 7F", name="Button 7-8"},

-- Drum Pads
			{pattern="<100?>? " .. g_cc_for_buttons.button_8_1 .. " ?<???x>", name="Keyboard", value="x", note="36", velocity="100"},
			{pattern="<100?>? " .. g_cc_for_buttons.button_8_2 .. " ?<???x>", name="Keyboard", value="x", note="37", velocity="100"},
			{pattern="<100?>? " .. g_cc_for_buttons.button_8_3 .. " ?<???x>", name="Keyboard", value="x", note="38", velocity="100"},
			{pattern="<100?>? " .. g_cc_for_buttons.button_8_4 .. " ?<???x>", name="Keyboard", value="x", note="39", velocity="100"},
			{pattern="<100?>? " .. g_cc_for_buttons.button_8_5 .. " ?<???x>", name="Keyboard", value="x", note="40", velocity="100"},
			{pattern="<100?>? " .. g_cc_for_buttons.button_8_6 .. " ?<???x>", name="Keyboard", value="x", note="41", velocity="100"},
			{pattern="<100?>? " .. g_cc_for_buttons.button_8_7 .. " ?<???x>", name="Keyboard", value="x", note="42", velocity="100"},
			{pattern="<100?>? " .. g_cc_for_buttons.button_8_8 .. " ?<???x>", name="Keyboard", value="x", note="43", velocity="100"}
	}

	remote.define_auto_inputs(inputs)
end

function init_outputs()

	local outputs = {

		{name = "Button 1-1", pattern = "90 " .. g_cc_for_buttons.button_1_1 .. " xx", x = "enabled*value*46"},
		{name = "Button 1-2", pattern = "90 " .. g_cc_for_buttons.button_1_2 .. " xx", x = "enabled*value*46"},
		{name = "Button 1-3", pattern = "90 " .. g_cc_for_buttons.button_1_3 .. " xx", x = "enabled*value*46"},
		{name = "Button 1-4", pattern = "90 " .. g_cc_for_buttons.button_1_4 .. " xx", x = "enabled*value*46"},
		{name = "Button 1-5", pattern = "90 " .. g_cc_for_buttons.button_1_5 .. " xx", x = "enabled*value*46"},
		{name = "Button 1-6", pattern = "90 " .. g_cc_for_buttons.button_1_6 .. " xx", x = "enabled*value*46"},
		{name = "Button 1-7", pattern = "90 " .. g_cc_for_buttons.button_1_7 .. " xx", x = "enabled*value*46"},
		{name = "Button 1-8", pattern = "90 " .. g_cc_for_buttons.button_1_8 .. " xx", x = "enabled*value*46"},

		{name = "Button 2-1", pattern = "90 " .. g_cc_for_buttons.button_2_1 .. " xx", x = "enabled*value*46"},
		{name = "Button 2-2", pattern = "90 " .. g_cc_for_buttons.button_2_2 .. " xx", x = "enabled*value*46"},
		{name = "Button 2-3", pattern = "90 " .. g_cc_for_buttons.button_2_3 .. " xx", x = "enabled*value*46"},
		{name = "Button 2-4", pattern = "90 " .. g_cc_for_buttons.button_2_4 .. " xx", x = "enabled*value*46"},
		{name = "Button 2-5", pattern = "90 " .. g_cc_for_buttons.button_2_5 .. " xx", x = "enabled*value*46"},
		{name = "Button 2-6", pattern = "90 " .. g_cc_for_buttons.button_2_6 .. " xx", x = "enabled*value*46"},
		{name = "Button 2-7", pattern = "90 " .. g_cc_for_buttons.button_2_7 .. " xx", x = "enabled*value*46"},
		{name = "Button 2-8", pattern = "90 " .. g_cc_for_buttons.button_2_8 .. " xx", x = "enabled*value*46"},


		{name = "Button 3-1", pattern = "90 " .. g_cc_for_buttons.button_3_1 .. " xx", x = "enabled*value*63"},
		{name = "Button 3-2", pattern = "90 " .. g_cc_for_buttons.button_3_2 .. " xx", x = "enabled*value*63"},
		{name = "Button 3-3", pattern = "90 " .. g_cc_for_buttons.button_3_3 .. " xx", x = "enabled*value*63"},
		{name = "Button 3-4", pattern = "90 " .. g_cc_for_buttons.button_3_4 .. " xx", x = "enabled*value*63"},
		{name = "Button 3-5", pattern = "90 " .. g_cc_for_buttons.button_3_5 .. " xx", x = "enabled*value*63"},
		{name = "Button 3-6", pattern = "90 " .. g_cc_for_buttons.button_3_6 .. " xx", x = "enabled*value*63"},
		{name = "Button 3-7", pattern = "90 " .. g_cc_for_buttons.button_3_7 .. " xx", x = "enabled*value*63"},
		{name = "Button 3-8", pattern = "90 " .. g_cc_for_buttons.button_3_8 .. " xx", x = "enabled*value*63"},

		{name = "Button 4-1", pattern = "90 " .. g_cc_for_buttons.button_4_1 .. " xx", x = "enabled*value*15"},
		{name = "Button 4-2", pattern = "90 " .. g_cc_for_buttons.button_4_2 .. " xx", x = "enabled*value*15"},
		{name = "Button 4-3", pattern = "90 " .. g_cc_for_buttons.button_4_3 .. " xx", x = "enabled*value*15"},
		{name = "Button 4-4", pattern = "90 " .. g_cc_for_buttons.button_4_4 .. " xx", x = "enabled*value*15"},
		{name = "Button 4-5", pattern = "90 " .. g_cc_for_buttons.button_4_5 .. " xx", x = "enabled*value*15"},
		{name = "Button 4-6", pattern = "90 " .. g_cc_for_buttons.button_4_6 .. " xx", x = "enabled*value*15"},
		{name = "Button 4-7", pattern = "90 " .. g_cc_for_buttons.button_4_7 .. " xx", x = "enabled*value*15"},
		{name = "Button 4-8", pattern = "90 " .. g_cc_for_buttons.button_4_8 .. " xx", x = "enabled*value*15"},

		-- {name = "Button 5-1", pattern = "90 " .. g_cc_for_buttons.button_5_1 .. " xx", x = "enabled*value*1+56"},
		-- {name = "Button 5-2", pattern = "90 " .. g_cc_for_buttons.button_5_2 .. " xx", x = "enabled*value*1+56"},
		-- {name = "Button 5-3", pattern = "90 " .. g_cc_for_buttons.button_5_3 .. " xx", x = "enabled*value*1+56"},
		-- {name = "Button 5-4", pattern = "90 " .. g_cc_for_buttons.button_5_4 .. " xx", x = "enabled*value*1+56"},
		-- {name = "Button 5-5", pattern = "90 " .. g_cc_for_buttons.button_5_5 .. " xx", x = "enabled*value*63"},
		-- {name = "Button 5-6", pattern = "90 " .. g_cc_for_buttons.button_5_6 .. " xx", x = "enabled*value*63"},
	  -- {name = "Button 5-7", pattern = "90 " .. g_cc_for_buttons.button_5_7 .. " xx", x = "enabled*value*63"},
		-- {name = "Button 5-8", pattern = "90 " .. g_cc_for_buttons.button_5_8 .. " xx", x = "enabled*value*63"},

		{name = "Button 6-1", pattern = "90 " .. g_cc_for_buttons.button_6_1 .. " xx", x = "enabled*value*63"},
		{name = "Button 6-2", pattern = "90 " .. g_cc_for_buttons.button_6_2 .. " xx", x = "enabled*value*63"},
		{name = "Button 6-3", pattern = "90 " .. g_cc_for_buttons.button_6_3 .. " xx", x = "enabled*value*63"},
		{name = "Button 6-4", pattern = "90 " .. g_cc_for_buttons.button_6_4 .. " xx", x = "enabled*value*63"},
		{name = "Button 6-5", pattern = "90 " .. g_cc_for_buttons.button_6_5 .. " xx", x = "enabled*value*63"},
		{name = "Button 6-6", pattern = "90 " .. g_cc_for_buttons.button_6_6 .. " xx", x = "enabled*value*63"},
		{name = "Button 6-7", pattern = "90 " .. g_cc_for_buttons.button_6_7 .. " xx", x = "enabled*value*63"},
		{name = "Button 6-8", pattern = "90 " .. g_cc_for_buttons.button_6_8 .. " xx", x = "enabled*value*63"},

		{name = "Button 7-1", pattern = "90 " .. g_cc_for_buttons.button_7_1 .. " xx", x = "enabled*value*1+31"},
		-- {name = "Button 7-2", pattern = "90 " .. g_cc_for_buttons.button_7_2 .. " xx", x = "enabled*value*1+56"},
		-- {name = "Button 7-3", pattern = "90 " .. g_cc_for_buttons.button_7_3 .. " xx", x = "enabled*value*1+56"},
		-- {name = "Button 7-4", pattern = "90 " .. g_cc_for_buttons.button_7_4 .. " xx", x = "enabled*value*1+56"},
		{name = "Button 7-5", pattern = "90 " .. g_cc_for_buttons.button_7_5 .. " xx", x = "enabled*value*15"},
		{name = "Button 7-6", pattern = "90 " .. g_cc_for_buttons.button_7_6 .. " xx", x = "enabled*value*15"},
		{name = "Button 7-7", pattern = "90 " .. g_cc_for_buttons.button_7_7 .. " xx", x = "enabled*value*15"},
		{name = "Button 7-8", pattern = "90 " .. g_cc_for_buttons.button_7_8 .. " xx", x = "enabled*value*15"},

		{name = "Button 8-1", pattern = "90 " .. g_cc_for_buttons.button_8_1 .. " xx", x = "enabled*value*1+51"},
		{name = "Button 8-2", pattern = "90 " .. g_cc_for_buttons.button_8_2 .. " xx", x = "enabled*value*1+51"},
		{name = "Button 8-3", pattern = "90 " .. g_cc_for_buttons.button_8_3 .. " xx", x = "enabled*value*1+51"},
		{name = "Button 8-4", pattern = "90 " .. g_cc_for_buttons.button_8_4 .. " xx", x = "enabled*value*1+51"},
		{name = "Button 8-5", pattern = "90 " .. g_cc_for_buttons.button_8_5 .. " xx", x = "enabled*value*1+51"},
		{name = "Button 8-6", pattern = "90 " .. g_cc_for_buttons.button_8_6 .. " xx", x = "enabled*value*1+51"},
		{name = "Button 8-7", pattern = "90 " .. g_cc_for_buttons.button_8_7 .. " xx", x = "enabled*value*1+51"},
		{name = "Button 8-8", pattern = "90 " .. g_cc_for_buttons.button_8_8 .. " xx", x = "enabled*value*1+51"},

		{name = "Button A", pattern = "90 " .. g_cc_for_buttons.button_a .. " xx", x = "enabled*value*56"},
		{name = "Button B", pattern = "90 " .. g_cc_for_buttons.button_b .. " xx", x = "enabled*value*63"},
		{name = "Button C", pattern = "90 " .. g_cc_for_buttons.button_c .. " xx", x = "enabled*value*63"},
		{name = "Button D", pattern = "90 " .. g_cc_for_buttons.button_d .. " xx", x = "enabled*value*15"},
		{name = "Button E", pattern = "90 " .. g_cc_for_buttons.button_e .. " xx", x = "enabled*value*15"},
		{name = "Button F", pattern = "90 " .. g_cc_for_buttons.button_f .. " xx", x = "value"},
		{name = "Button G", pattern = "90 " .. g_cc_for_buttons.button_g .. " xx", x = "enabled*value*15+1"},
		{name = "Button H", pattern = "90 " .. g_cc_for_buttons.button_h .. " xx", x = "enabled*value*15+1"},
	}

	remote.define_auto_outputs(outputs)
end

-- function is called whenever Reason delivers Midi to the controller
function remote_deliver_midi()

	local ret_events={}

-- Colours used for step sequencer rows
-- Can be changed easily
	local led_colours = {
		step_seq_off = "50",
		step_seq_on  = "70",
		step_drum      = "62",
		step_drum_play = "16"
	}

-- Process step sequencer rows (and colors of each of the 16 buttons on the Launchpad)
-- TrkOn_button is mapped to "Playing Step" in the .remotemap
-- So this buttons always stores the currently played step of the ReDrum Sequencer as its value
-- Depending on its value, color calculation is done and "remote.make_midi" sends Midi-Data back to the Launchpad
	if(remote.get_item_state(g_controls.TrkOn_button).value == 1) then
		if (remote.get_item_state(g_controls.Button1_1).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_1 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_1 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button1_1).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_1 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_1 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 2) then
		if (remote.get_item_state(g_controls.Button1_2).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_2 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_2 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button1_2).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_2 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_2 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 3) then
		if (remote.get_item_state(g_controls.Button1_3).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_3 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_3 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button1_3).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_3 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_3 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 4) then
		if (remote.get_item_state(g_controls.Button1_4).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_4 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_4 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button1_4).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_4 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_4 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 5) then
		if (remote.get_item_state(g_controls.Button1_5).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_5 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_5 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button1_5).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_5 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_5 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 6) then
		if (remote.get_item_state(g_controls.Button1_6).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_6 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_6 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button1_6).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_6 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_6 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 7) then
		if (remote.get_item_state(g_controls.Button1_7).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_7 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_7 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button1_7).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_7 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_7 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 8) then
		if (remote.get_item_state(g_controls.Button1_8).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_8 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_8 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button1_8).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_8 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_1_8 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 9) then
		if (remote.get_item_state(g_controls.Button2_1).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_1 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_1 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button2_1).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_1 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_1 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 10) then
		if (remote.get_item_state(g_controls.Button2_2).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_2 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_2 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button2_2).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_2 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_2 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 11) then
		if (remote.get_item_state(g_controls.Button2_3).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_3 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_3 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button2_3).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_3 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_3 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 12) then
		if (remote.get_item_state(g_controls.Button2_4).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_4 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_4 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button2_4).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_4 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_4 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 13) then
		if (remote.get_item_state(g_controls.Button2_5).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_5 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_5 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button2_5).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_5 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_5 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 14) then
		if (remote.get_item_state(g_controls.Button2_6).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_6 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_6 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button2_6).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_6 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_6 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 15) then
		if (remote.get_item_state(g_controls.Button2_7).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_7 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_7 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button2_7).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_7 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_7 .. " " .. led_colours.step_seq_off))
		end
	end
	if(remote.get_item_state(g_controls.TrkOn_button).value == 0) then
		if (remote.get_item_state(g_controls.Button2_8).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_8 .. " " .. led_colours.step_drum_play))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_8 .. " " .. led_colours.step_seq_on))
		end
	else
		if (remote.get_item_state(g_controls.Button2_8).value == 1) then
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_8 .. " " .. led_colours.step_drum))
		else
			table.insert(ret_events, remote.make_midi("90 " .. g_cc_for_buttons.button_2_8 .. " " .. led_colours.step_seq_off))
		end
	end


-- Processing the play bar (top row of buttons)
-- done by TONAL AXIS
	if g_delivered_bar ~= g_current_bar then

		if g_current_bar < 1 then table.insert(ret_events, remote.make_midi("B0 68 00")) end
		if g_current_bar < 2 then table.insert(ret_events, remote.make_midi("B0 69 00")) end
		if g_current_bar < 3 then table.insert(ret_events, remote.make_midi("B0 6A 00")) end
		if g_current_bar < 4 then table.insert(ret_events, remote.make_midi("B0 6B 00")) end
		if g_current_bar < 5 then table.insert(ret_events, remote.make_midi("B0 6C 00")) end
		if g_current_bar < 6 then table.insert(ret_events, remote.make_midi("B0 6D 00")) end
		if g_current_bar < 7 then table.insert(ret_events, remote.make_midi("B0 6E 00")) end
		if g_current_bar < 8 then table.insert(ret_events, remote.make_midi("B0 6F 00")) end

		if g_current_bar > 0 then table.insert(ret_events, remote.make_midi("B0 68 60")) end
		if g_current_bar > 1 then table.insert(ret_events, remote.make_midi("B0 69 60")) end
		if g_current_bar > 2 then table.insert(ret_events, remote.make_midi("B0 6A 60")) end
		if g_current_bar > 3 then table.insert(ret_events, remote.make_midi("B0 6B 60")) end
		if g_current_bar > 4 then table.insert(ret_events, remote.make_midi("B0 6C 60")) end
		if g_current_bar > 5 then table.insert(ret_events, remote.make_midi("B0 6D 60")) end
		if g_current_bar > 6 then table.insert(ret_events, remote.make_midi("B0 6E 60")) end
		if g_current_bar > 7 then table.insert(ret_events, remote.make_midi("B0 6F 60")) end
	end

	g_delivered_bar = g_current_bar

	return ret_events
end

function remote_set_state(changed_items)
	for kk,item_index in ipairs(changed_items) do
		if item_index == g_bars_display_index then
			if remote.is_item_enabled(item_index) then
				g_current_bar = get_relative_bar(remote.get_item_text_value(item_index))
			else
				g_current_bar = -1
			end
		end
	end

	return false
end

function get_relative_bar(s)
	local n=tonumber(s)
	n = n - math.floor(n/8)*8
	return (n == 0) and 8 or n
end
