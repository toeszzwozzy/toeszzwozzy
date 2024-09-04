local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local active = false
local announcementSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZyonsSigma/ZyonsLifeSentence/main/AnnouncementSystem.lua"))()
local done = false

function server_hop()
	local SERVER_HOP_DELAY = 2 -- Delay in seconds between hops
	local API_REQUEST_DELAY = 3 -- Delay in seconds between API requests to prevent rate limiting

	local function getLowestPlayerServer()
		local HttpService = game:GetService("HttpService")
		local PlaceId = game.PlaceId
		local url = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100"

		local success, response = pcall(function()
			return HttpService:JSONDecode(game:HttpGet(url))
		end)

		if not success or not response.data then
			return nil
		end

		for _, server in ipairs(response.data) do
			if server.playing < server.maxPlayers then
				return server.id
			end
		end

		return nil
	end

	local function hopToServer(serverId)
		if serverId then
			local success = pcall(function()
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverId, game.Players.LocalPlayer)
			end)

			if not success then
				-- Handle teleport failure quietly
			end
		end
	end
	local function serverHopLoop()
		while true do
			local serverId = getLowestPlayerServer()
			if serverId then
				hopToServer(serverId)
				wait(SERVER_HOP_DELAY)
			else
				wait(API_REQUEST_DELAY)
			end
		end
	end
	serverHopLoop()

end

function firepp(pp)
	if fireproximityprompt then
		fireproximityprompt(pp,3)
	end
end
local function SynWait(t)
	local start = os.time()
	repeat wait()
	until (os.time() - start) >= t
end

function pressbutton(button)
	if firesignal then
		firesignal(button.MouseButton1Up)
		firesignal(button.MouseButton1Click)
		firesignal(button.MouseButton1Down)
	end
end
local function load()
	coroutine.resume(coroutine.create(function (...)
		if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Intro") then
			SynWait(2)
			pressbutton(game:GetService("Players").LocalPlayer.PlayerGui.Intro.SkipLoadingButton)
			SynWait(0.2)
			pressbutton(game:GetService("Players").LocalPlayer.PlayerGui.Intro.SkipButton)
			SynWait(0.2)
			pressbutton(game:GetService("Players").LocalPlayer.PlayerGui.Intro.PlayButton)
			SynWait(0.2)
			pressbutton(game:GetService("Players").LocalPlayer.PlayerGui.Intro.TeamsFrame.PrisonerFrame.JoinButton)
			SynWait(4)
			game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("IntroLoad"):FireServer(false)
			SynWait(4)
			local blur = game.Lighting:FindFirstChild("Blur")
			if blur then
				blur:Destroy()
			end
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("Part") then
					if v.Orientation == Vector3.new(0, 180, 0) then
						if v.Parent ~= localPlayer.Character then
							v:Destroy()
						end
					end
				end
			end
			SynWait(1) 
			workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			workspace.CurrentCamera.CameraSubject = localPlayer.Character.Humanoid
			SynWait(0.5)
			local intro = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Intro")
			if intro then
				intro:Destroy()
			end
		end
		game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(1005.72528, -0.62766099, 1489.3927, 0, 1, 0, 0, 0, -0.999999344, -1.00000262, 0, 0))
		SynWait(.5)
		game:GetService("Players").LocalPlayer.Character.PrimaryPart.Anchored = true
		SynWait(2)
		local ohString1 = "StartIllegalJob"
		local ohInstance2 = game:GetService("ReplicatedStorage")["GUI'sForPlayer"].HUD.CriminalComputerFrame.ScrollingFrame["Deliver Crate"]
		game:GetService("ReplicatedStorage").Events.WeaponEvent:FireServer(ohString1, ohInstance2)
		SynWait(5)
		local startTime = os.time()
		announcementSystem.startAnouncement("Fluxion", "Waiting: 0/150")
		repeat task.wait(1)
			announcementSystem.editAnouncement("Fluxion", "Waiting: "..tostring((os.time() - startTime)).."/150 Seconds")
			game:GetService("Players").LocalPlayer.Character.PrimaryPart.Anchored = false
			localPlayer.Character:SetPrimaryPartCFrame(CFrame.new(954.735962, -36.9245872, -176.933975, -1, 0, 0, 0, 1, 0, 0, 0, -1))
			if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Crate") then
				done = true
			end
		until (os.time() - startTime) >= 150
		announcementSystem.endAnouncement()
		workspace.CurrentCamera.Focus = CFrame.new(Vector3.new(workspace.ImportantInteractive.CrateJobDropPile.MainPart.Attachment.Position))
		firepp(workspace.ImportantInteractive.CrateJobDropPile.MainPart.Attachment.ProximityPrompt)
		SynWait(.1)
		done = true
	end))
end

load()

game:GetService("RunService").RenderStepped:Connect(function()
	if workspace:WaitForChild("RentablePropertys"):WaitForChild("Property6"):FindFirstChild("HouseType3") then
		if workspace:WaitForChild("RentablePropertys"):WaitForChild("Property6"):WaitForChild("HouseType3"):FindFirstChild("Trim") then
			workspace:WaitForChild("RentablePropertys"):WaitForChild("Property6"):WaitForChild("HouseType3"):WaitForChild("Trim"):Destroy()
		end
	end

	if game.Players.LocalPlayer then
		if game.Players.LocalPlayer.Character then
			if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Crate") then
				game:GetService("Players").LocalPlayer.Character:WaitForChild("Crate").Parent = game:GetService("Players").LocalPlayer.Backpack
			end
		end
	end

	if done == true then
		done = false
		server_hop()
	end
end)
