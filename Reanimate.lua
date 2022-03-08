function LoadReanimation(Type,Velocity,Anims,FlingNow,LoadLib)
  local Reanimate = Type or "Raw"
  local NetlessValue = Velocity or Vector3.new(28.5,0,-1)
  local IsAnimating = Anims or false
  local FlingForBullet = FlingNow or false
  local LoadLibNow = LoadLib or false
  _G.IHaveYourIP = false
  if Reanimate == "Death" then
    game.Players.LocalPlayer["Character"]:FindFirstChildOfClass("Humanoid").BreakJointsOnDeath = false
    spawn(function()
       game.Players.LocalPlayer["Character"] = nil
       game.Players.LocalPlayer["Character"] = workspace[game.Players.LocalPlayer.Name]
    end)
    wait(game.Players.RespawnTime + 0.7)
    game.Players.LocalPlayer["Character"]:FindFirstChildOfClass("Humanoid").Health = 0
    game.Players.LocalPlayer["Character"]:FindFirstChildOfClass("Humanoid").BreakJointsOnDeath = false
  end
  --- Startup
  --[[
  No Align because too weak + code shit.
  Reanimate By Gelatek.
  ]]
  local Stepped = game:GetService("RunService").Stepped
  local Heartbeat = game:GetService("RunService").Heartbeat
  local Main = nil;
  local Misc = nil;
  
  local Character = game.Players.LocalPlayer["Character"]
  local Torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
  local Humanoid = Character:FindFirstChildOfClass("Humanoid") 
  Character.Archivable = true
  Character.Animate.Disabled = true
  for Index, Child in pairs(Humanoid:GetPlayingAnimationTracks()) do
    if Child:IsA("NumberValue") then -- All body modifications in R15.
      Child:Destroy()
    end
  end
  wait(0.05)
  local Raw = game:GetObjects("rbxassetid://8440552086")[1]
  Raw.Parent = workspace
  Raw.Name = "Raw"
  local RawTorso = Raw:FindFirstChild("Torso")
  local RawHumanoid = Raw:FindFirstChildOfClass("Humanoid")
  for Index, Child in pairs(Raw:GetDescendants()) do
    if Child:IsA("BasePart") or Child:IsA("Decal") then
       Child.Transparency = 1
    end
  end
  
  for Index, Child in pairs(Character:GetChildren()) do
    if Child:IsA("Accessory") then
       local ClonedAccessories = Child:Clone()
       ClonedAccessories.Parent = Raw
       ClonedAccessories.Handle.Transparency = 1
       Child.Handle:BreakJoints()
    end
  end
  Misc = Stepped:Connect(function()
    for Index, Child in pairs(Character:GetDescendants()) do
      if Child:IsA("BasePart") or Child:IsA("MeshPart") then
        Child.CanCollide = false -- clientside collision off
      end
    end
    RawHumanoid:Move(Humanoid.MoveDirection, false) -- movement
    for Index, Animations in pairs(Humanoid:GetPlayingAnimationTracks()) do
      Animations:Stop() -- stop head moving around.
    end
    game.Players.LocalPlayer.ReplicationFocus = workspace
    workspace.FallenPartsDestroyHeight = -math.huge
  end)
  for Index, Child in pairs(Character:GetDescendants()) do
    if Reanimate == "Death" then
       if Child:IsA("Motor6D") then
          Child:Destroy()
       end
    elseif Reanimate ~= "Death" then
       if Child:IsA("Motor6D") and Child.Name ~= "Neck" then
          Child:Destroy()
       end
    end
  end
  if Reanimate == "Bullet" then
	Humanoid:ChangeState("Physics")
  end
  if Humanoid.RigType == Enum.HumanoidRigType.R15 and Reanimate == "Death" then
  	
  end
  Raw.Parent = Character
  Raw.HumanoidRootPart.CFrame = Torso.CFrame
  Main = Heartbeat:Connect(function()
    for Index,Child in pairs(Character:GetChildren()) do
      if Child:IsA("MeshPart") or Child:IsA("BasePart") and Child.Name ~= "Torso" and Child.Name ~= "UpperTorso" then
        Child.Velocity = NetlessValue
      elseif Child:IsA("Accessory") then 
        Child.Handle.Velocity = NetlessValue
      end
    end
    if Reanimate == "Fling" then
    Torso.Velocity = Vector3.new(2500,2500,2500)
    else
    Torso.Velocity = NetlessValue
	end	
    
    if Humanoid.Jump == true then
      RawHumanoid.Jump = true
      RawHumanoid.Sit = false
    end
    if Humanoid.RigType == Enum.HumanoidRigType.R6 then
    Torso.CFrame = RawTorso.CFrame
	if Reanimate == "Bullet" then
		if _G.IHaveYourIP == false then
			Character["Right Arm"].CFrame = Raw["Right Arm"].CFrame
		end
		if Character:FindFirstChild("Pal Hair") then
         	Character:FindFirstChild("Pal Hair").Handle.CFrame = Raw['Right Arm'].CFrame * CFrame.Angles(math.rad(90),0,0)
		end
	elseif Reanimate ~= "Bullet" then
		Character["Right Arm"].CFrame = Raw["Right Arm"].CFrame
	end
    Character["Left Arm"].CFrame = Raw["Left Arm"].CFrame
    Character["Right Leg"].CFrame = Raw["Right Leg"].CFrame
    Character["Left Leg"].CFrame = Raw["Left Leg"].CFrame
    if Reanimate == "Death" then
    	
      Character["Head"].CFrame = Raw["Head"].CFrame
    end
    elseif Humanoid.RigType == Enum.HumanoidRigType.R15 then
      Character["UpperTorso"].CFrame = Raw["Torso"].CFrame * CFrame.new(0, 0.195, 0)
      Character.HumanoidRootPart.CFrame = Character["UpperTorso"].CFrame + Vector3.new(0, -0.16, 0)
      Character["LowerTorso"].CFrame = Raw["Torso"].CFrame * CFrame.new(0, -0.76, 0)
      if Reanimate == "Bullet" or Reanimate == "Death" then
         if _G.IHaveYourIP == false then
            Character["RightUpperArm"].CFrame = Raw["Right Arm"].CFrame * CFrame.new(0, 0.41, 0)
         end
		if Character:FindFirstChild("CorpoDefShoulderR") then
         	Character:FindFirstChild("CorpoDefShoulderR").Handle.CFrame = Raw['Right Arm'].CFrame * CFrame.new(0,0.6,0)
		end
      elseif Reanimate == "Raw" or Reanimate == "Fling" then
         Character["RightUpperArm"].CFrame = Raw["Right Arm"].CFrame * CFrame.new(0, 0.41, 0)
      end
      Character["RightLowerArm"].CFrame = Raw["Right Arm"].CFrame * CFrame.new(0, -0.16, 0)
      Character["RightHand"].CFrame = Raw["Right Arm"].CFrame * CFrame.new(0, -0.8, 0)
  
      Character["LeftUpperArm"].CFrame = Raw["Left Arm"].CFrame * CFrame.new(0, 0.41, 0)
      Character["LeftLowerArm"].CFrame = Raw["Left Arm"].CFrame * CFrame.new(0, -0.16, 0)
      Character["LeftHand"].CFrame = Raw["Left Arm"].CFrame * CFrame.new(0, -0.8, 0)
  
      Character["RightUpperLeg"].CFrame = Raw["Right Leg"].CFrame * CFrame.new(0, 0.6, 0)
      Character["RightLowerLeg"].CFrame = Raw["Right Leg"].CFrame * CFrame.new(0, -0.15, 0)
      Character["RightFoot"].CFrame = Raw["Right Leg"].CFrame * CFrame.new(0, -0.85, 0)
  
      Character["LeftUpperLeg"].CFrame = Raw["Left Leg"].CFrame * CFrame.new(0, 0.6, 0)
      Character["LeftLowerLeg"].CFrame = Raw["Left Leg"].CFrame * CFrame.new(0, -0.15, 0)
      Character["LeftFoot"].CFrame = Raw["Left Leg"].CFrame * CFrame.new(0, -0.85, 0)
      if Reanimate == "Death" then
        Character["Head"].CFrame = Raw["Head"].CFrame
      end
    end
    for Index, Child in pairs(Character:GetChildren()) do
    	if Reanimate == "Bullet" and Humanoid.RigType == Enum.HumanoidRigType.R6 then
			if Child:IsA("Accessory") and Child.Name ~= "Pal Hair" then
			   Child.Handle.CFrame = Raw[Child.Name].Handle.CFrame
			end
		elseif Reanimate == "Bullet" and Humanoid.RigType == Enum.HumanoidRigType.R15 then
			if Child:IsA("Accessory") and Child.Name ~= "CorpoDefShoulderR" then
			   Child.Handle.CFrame = Raw[Child.Name].Handle.CFrame
			end
		elseif Reanimate == "Death" and Humanoid.RigType == Enum.HumanoidRigType.R15 then
			if Child:IsA("Accessory") and Child.Name ~= "CorpoDefShoulderR" then
			   Child.Handle.CFrame = Raw[Child.Name].Handle.CFrame
			end
		elseif Reanimate == "Death" then
			if Child:IsA("Accessory") then
			   Child.Handle.CFrame = Raw[Child.Name].Handle.CFrame
			end
		elseif Reanimate == "Raw" or Reanimate == "Fling" then
			if Child:IsA("Accessory") then
			   Child.Handle.CFrame = Raw[Child.Name].Handle.CFrame
			end
		end
     end
  end)
  
  if Humanoid.RigType == Enum.HumanoidRigType.R6 and Reanimate ~= "Death" then
  Character.HumanoidRootPart:Destroy()
  elseif Humanoid.RigType == Enum.HumanoidRigType.R6 and Reanimate == "Death" then
  pcall(function() Character.HumanoidRootPart.RootJoint:Destroy() end)
  	Character.HumanoidRootPart.Name = "Bullet"
  	local AP = Instance.new("AlignPosition", Character.Bullet)
  	local AO = Instance.new("AlignOrientation", Character.Bullet)
  	local A1 = Instance.new("Attachment", Character.Bullet)
  	local A2 = Instance.new("Attachment", Raw.HumanoidRootPart)
  	AP.RigidityEnabled = true
  	AO.RigidityEnabled = true
  	AP.Attachment0 = A1;AP.Attachment1 = A2
  	AO.Attachment0 = A1;AO.Attachment1 = A2
  end
  Humanoid.Died:Connect(function()
    Misc:Disconnect()
    Main:Disconnect()
    Raw:Destroy()
  end)
  if Reanimate == "Death" then
		local Bind = Instance.new("BindableEvent", Character)
		Bind.Event:Connect(function()
		game.Players.LocalPlayer.Character = Raw
		game.Players.LocalPlayer.Character:Destroy()
		game.Players.LocalPlayer.Character = workspace[game.Players.LocalPlayer.Name]
		Main:Disconnect()
		Misc:Disconnect()
		Bind:Destroy()
		wait()
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
	end)
      game:GetService("StarterGui"):SetCore("ResetButtonCallback", Bind)
   end
   if IsAnimating == true then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Zaphick3L/MiscStuff/main/Anims.lua'))()
   end
   if FlingForBullet == true and Reanimate == "Death" or Reanimate == "Bullet" then
    local bulchar = workspace[game.Players.LocalPlayer.Name]
    local bullet = bulchar:FindFirstChild("RightUpperArm") or bulchar:FindFirstChild("Bullet") or bulchar:FindFirstChild("Right Arm")
    bullet:ClearAllChildren()
    pcall(function()
      _G.IHaveYourIP = true
    end)
    local bp = Instance.new("BodyPosition", bullet)
    bp.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
    bp.P = 50000
    bp.D = 125
    
    local flingbuff = Instance.new("BodyAngularVelocity", bullet)
    flingbuff.MaxTorque = Vector3.new(9e99,9e99,9e99)
    flingbuff.P = 9e9
    flingbuff.AngularVelocity = Vector3.new(3500,3500,3500)
    local highlight = Instance.new("SelectionBox",bullet)
    highlight.Adornee = bullet
  
    local mouse = game.Players.LocalPlayer:GetMouse()
    local mousehold = false
    mouse.Button1Down:Connect(function()
      mousehold = true
    end)
        
    mouse.Button1Up:Connect(function()
        mousehold = false
    end)
    
    local bulletloop
    local function fling()
      pcall(function()
      local t = 5
      local hue = tick() % t / t -- took rainbow thing from project cat v1
      highlight.Color3 = Color3.fromHSV(hue, 1, 1)
      
      bullet.RotVelocity = Vector3.new(15000,15000,15000)
      if mousehold then
        if game.Players:GetPlayerFromCharacter(mouse.Target.Parent) then
          bp.Position = mouse.Target.Parent:FindFirstChild("HumanoidRootPart").Position + Vector3.new(math.random(-1,1), math.random(-1,1), math.random(-1,1)) or  mouse.Target.Parent:FindFirstChild("Head").Position + Vector3.new(math.random(-1,1), math.random(-1,1), math.random(-1,1))
        elseif game.Players:GetPlayerFromCharacter(mouse.Target.Parent.Parent) then
          bp.Position = mouse.Target.Parent.Parent:FindFirstChild("HumanoidRootPart").Position + Vector3.new(math.random(-1,1), math.random(-1,1), math.random(-1,1)) or mouse.Target.Parent.Parent:FindFirstChild("Head").Position + Vector3.new(math.random(-1,1), math.random(-1,1), math.random(-1,1))
        end
      else
        bp.Position = game.Players.LocalPlayer.Character.Raw.Torso.CFrame.p + Vector3.new(0,-5,0)
      end
      end)
    end
  
    bulletloop = game:GetService("RunService").Heartbeat:Connect(fling)
    bulchar.Humanoid.Died:Connect(function()
      bulletloop:Disconnect()
      _G.IHaveYourIP = false
    end)
   end
   if LoadLibNow == true then
   	loadstring(game:HttpGet("https://raw.githubusercontent.com/Zaphick3L/MiscStuff/main/Loadlibrary.lua"))()
	end
end
