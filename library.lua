local Library = {}

local math_round = math.round
local table_insert = table.insert
local table_remove = table.remove
local Region3_new = Region3.new
local math_random = math.random
local math_huge = math.huge

local task = task;
local wait = task.wait;
local spawn = task.spawn;

local print = print;
local warn = warn;
local error = error;

local table = table
local table_sort = table.sort
local table_insert = table.insert

local pairs = pairs;
local ipairs = ipairs
local assert = assert

local game = game;
local workspace = workspace;

local GetService = game.GetService;

local Players = GetService(game,"Players");
local RunService = GetService(game,"RunService");
local UserInputService = GetService(game, "UserInputService");
local ReplicatedStorage = GetService(game, "ReplicatedStorage");

local LocalPlayer = Players.LocalPlayer;

local Character, Head, HumanoidRootPart, Humanoid, Camera;
local Backpack = LocalPlayer.Backpack;

local GetPlayers = Players.GetPlayers

local function ReLocalize()
	Camera = workspace.CurrentCamera
	Character = LocalPlayer.Character 
    
    Head = Character:WaitForChild("Head");
    HumanoidRootPart = Character:WaitForChild('HumanoidRootPart') or Character.PrimaryPart;
    Humanoid = Character:WaitForChild("Humanoid"); 
end

ReLocalize()


local function GetMagnitude(Part1, Part2)
    
    local Mag = (Part2.Position - Part1.Position).magnitude;
    
    print(Mag)
    return Mag;
end;

function Library.GetPlayerPriorityTable()
    local PlayersTable = GetPlayers(Players);
    
    local NewTable = {};
    
    for Index, Variable in ipairs(PlayersTable) do
        if Variable ~= LocalPlayer and Variable.Character then
            
            local _Humanoid = Variable.Character:FindFirstChild("Humanoid")
            local _HumanoidRootPart = Variable.Character:FindFirstChild("HumanoidRootPart");
            
            if _Humanoid and _HumanoidRootPart then
                    if _Humanoid.Health > 0 then
            
                        local CurrentIndex = #NewTable + 1

        
                        if _HumanoidRootPart then
                            table_insert(NewTable, CurrentIndex, {
                                Variable.Name; 
                                GetMagnitude(HumanoidRootPart, _HumanoidRootPart);
                                Variable;
                            })
                        end
            
                        continue
                end
            
            end
        end
    
    end;
    
    table_sort(NewTable, function(Variable1,Variable2)
        return Variable1[2] < Variable2[2]
    end)
    
    return NewTable
end;

function Library:GetAllPlayersInRadius(Radius)
    local PlayersTable = GetPlayers(Players);
    
    local NewTable = {};
    
    for Index, Variable in ipairs(PlayersTable) do
        if Variable ~= LocalPlayer and Variable.Character then
            
            local _Humanoid = Variable.Character:FindFirstChild("Humanoid")
            local _HumanoidRootPart = Variable.Character:FindFirstChild("HumanoidRootPart");
            
            if _Humanoid and _HumanoidRootPart then
                if _Humanoid.Health ~= 0 then
                            local CurrentIndex = #NewTable + 1
                    
                                if _HumanoidRootPart then
                                    if GetMagnitude(HumanoidRootPart, _HumanoidRootPart) <= Radius then
                                        table_insert(NewTable, Variable)
                                    end
                                end
                            end
                    end
                end
        
    end;
    
    return NewTable
end;

LocalPlayer.CharacterAdded:Connect(ReLocalize)

return Library



    
