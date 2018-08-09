package.path = package.path ..';./Scripts/DemoScenes/?.lua;'
local sceneEnvironment = require("demosceneEnvironment")

scene = {} -- ���� ������ ��� ��������� �������

function loadScene(scenePtr)
	sceneAPI = sceneEnvironment.getInterface(scenePtr)
	sceneAPI:setUpdateFunc('sceneVRUpdate')

	--closest uh-1	(pilot)
	scene.m			= sceneAPI:addModel("ab-212", -1, 1.95, -3.0);
	scene.m:setLivery("Army Standard", "uh-1h");
	scene.m:setArgument(0, 1); --front gear
	scene.m:setArgument(1, 0.2); --front gear shocks
	scene.m:setArgument(3, 1); --right gear
	scene.m:setArgument(4, 0.2); --right gear shocks
	scene.m:setArgument(5, 1); --left gear
	scene.m:setArgument(6, 0.2); --left gear shocks
	scene.m:setArgument(15, -0.2); --right aileron
	scene.m:setArgument(16, -0.2); --left aileron
	scene.m:setArgument(38, 0.9); --Canopy
	scene.m:setArgument(50, 0.5); --Pilot

	--none of these seem to work
	--scene.m.setArgument(33, 1); --prop rotation (0 = 0-360deg)
	--scene.m.setArgument(33, 1); --weapon pylons
	--scene.m.setArgument(39, 1); --pilot head angle (-1 left 1 right)
	--scene.m.setArgument(49, 1); --navigation lights
	--scene.m.setArgument(208, 1); --landing lamp 1
	--scene.m.setArgument(83, 1); --strobe lights
	--scene.m.setArgument(88, 1); --formation lights
	--scene.m.setArgument(81, 1); --tail section destroy
	--scene.m.setArgument(82, 1); --nose section damages

	--more backwards separation
	-- less vertical seperation
	-- more chaos

	--airborne uh-1 1 RIGHT
	--                                         dp  ht  +l/-r
  scene.m			= sceneAPI:addModel("ab-212", -10, 22, 14);
	scene.m:setLivery("Army Standard", "uh-1h");
	scene.m:setArgument(50, 0.5); --Pilot
	--                        roll yaw pitch
	--                        +L   +L  +Up
	scene.m.transform:rotate(2, 15, 0);

	--airborne uh-1 2 LEFT
  scene.m			= sceneAPI:addModel("ab-212", -18, 23, 2);
	scene.m:setLivery("Army Standard", "uh-1h");
	scene.m:setArgument(50, 0.5); --Pilot
	scene.m.transform:rotate(-7, -5, 5);

	--airborne uh-1 3 RIGHT
  scene.m			= sceneAPI:addModel("ab-212", -28, 34, 18);
	scene.m:setLivery("Army Standard", "uh-1h");
	scene.m:setArgument(50, 0.5); --Pilot
	scene.m.transform:rotate(5, 0, 10);

	--airborne uh-1 4 LEFT
  scene.m			= sceneAPI:addModel("ab-212", -40, 29, 0);
	scene.m:setLivery("Army Standard", "uh-1h");
	scene.m:setArgument(50, 0.5); --Pilot
	scene.m.transform:rotate(-3, 0, -3);

	--airborne uh-1 5 RIGHT
	scene.m			= sceneAPI:addModel("ab-212", -50, 37, 14);
	scene.m:setLivery("Army Standard", "uh-1h");
	scene.m:setArgument(50, 0.5); --Pilot
	scene.m.transform:rotate(0, 15, 10);

	--rearward uh-1 (pilot)
	scene.m			= sceneAPI:addModel("ab-212", -25, 1.95, -5);
	scene.m:setLivery("Army Standard", "uh-1h");
	scene.m:setArgument(0, 1); --front gear
	scene.m:setArgument(1, 0.2); --front gear shocks
	scene.m:setArgument(3, 1); --right gear
	scene.m:setArgument(4, 0.2); --right gear shocks
	scene.m:setArgument(5, 1); --left gear
	scene.m:setArgument(6, 0.2); --left gear shocks
	scene.m:setArgument(15, -0.2); --right aileron
	scene.m:setArgument(16, -0.2); --left aileron
	scene.m:setArgument(38, 0.9); --Canopy
	scene.m:setArgument(50, 0.5); --Pilot

	--left guard
	scene.m			= sceneAPI:addModel("soldier_m4", -20, .4, -10);

	--another uh-1 (pilot)
	scene.m			= sceneAPI:addModel("ab-212", 20, 1.95, 0);
	scene.m:setLivery("Army Standard", "uh-1h");
    	scene.m:setArgument(0, 1); --front gear
	scene.m:setArgument(1, 0.2); --front gear shocks
	scene.m:setArgument(3, 1); --right gear
	scene.m:setArgument(4, 0.2); --right gear shocks
	scene.m:setArgument(5, 1); --left gear
	scene.m:setArgument(6, 0.2); --left gear shocks
	scene.m:setArgument(15, -0.2); --right aileron
	scene.m:setArgument(16, -0.2); --left aileron
	scene.m:setArgument(38, 0.9); --Canopy
	scene.m:setArgument(50, 0.5); --Pilot

	--palaktas
    	scene.m			= sceneAPI:addModel("palatka", -3, .2, 12.0);
	scene.m			= sceneAPI:addModel("palatka", 12, .2, 12.0);

	--guard 2
	scene.m			= sceneAPI:addModel("soldier_m4", 2, .4, 5.0);

	--camera & other
	local cam_level = 1.0

	scene.cam = sceneAPI:addCamera(3, cam_level , 1.5)
	scene.cam:setFov(90)
	scene.cam.transform:lookAtPoint(-5.0, cam_level, 5);


	scene.flr		= sceneAPI:addModel("farp", 0,-1,0);
	scene.flr:drawToEnvironment(true);
	scene.flr.transform:scale(2,1.5,1.5);

	--scene.sh		= sceneAPI:addModel("ukrytie", 0,0,0);
	--scene.sh:drawToEnvironment(true);
	--scene.sh.transform:scale(2,2,2);

	scene.cam:setActive()
end

--[0;1]
local function pingpong(length, t)
	local tt = (t%length)*2/length
	if tt>1 then tt = 2-tt end
	return tt
end


function sceneVRUpdate(t, dt)

end
