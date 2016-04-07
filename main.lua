
--[[ ---------------------------------------------------------------------------------------------------------
-- Included content is owned by INSERT NAME LLC and is used in the game SUPER GRAV BOT. 
Any use of this content for commercial use without permissionis prohibited. 
Thanks, 
Chris Zukowski
---------------------------------------------------------------------------------------------------------
I am not a professional programmer. I am an artist that likes programming on the side. So my code sucks.
LDF to LDP is used to convert simple level director files over to the newer version. 

Stuff it converts.

LDObjectLevel
Layers
LDObjectLevelPack
LDObjectRectangle 
LDObjectImage
LDObjectEllipse
LDObjectText
LDObjectButton
Any custom attributes any any of these objects.
Physics Settings

---------------
How to use
---------------

1. Simply setup you project the same way you set it up for coronasdk. Folder structure etc (this is important for the new LDP files to work)
For me, I had levels/projectfiles/ for my actual ldf files. and my exported levels were under the levels folder. 

2. Once you have the project setup, change the projectFileNames variable to have the names of your ldf files that you want to convert. 
3. Set your projectFilePath to the location of the ldf files.
4. Set your imagePath to be linked from wherever you are going to export your ldx files to. 
5. Just run using coronasdk. The output will print progress and will say finished when its done. The final files are made next to your ldf files. 

]] ---------------------------------------------------------------------------------------------------------

--[[ ---------------------------------------------------------------------------------------------------------
	Change History
	23/01/2016 - Alan (Retrofit) - Fixed MatchKeys to find key within level
	23/01/2016 - Alan (Retrofit) - Fixed Asset export for fixed size sprite sheets
	23/01/2016 - Alan (Retrofit) - Use Asset Group name when present
	24/01/2016 - Alan (Retrofit) - Fixed textureAtlas export to include first frame
	24/01/2016 - Alan (Retrofit) - Add support for physics and polygon bodies (single body)
	24/01/2016 - Alan (Retrofit) - Add support for Animation Sequences
	31/01/2016 - Alan (Retrofit) - Added physics to simple objects
	31/01/2016 - Alan (Retrofit) - Basic implementation of Button Object (LDX does not currently support images)
	03/04/2016 - Alan (Retrofit) - Fixed file path issue caused with newer builds of Corona
]] ---------------------------------------------------------------------------------------------------------

-- Change the projectFileNames variable to have the names of your ldf files that you want to convert. 
local projectFileNames = {"scroller"} --
-- Set your projectFilePath to the location of the ldf files.
local projectFilePath = 'levels/ProjectFiles/'
-- Set your imagePath to be linked from wherever you are going to export your ldx files to.
local imagePath = '../../images/levels/'

for i, projectFileName in ipairs(projectFileNames) do
    print (projectFileName)
    local inspect = require("inspect")
    local xmlParser = require("xmlSimple").newParser()
    local xml = xmlParser:loadFile(projectFilePath .. projectFileName..".ldf", base)
	local path = system.pathForFile( nil ) .. "/"

    local sharedParams = 
    {
        Alpha = 1,
        AnchorX = 0.5,
        AnchorY = 0.5,
        X = 0,
        Y = 0,
        Angle = 0,
        BlendMode = "Normal",
        CornerRadius = 0,
        DragEvent = false,
        FillColorARGB = -1,
        FollowPath = {},
        Gradient = "None",
        GradientColorARGB = 0,
        Height = 0,
        Id = "",
        Locked = false,
        Name = "",
        ObjectClass = "",
        ReferencePoint = "TopLeft",
        StrokeColorARGB = 0,
        StrokeWidth = 0,
        Texture = {},
        Visible = true,
        Width = 0,
        AssetKey = "",
        FlipX = false,
        FlipY = false,
        Physics = 
        {
            AngularDamping = 0,
            BodyShape = "Rectangle",
            BodyType = "Static",
            Bounce = 0,
            CategoryBits = "NotSet",
            Density = 1,
            FixedRotation = false,
            FixtureName = "Main Body",
            Friction = 0,
            GravityScale = 1,
            GroupIndex = 0,
            HandleCollision = false,
            IsBullet = false,
            IsEnabled = false,
            IsSensor = false,
            IsSleepingAllowed = true,
            LinearDamping = 0,
            LinkFixtures = true,
            MaskBits = 0,
            Radius = 0,
        },
		AnimSequence =
		{
			LDObjectSequence = {
				Name = '',
				StartFrame =1,
				Frames = '',
				FrameCount = 0,
				Time = 800,
				LoopParam = 0,
				Default = true,
				Play = false,
			},
		},
        UserProperties = {
            Name = "",
            Key = "",
            Value = "",
        },
        -- Text
        Text = "",
        FontName = "",
        FontSize = "",
        BackColorARGB = "",
        EmbossHightlightARGB = "",
        EmbossShadowARGB = "",
    }
    local filters = 
    {
        Assets = 
        {
            AnchorX = 0.5,
            AnchorY = 0.5,
            Audio = false,
            Export = true,
            File = "",
            FileName = "",
            Firstgid = "",
            Frame = 0,
            FrameCount = 0,
            Group = "",
            Height = 48,
            Key = "",
            ReferencePoint = "",
            TPFileName = "",
            TextureHeight = 0,
            TexturePacker = "",
            TexturePackerXML = "",
            TextureWidth = 0,
            Width = 0,
            X = 0,
            Y = 0,
			Physics = 
			{
				AngularDamping = 0,
				BodyShape = "Rectangle",
				BodyType = "Static",
				Bounce = 0,
				CategoryBits = "NotSet",
				Density = 1,
				FixedRotation = false,
				FixtureName = "Main Body",
				Friction = 0,
				GravityScale = 1,
				GroupIndex = 0,
				HandleCollision = false,
				IsBullet = false,
				IsEnabled = false,
				IsSensor = false,
				IsSleepingAllowed = true,
				LinearDamping = 0,
				LinkFixtures = true,
				MaskBits = 0,
				Radius = 0,
				Polygons = {
					LDObjectPoint = 
						{
							Name='',
							Point = 
							{
								X=0,
								Y=0,
							}
						},
				},
			},			
			AnimSequence =
			{
				LDObjectSequence = {
					Name = '',
					StartFrame =1,
					Frames = '',
					FrameCount = 0,
					Time = 800,
					LoopParam = 0,
					Default = true,
					Play = false,
				},
			},
        },
        LDObjectLevelPack = 
        {
            ["@xsd"] = "",
            ["@xsi"] = "",
            AnchorX = 0.5,
            AnchorY = 0.5,
            ClassList = {},
            CurrentLevel = 0,
            Graphics2 = true,
        },
        Level = 
        {
            Name = "",
            RelativePaths = true,
            ZoomIndex = 2,
        },
        LDObjectLevel = 
        {
            ["@Target"] = 0,
            ["@TargetHeight"] = 320,
            ["@TargetWidth"] = 480,
            BackColorARGB = 0,
            CanvasHeight = 640,
            CanvasWidth = 1136,
            DebugMode = Normal,
            Export = true,
            GravityX = 0,
            GravityY = 9.8,
            MarginX = 128,
            MarginY = 128,
            Name = "",
            ParallaxDamping = 1,
            ParallaxInfinite = false,
            PositionIterations = 8,
            VelocityIterations = 3,
            Wireframe = false,
        },
        Layers = 
        {
            ["@Count"] = 2,
            ["@Id"] = "",
            ["@Name"] = "",
            ["@Visible"] = true,
            GridX = 8,
            GridY = 8,
            ParallaxCulling = "None",
            ParallaxRepeat = false,
            ParallaxSpeedX = 0,
            ParallaxSpeedY = 0,
            ShowBodies = false,
            ShowGrid = true,
            SnapToGrid = true,
        },
        LDObjectRectangle = sharedParams,
        LDObjectImage = sharedParams,
        LDObjectEllipse = sharedParams,
        LDObjectText = sharedParams,
        LDObjectButton = sharedParams,
        LDObjectJoint = 
        {
            Name = "",
            Locked = false,
            Visible = true,
            AnchorX = 0.5,
            AnchorY = 0.5,
            X = 0,
            Y = 0,
            Width = 0,
            Height = 123,
            Angle = 0,
            Id = "",
        }    
    }

    local final = {}
    local finalIndex = 1
    local count = 0
    local increment = 100
    local currentLayer = ""
    local currentLevel = ""
	
    function storeAnimations(data, finIndex, pkey, mkey, akey)
		
       if data[mkey]["LDObjectSequence"] then
			-- print (data[mkey]["LDObjectSequence"]["Name"]["___value"])
            if not final[pkey][finIndex][mkey] then
                final[pkey][finIndex][mkey] = {}
            end
            if #data[mkey]["LDObjectSequence"] == 0 then
                for cusKey in pairs(filters[pkey][mkey]["LDObjectSequence"]) do
					-- print (cusKey)
                    for acusKey in pairs(data[mkey]["LDObjectSequence"]) do
                        if cusKey == acusKey then
                            if not final[pkey][finIndex][mkey]["LDObjectSequence"] then
                                final[pkey][finIndex][mkey]["LDObjectSequence"] = {}
                                final[pkey][finIndex][mkey]["LDObjectSequence"][1] = {}
                                -- final[pkey][finIndex][mkey][1][cusKey] = {}
                            end
                            final[pkey][finIndex][mkey]["LDObjectSequence"][1][cusKey] = data[mkey]["LDObjectSequence"][cusKey]["___value"]
                            -- print(cusKey, data[mkey]["LDObjectSequence"][cusKey]["___value"])
                        end
                    end
                end
            else
                for i = 1, #data[mkey]["LDObjectSequence"] do
                    for cusKey in pairs(filters[pkey][mkey]["LDObjectSequence"]) do
                        for acusKey in pairs(data[mkey]["LDObjectSequence"][i]) do
                            if cusKey == acusKey then
								--print (i,acusKey)
                                if not final[pkey][finIndex][mkey]["LDObjectSequence"] then
                                    final[pkey][finIndex][mkey]["LDObjectSequence"] = {}
                                end
                                if not final[pkey][finIndex][mkey]["LDObjectSequence"][i] then
                                    final[pkey][finIndex][mkey]["LDObjectSequence"][i] = {}
                                end
                                -- if not final[pkey][finIndex][mkey]["LDObjectSequence"][i][cusKey] then
                                    -- final[pkey][finIndex][mkey]["LDObjectSequence"][i][cusKey] = {}
                                -- end
                                -- print(mkey,cusKey, data[mkey]["LDObjectSequence"][i][cusKey]["___value"])
                                -- print(data[mkey]["LDObjectSequence"][i]["Name"]["___value"])
                                final[pkey][finIndex][mkey]["LDObjectSequence"][i][cusKey] = data[mkey]["LDObjectSequence"][i][cusKey]["___value"]
                            end
                        end
                    end
                end
            end
        end
	end

    function storePhysics(data, finIndex, pkey, mkey, akey)
        for physkey in pairs(filters[pkey][mkey]) do
            for aphyskey in pairs(data[akey]) do
                if physkey == aphyskey then
					-- print (physkey, mkey, akey)
                    if data[akey][aphyskey]["___value"] then
                        -- print (physkey, mkey, data[akey][aphyskey]["___value"])
                        if not final[pkey][finIndex][mkey] then
                            final[pkey][finIndex][mkey] = {}
                        end
                        final[pkey][finIndex][mkey][aphyskey] = data[akey][aphyskey]["___value"]
                    end
					
					if (physkey == 'Polygons') then
						if (data[mkey][physkey]["LDObjectPoint"]) then
							if not final[pkey][finIndex][mkey][physkey] then
								final[pkey][finIndex][mkey][physkey] = {}
							end
						
							for polyKey in pairs(filters[pkey][mkey][physkey]) do
								if not final[pkey][finalIndex][mkey][physkey][polyKey] then
									final[pkey][finalIndex][mkey][physkey][polyKey] = {} 
								end 
								-- print (polyKey)
								-- store LDObjectPoint Name 
								for pointKey in pairs(data[mkey][physkey][polyKey]) do	
									-- print (pointKey)
									final[pkey][finalIndex][mkey][physkey][polyKey][pointKey] = {} 
									final[pkey][finalIndex][mkey][physkey][polyKey][pointKey]["Name"] = data[mkey][physkey][polyKey][pointKey]["Name"]["___value"]
									--find points
									final[pkey][finalIndex][mkey][physkey][polyKey][pointKey]["Point"] = {} 
									i=1
									for pointKey2 in pairs(filters[pkey][mkey][physkey][polyKey]["Point"]) do
										-- print ("p",pointKey2,data[mkey][physkey][polyKey][pointKey]["Point"][pointKey2]["___value"])
										final[pkey][finalIndex][mkey][physkey][polyKey][pointKey]["Point"][pointKey2] = data[mkey][physkey][polyKey][pointKey]["Point"][pointKey2]["___value"]
										-- print ("p",pointKey2,data[mkey][physkey][polyKey][pointKey]["Point"][i]["X"]["___value"])
										i=i+1 
									end 
								end
							end 
						end 
					end
                end
            end
        end
    end

    function storeCustomProperties(data, finIndex, pkey, mkey, akey)
        -- Iterative process to find custom user properties. Since there can be multiples we have to store it
        -- in a table format that makes sense to easily pull out multiple values later on.
        if data[mkey]["LDObjectUserProperty"] then
            if not final[pkey][finIndex][mkey] then
                final[pkey][finIndex][mkey] = {}
            end
            if #data[mkey]["LDObjectUserProperty"] == 0 then
                for cusKey in pairs(filters[pkey][mkey]) do
                    for acusKey in pairs(data[mkey]["LDObjectUserProperty"]) do
                        if cusKey == acusKey then
                            if not final[pkey][finIndex][mkey][1] then
                                final[pkey][finIndex][mkey][1] = {}
                                final[pkey][finIndex][mkey][1][cusKey] = {}
                            end
                            final[pkey][finIndex][mkey][1][cusKey] = data[mkey]["LDObjectUserProperty"][cusKey]["___value"]
                            --print(cusKey, data[mkey]["LDObjectUserProperty"][cusKey]["___value"])
                        end
                    end
                end
            else
                for i = 1, #data[mkey]["LDObjectUserProperty"] do
                    for cusKey in pairs(filters[pkey][mkey]) do
                        for acusKey in pairs(data[mkey]["LDObjectUserProperty"][i]) do
                            if cusKey == acusKey then
                                if not final[pkey][finIndex][mkey][i] then
                                    final[pkey][finIndex][mkey][i] = {}
                                end
                                if not final[pkey][finIndex][mkey][i][cusKey] then
                                    final[pkey][finIndex][mkey][i][cusKey] = {}
                                end
                                --print(cusKey, data[mkey]["LDObjectUserProperty"][i][cusKey]["___value"])
                                final[pkey][finIndex][mkey][i][cusKey] = data[mkey]["LDObjectUserProperty"][i][cusKey]["___value"]
                            end
                        end
                    end
                end
            end
            --print(#data[mkey]["LDObjectUserProperty"])
        end
    end

    function storeValue(data,finIndex, pkey, mkey, akey, curLayer, curLevel)
        local dataValue = nil
        --Check if its a @Value or ____value -- Yup it matters.
        if data[akey]["___value"] then
            dataValue = data[akey]["___value"]
        else
            dataValue = data[akey]
        end

        --KILL TABLES
        if type(dataValue) == "table" then
            dataValue = ""
        end
        
        -- Write final values to string
        final[pkey][finalIndex][mkey] = dataValue
        if pkey == "LDObjectRectangle" or pkey == "LDObjectImage" or pkey == "LDObjectEllipse" or pkey == "LDObjectText" or pkey == "LDObjectButton" then
            final[pkey][finalIndex].LayerID = curLayer
        end
        if pkey ~= "LDObjectLevel" then
            final[pkey][finalIndex].LevelID = curLevel
        end
    end

    function lookup(data, pkey)
        -- variablelookup and storage
        if pkey and filters[pkey] then
            if pkey == "Layers" then
                if data["@Id"] then
                    currentLayer = data["@Id"]
                end
            elseif pkey == "LDObjectLevel" then 
                if data.Name then
                    if data.Name["___value"] then
                        currentLevel = data.Name["___value"]
                    end
                end
            end
			
            if final[pkey] then
                finalIndex = #final[pkey]+1
                final[pkey][finalIndex] = {}
            else
                finalIndex = 1
                final[pkey] = {}
                final[pkey][finalIndex] = {}
            end
            
            for mkey in pairs(filters[pkey]) do 
                for akey in pairs(data) do
                    if mkey == akey then
					--print (mkey,akey)
                        if akey == "Physics" then
                            storePhysics(data, finalIndex, pkey, mkey, akey)
                        elseif akey == "UserProperties" then
                            storeCustomProperties(data, finalIndex, pkey, mkey, akey)
                        elseif akey == "AnimSequence" then
                            storeAnimations(data, finalIndex, pkey, mkey, akey)
						else
                            storeValue(data, finalIndex, pkey, mkey, akey, currentLayer, currentLevel)
                        end
                    end
                end
            end
        end
        --recursive loop
        if pkey then
            --print("---------", count, pkey, "-------")
        end
        if type(data) == "table" then
            for key in pairs(data) do
                -- if its a number, then iterate through the list of multiple objects.
                if tonumber(key) ~= nil then
                    key = tonumber(key)
                    lookup(data[key], pkey)
                else
                    if pkey then
                        --pprint(key)
                    end
                    if type(data[key]) == "table" then
                        for fkey in pairs(filters) do
                            if key == fkey then
                                --count = count + 1
                                lookup(data[key], key)                        
                            end
                        end
                    end
                end
            end
        end
        if pkey then
            --print("--------- end", pkey, "-----")
        end
        count = count+1
        if count == increment then
            print("LDF XML Variables" , count)
            increment = increment + 100 
        end
    end
    lookup(xml, nil)

    --local testfile = io.open(projectFilePath .. projectFileName .. "XML.lua", "w")
    --testfile:write(assert(inspect(final)))
    --testfile:close()



    -- Ok start
    local finalString = '<?xml version="1.0" encoding="UTF-8"?>'
    local finalProjectString =  '<project exportTemplate="Corona_template.lua" exportFolder="levels">'

    local blendMode = {
    Normal = 0,
    Add = 1,
    Multiply = 2,
    Screen = 3
    }
    local bodyType = {
        Static = 0,
        Dynamic = 1, 
        Kinematic = 2, 
    }
    local bodyShape = {
        Rectangle = 0,
        Round = 1,
        Polygon = 2,
    }

    local gid = 1

    -- Function decToHex (renamed, updated): http://lua-users.org/lists/lua-l/2004-09/msg00054.html
    function decToHex(IN)
        local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
        while IN>0 do
            I=I+1
            IN,D=math.floor(IN/B),math.fmod(IN,B)+1
            OUT=string.sub(K,D,D)..OUT
        end
        return OUT
    end

    -- Function rgbToHex: http://gameon365.net/index.php
    function rgbToHex(c)
        local output = decToHex(c["r"]) .. decToHex(c["g"]) .. decToHex(c["b"]);
        return output
    end


    function convertBool(bool)
        if bool == "true" then
            bool = 1
        elseif bool == "false" then
            bool  = 0
        end
        return bool
    end

    function convertColor(int)
        if int then
            int = tonumber(int)
            if int > 0 then
                int = decToHex(int)
                int = tonumber(int,16)
            elseif int < 0 then
                int = decToHex(math.abs(int))
                int = '-'..tostring(int)
                int = tonumber(int,16)
            end
            return int
        else
            int = "-1"
            return int
        end
    end

    function matchKeys(AssetKey,LevelID)
        local isTexturePacker = false
        if final.Assets then
            for asset = 1, #final.Assets do
                local assets = final.Assets[asset]
                if assets.Key and AssetKey then
                    if (assets.Key == AssetKey) and (assets.LevelID == LevelID) then
                        if assets.TexturePacker ~= "" then
                            isTexturePacker = true
                        end
                        return {assets.Firstgid, isTexturePacker }
                    end
                end
            end
        end 
    end

    function convertPath(path)
        local prefix = imagePath
        local a, finalPath, c = string.match(path, "(.-)([^\\]-([^%.]+))$")
        return prefix .. finalPath
    end

    function convertRotation(obj)
        -- offset angle formula based off of 0,0 origin
        -- x = x_2 * cos(A) - y_2 * sin(A)
        -- y = x_2 *sin(A) + y_2 * cos(A)
        -- We have to get x_2, y_2 by getting the distance from pivot point to top left corner on unrotated object.
        if tonumber(obj.Angle) ~= 0 then
            local x2 = (obj.X - (obj.Width*obj.AnchorX)) - obj.X
            local y2 = (obj.Y - (obj.Height*obj.AnchorY)) - obj.Y
            local angle = math.rad(obj.Angle)
            local x = ((x2 * math.cos(angle)) - (y2 * math.sin(angle))) + obj.X
            local y = ((x2 * math.sin(angle)) + (y2 * math.cos(angle))) + obj.Y
            obj.X = x
            obj.Y = y
        else
            obj.X = obj.X - (obj.Width*obj.AnchorX)
            obj.Y = obj.Y - (obj.Height*obj.AnchorY)
        end
        return obj
    end

    function addCustomProperties(objects)
        if objects.UserProperties then
            for i = 1, #objects.UserProperties do
				if (objects.UserProperties[i].Name) then
					if i == 1 then
						finalString = finalString ..     '<properties>'
					end
					finalString = finalString ..     ' <property name="' .. objects.UserProperties[i].Name .. '" value="' .. objects.UserProperties[i].Value .. '"/>'
					if i == #objects.UserProperties then
						finalString = finalString ..     '</properties>\n'
					end
				end
            end
        end
    end
	
	function string:split(sep)
			local sep, fields = sep or ":", {}
			local pattern = string.format("([^%s]+)", sep)
			self:gsub(pattern, function(c) fields[#fields+1] = c end)
			return fields
	end	
	
    function addAnimations(assets)
		local str =''
		local sf = 0 
		local fc = 0 
        if assets.AnimSequence then
			if assets.AnimSequence.LDObjectSequence then
				for i = 1, #assets.AnimSequence.LDObjectSequence do
					-- print (i,assets.FileName,assets.AnimSequence.LDObjectSequence[i].Name)
					if (assets.AnimSequence.LDObjectSequence[i].Name) then
						if i == 1 then
							str = str .. '    <animations>\n'
						end
						str = str ..     '    <sequence name="' .. assets.AnimSequence.LDObjectSequence[i].Name .. '" loopCount="' .. assets.AnimSequence.LDObjectSequence[i].LoopParam ..'" loopDirection="0" duration="' .. assets.AnimSequence.LDObjectSequence[i].Time .. '" default="' ..convertBool(assets.AnimSequence.LDObjectSequence[i].Default) ..'" play="' .. convertBool(assets.AnimSequence.LDObjectSequence[i].Play) ..'">\n'
						--frames 
						str = str .. '    <frames>\n'
						
						sf = tonumber(assets.AnimSequence.LDObjectSequence[i].StartFrame)
						fc = tonumber(assets.AnimSequence.LDObjectSequence[i].FrameCount)
						-- print (sf,fc)
						
						if (assets.AnimSequence.LDObjectSequence[i].Frames) then
							-- print ("frames :", #assets.AnimSequence.LDObjectSequence[i].Frames)
							local t = assets.AnimSequence.LDObjectSequence[i].Frames:split(",")
							-- print (#t)
							for f = 1, #t do
								str = str .. '    <frame idx ="' .. tonumber(t[f])-1 .. '"/>\n'
							end 
						else 
							if (sf > 0 and fc > 0) then
								for f = sf, (sf+fc)-1 do
									str = str .. '    <frame idx ="' .. f-1 .. '"/>\n'
								end
							end 
						end
						str = str .. '    </frames>\n'
						str = str ..     '    </sequence>\n'
						
						if i == #assets.AnimSequence.LDObjectSequence then
							str = str .. '    </animations>\n'
						end
					end
				end
			end 
        end
		return str
    end

    function addLDObjectSimple(finalObjects, LayerID, LevelID, shape)
        if finalObjects then
            for object = 1, #finalObjects do
                local objects = finalObjects[object]
                if objects.Name then
					--print (objects.Name,objects.LayerID,objects.LevelID) 
                    if objects.LayerID == LayerID and objects.LevelID == LevelID then
                        if objects.FlipX == "true" then
                            objects.Angle = tonumber(objects.Angle) + 180
                        elseif objects.FlipY == "true" then
                            objects.Angle = tonumber(objects.Angle) + 180
                        end
                        objects = convertRotation(objects)
                        if shape == 0 then
                            objects.CornerRadius = 'cornerRadius="' .. objects.CornerRadius .. '"'
                        else
                            objects.CornerRadius = ""
                        end

                        if (shape == 5 and objects.Text) then
                            objects.FillColorARGB = objects.BackColorARGB or 0 
                            objects.StrokeColorARGB = objects.BackColorARGB or 0 
                            objects.textProperties = ' textColor="'.. objects.BackColorARGB .. '"  text="' .. objects.Text .. '" shadowcolor="' .. convertColor(objects.EmbossShadowARGB) .. '" highlightcolor="' .. convertColor(objects.EmbossHightlightARGB) .. '" '
                            objects.textFontProperties = '<font family="'.. objects.FontName ..'" size="'.. objects.FontSize ..'"/>'
                        else
                            objects.textProperties = ""
                            objects.textFontProperties = ""
                        end

                        local physics = objects.Physics
                        finalString = finalString ..     '<object uid="' .. objects.Id .. '" shape="'..shape..'" rotation="' .. objects.Angle .. '" name="' .. objects.Name .. '" type="' .. objects.ObjectClass .. '" alpha="' .. objects.Alpha .. '" blendMode="' .. blendMode[objects.BlendMode] .. '" x="' .. objects.X  .. '" y="' .. objects.Y  .. '" width="' .. objects.Width .. '" height="' .. objects.Height .. '" anchorX="' .. objects.AnchorX .. '" anchorY="' .. objects.AnchorY ..'" '.. objects.CornerRadius .. ' strokecolor="' .. convertColor(objects.StrokeColorARGB) .. '" fillcolor="' .. convertColor(objects.FillColorARGB) .. '"'.. objects.textProperties ..' >'
                        finalString = finalString .. objects.textFontProperties
                        addCustomProperties(objects)
						
						if (physics.IsEnabled == "true") then
							finalString = finalString ..  '  <physics enabled="' ..convertBool(physics.IsEnabled) .. '" bodytype="' ..bodyType[physics.BodyType] .. '" convex="0" linked="1">'
							finalString = finalString ..  '  <body bodyshape="' ..bodyShape[physics.BodyShape] .. '" friction="' ..physics.Friction .. '" bounce="' ..physics.Bounce .. '" density="' ..physics.Density .. '" radius="' ..physics.Radius .. '" bullet="' ..convertBool(physics.IsBullet) .. '" sensor="' ..convertBool(physics.IsSensor) .. '" sleepallowed="' ..convertBool(physics.IsSleepingAllowed) .. '" fixed="' ..convertBool(physics.FixedRotation) .. '" categorybit="' ..physics.CategoryBits .. '" maskbit="' ..physics.MaskBits .. '"/>'
							finalString = finalString ..  '  </physics>'
						end
						finalString = finalString ..     '</object>\n'
                    end
                end
            end
        end
    end


    function addLDObjectImage(LayerID, LevelID)
        if final.LDObjectImage then
            for object = 1, #final.LDObjectImage do
                local objects = final.LDObjectImage[object]
                if objects.Name then
                    if objects.LayerID == LayerID and objects.LevelID == LevelID then
                        local matchKey = matchKeys(objects.AssetKey,LevelID)
                        objects.Idx = matchKey[1]
                        if objects.Idx then
                            if objects.FlipX == "true" then
                                objects.Angle = tonumber(objects.Angle) + 180
                            elseif objects.FlipY == "true" then
                                objects.Angle = tonumber(objects.Angle) + 180
                            end
                            objects = convertRotation(objects)
                            finalString = finalString ..     '<object uid="' .. objects.Id .. '" shape="6" rotation="' .. objects.Angle .. '" name="' .. objects.Name .. '" type="' .. objects.ObjectClass .. '" alpha="' .. objects.Alpha .. '" blendMode="' .. blendMode[objects.BlendMode] ..  '" idx="' .. objects.Idx .. '" x="' .. objects.X .. '" y="' .. objects.Y .. '" width="' .. objects.Width .. '" height="' .. objects.Height .. '" anchorX="' .. objects.AnchorX .. '" anchorY="' .. objects.AnchorY .. '" >'
                            addCustomProperties(objects)
                            --finalString = finalString ..     '<physics enabled="0" bodytype="0" convex="0" linked="1">'
                            --finalString = finalString ..     '<body bodyshape="0" friction="0.3" bounce="0.2" density="1" radius="0" bullet="0" sensor="0" sleepallowed="0" fixed="0" categorybit="0" maskbit="0"/>'
                            --finalString = finalString ..     '</physics>'
                            finalString = finalString ..     '</object>\n'
                        end
                    end
                end
            end
        end
    end

    function addObjects(LayerID, LevelID)
        addLDObjectSimple(final.LDObjectRectangle, LayerID, LevelID, 0)
        addLDObjectSimple(final.LDObjectButton, LayerID, LevelID, 7)
        addLDObjectSimple(final.LDObjectEllipse, LayerID, LevelID, 3)
        addLDObjectSimple(final.LDObjectText, LayerID, LevelID, 5)
        addLDObjectImage(LayerID, LevelID)
        --addLDObjectTexturePacker(LayerID, LevelID)
    end

    function addLayers(LevelID)
        for layer = 1, #final.Layers do
            local layers = final.Layers[layer]
            if layers["@Name"] then
                if layers.LevelID == LevelID then
                    finalString = finalString .. '<layer parallaxX="' .. layers.ParallaxSpeedX .. '" parallaxY="'.. layers.ParallaxSpeedX ..'" name="'.. layers["@Name"] ..'" gridX="'..layers.GridX..'" gridY="'..layers.GridY..'">'
                    addObjects(layers["@Id"], LevelID)
                    finalString = finalString .. '</layer>\n'
                end
            end
        end
    end

    function addAssets(LevelID)
		local frame = 0 
		local lastFile = nil 
		local w=0
		local h=0 
		local lastIdx = 0 
		local group = nil 
        if final.Assets then
            for asset = 1, #final.Assets do
                local assets = final.Assets[asset]
                if assets.AnchorX and assets.TexturePacker == "" then
                    if assets.LevelID == LevelID then
						-- print (assets.File,assets.Frame, assets.FrameCount)
                        final.Assets[asset].Firstgid = gid
                        assets.Firstgid = gid
						
						frame = tonumber(assets.Frame)
						if (frame > 0) then
							frame = frame -1
						end
						
						if (frame == 0 ) then
							if (lastFile ~= nil) then 
								finalString = finalString ..  '</assets>\n'
							end 
							--find last frame to work out overal width and height to figure out original width and height of image source
							lastIdx = tonumber(asset+assets.FrameCount-1)
							-- print (lastIdx, asset)
							if (lastIdx > tonumber(asset)) then
								-- print (asset,final.Assets[lastIdx].X,final.Assets[tonumber(lastIdx)].Y)
								w = tonumber(final.Assets[lastIdx].X + assets.Width)
								h = tonumber(final.Assets[lastIdx].Y + assets.Height)
							else
								w = assets.Width
								h = assets.Height
							end
							group = assets.FileName
							if (assets.Group) then
								group = assets.FileName
							end
							finalString = finalString ..  '<assets firstgid="' .. assets.Firstgid .. '" name="' .. group .. '"  width="' .. assets.Width .. '" height="' .. assets.Height .. '">'
							finalString = finalString ..  ' <image source="' .. convertPath(assets.File) .. '" width="' .. w .. '" height="' .. h .. '"/>\n'
							lastFile = assets.File 
						end
						
                        finalString = finalString ..  ' <asset frame="' .. frame .. '" name="' .. assets.FileName .. '" export="1" x="' .. assets.X .. '" y="' .. assets.Y .. '" w="' .. assets.Width .. '" h="' .. assets.Height .. '">'
						
						local physics = assets.Physics
						                        -- local physics = objects.Physics
                        -- finalString = finalString ..     '<object uid="' .. objects.Id .. '" shape="'..shape..'" rotation="' .. objects.Angle .. '" name="' .. objects.Name .. '" type="' .. objects.ObjectClass .. '" alpha="' .. objects.Alpha .. '" blendMode="' .. blendMode[objects.BlendMode] .. '" x="' .. objects.X  .. '" y="' .. objects.Y  .. '" width="' .. objects.Width .. '" height="' .. objects.Height .. '" anchorX="' .. objects.AnchorX .. '" anchorY="' .. objects.AnchorY ..'" '.. objects.CornerRadius .. ' strokecolor="' .. convertColor(objects.StrokeColorARGB) .. '" fillcolor="' .. convertColor(objects.FillColorARGB) .. '"'.. objects.textProperties ..' >'
                        -- finalString = finalString .. objects.textFontProperties
                        -- addCustomProperties(objects)
						if (physics.IsEnabled == "true") then
							local physString = ''
							physString =  '  <physics enabled="' ..convertBool(physics.IsEnabled) .. '" bodytype="' ..bodyType[physics.BodyType] .. '" convex="0" linked="1">'
							physString = physString ..  '  <body bodyshape="' ..bodyShape[physics.BodyShape] .. '" friction="' ..physics.Friction .. '" bounce="' ..physics.Bounce .. '" density="' ..physics.Density .. '" radius="' ..physics.Radius .. '" bullet="' ..convertBool(physics.IsBullet) .. '" sensor="' ..convertBool(physics.IsSensor) .. '" sleepallowed="' ..convertBool(physics.IsSleepingAllowed) .. '" fixed="' ..convertBool(physics.FixedRotation) .. '" categorybit="' ..physics.CategoryBits .. '" maskbit="' ..physics.MaskBits .. '"/>'
							physString = physString ..  '  </physics>\n'
							finalString = finalString .. physString
							if (physics.Polygons) then
								local ptString =          '  <polygon points ="'
								local i = 0
								for point,val in pairs(physics.Polygons.LDObjectPoint) do
									if (i > 0) then
										ptString = ptString .. ' '
									end 
									ptString = ptString .. val.Point.X .. ',' .. val.Point.Y
									i=i+1
								end 
								ptString = ptString .. '"/>'
								if (i>1) then
									finalString = finalString ..  '  <layer parallaxX="0" parallaxY="0" parallaxRepeat="0" name="Fixtures" gridX="' .. assets.Width .. '" gridY="' .. assets.Height .. '">\n'
									finalString = finalString ..  '  <object shape="1" name="polyon_1" alpha="1" blendMode="0" x="0" y="0" anchorX="0.5" anchorY="0.5" strokecolor="4294967295" fillcolor="2868035455" textcolor="4294967295">\n'
									finalString = finalString ..  ptString .. '\n'
									finalString = finalString ..  physString
									finalString = finalString ..  '  </object>\n'
									finalString = finalString ..  '  </layer>\n'
								end 
								
								-- print (ptString)
							end
						end
                        --finalString = finalString ..  '  <physics enabled="' ..convertBool(physics.IsEnabled) .. '" bodytype="' ..bodyType[physics.BodyType] .. '>'
                        --finalString = finalString ..  '   <body bodyshape="' ..physics.BodyShape .. '" friction="' ..physics.Friction .. '" bounce="' ..physics.Bounce .. '" density="' ..physics.Density .. '" radius="' ..physicsRadius .. '" bullet="' ..convertBool(physics.IsBullet) .. '" sensor="' ..convertBool(physics.IsSensor) .. '" sleepallowed="' ..convertBool(physics.IsSleepingAllowed) .. '" fixed="0" categorybit="' ..physics.CategoryBits .. '" maskbit="' ..physics.MaskBits .. '"/>'
                        --finalString = finalString ..  '  </physics>'
						finalString = finalString .. addAnimations(assets)
                        finalString = finalString ..  ' </asset>\n'

						
                        gid = gid +1
                    end
                end
            end
			if (lastFile ~= nil) then
				finalString = finalString ..  '</assets>\n'
			end
        end
    end




    function orderAssetsTexturePacker(assets)
        for a = 0, #assets.frame do
            for a2 = 0, #assets.frame do
                if assets.frame[a2] == a then
                    -- print(assets.frame[a2])
                    --print(assets.asset[a2])
                    finalString = finalString .. assets.asset[a2]
                end
            end
        end
        if #assets.frame > 0 then
            finalString = finalString ..  '</assets>\n'
        end
    end


    function convertName(name)
        name = string.gsub(name, "%.", "_")
        return name
    end
    function addAssetsTexturePacker(LevelID)
        local usedFiles = {}
        local skipImage = false
        local backupFiles = {frame = {}, asset = {}}
        local gid2
        if final.Assets then
            for asset = 1, #final.Assets do
                local assets = final.Assets[asset]
                if assets.AnchorX and assets.TexturePacker ~= "" then
                    if assets.LevelID == LevelID then
                        assets.TexturePacker = convertPath(assets.TexturePacker)
                        assets.TexturePackerXML = convertPath(assets.TexturePackerXML)
                        for used = 1, #usedFiles do
                            if assets.TexturePacker == usedFiles[used] then
                                skipImage = true
                            end
                        end
                        final.Assets[asset].Firstgid = gid
                        assets.Firstgid = gid

                        if not skipImage then
                            --print("ADD ASSET")
                            gid2 = gid
                            orderAssetsTexturePacker(backupFiles)
                            backupFiles = {frame = {}, asset = {}}
                            --finalString = finalString ..  ' <image source="'.. "../" .. assets.File .. '" width="' .. assets.Width .. '" height="' .. assets.Height .. '"/>'
                            -- finalString = finalString ..  '<assets firstgid="' .. assets.Firstgid .. '" name="' .. convertName(assets.FileName) .. '"  width="' .. assets.Width .. '" height="' .. assets.Height .. '">'
                            finalString = finalString ..  '<assets firstgid="' .. assets.Firstgid .. '" name="' .. assets.Group .. '"  width="' .. assets.Width .. '" height="' .. assets.Height .. '">'
                            finalString = finalString ..  '<image source="' .. assets.TexturePacker .. '" width="' .. assets.Height .. '" height="' .. assets.Height .. '" spritesheet="' .. assets.TexturePackerXML .. '"/>\n'
                        else
                            final.Assets[asset].Firstgid = gid2 + tonumber(assets.Frame)-1
                        end
                        backupFiles.frame[#backupFiles.frame+1] = tonumber(assets.Frame)-1

						-- print (assets.FileName,tonumber(assets.Frame)-1,#backupFiles.asset+1)

                        backupFiles.asset[#backupFiles.asset+1] = ' <asset frame="' .. tonumber(assets.Frame)-1 .. '" name="' .. convertName(assets.FileName) .. '" export="1" x="' .. assets.X .. '" y="' .. assets.Y .. '" w="' .. assets.Width .. '" h="' .. assets.Height .. '">'
						
						--physics
						local physics = assets.Physics 
						if (physics.IsEnabled == "true") then
							local physString = ''
							physString =  '  <physics enabled="' ..convertBool(physics.IsEnabled) .. '" bodytype="' ..bodyType[physics.BodyType] .. '" convex="0" linked="1">'
							physString = physString ..  '  <body bodyshape="' ..bodyShape[physics.BodyShape] .. '" friction="' ..physics.Friction .. '" bounce="' ..physics.Bounce .. '" density="' ..physics.Density .. '" radius="' ..physics.Radius .. '" bullet="' ..convertBool(physics.IsBullet) .. '" sensor="' ..convertBool(physics.IsSensor) .. '" sleepallowed="' ..convertBool(physics.IsSleepingAllowed) .. '" fixed="' ..convertBool(physics.FixedRotation) .. '" categorybit="' ..physics.CategoryBits .. '" maskbit="' ..physics.MaskBits .. '"/>'
							physString = physString ..  '  </physics>\n'
							backupFiles.asset[#backupFiles.asset] = backupFiles.asset[#backupFiles.asset] .. physString
							if (physics.Polygons) then
								local ptString =          '  <polygon points ="'
								local i = 0
								for point,val in pairs(physics.Polygons.LDObjectPoint) do
									if (i > 0) then
										ptString = ptString .. ' '
									end 
									ptString = ptString .. val.Point.X .. ',' .. val.Point.Y
									i=i+1
								end 
								ptString = ptString .. '"/>'
								-- print (assets.Group,ptString)
								if (i>1) then
									backupFiles.asset[#backupFiles.asset] = backupFiles.asset[#backupFiles.asset] ..  '  <layer parallaxX="0" parallaxY="0" parallaxRepeat="0" name="Fixtures" gridX="' .. assets.Width .. '" gridY="' .. assets.Height .. '">\n'
									backupFiles.asset[#backupFiles.asset] = backupFiles.asset[#backupFiles.asset] ..  '  <object shape="1" name="polyon_1" alpha="1" blendMode="0" x="0" y="0" anchorX="0.5" anchorY="0.5" strokecolor="4294967295" fillcolor="2868035455" textcolor="4294967295">\n'
									backupFiles.asset[#backupFiles.asset] = backupFiles.asset[#backupFiles.asset] ..  ptString .. '\n'
									backupFiles.asset[#backupFiles.asset] = backupFiles.asset[#backupFiles.asset] ..  physString
									backupFiles.asset[#backupFiles.asset] = backupFiles.asset[#backupFiles.asset] ..  '  </object>\n'
									backupFiles.asset[#backupFiles.asset] = backupFiles.asset[#backupFiles.asset] ..  '  </layer>\n'
								end 
							end
						end
						
						backupFiles.asset[#backupFiles.asset] = backupFiles.asset[#backupFiles.asset] .. addAnimations(assets)
						
                        backupFiles.asset[#backupFiles.asset] = backupFiles.asset[#backupFiles.asset] ..  ' </asset>\n'
                        usedFiles[#usedFiles+1] = assets.TexturePacker
                        skipImage = false
                        gid = gid+1
                    end
                end
            end
        end
        orderAssetsTexturePacker(backupFiles)
    end


    function addLevels()

        for level = 1, #final.LDObjectLevel do --#final.LDObjectLevel do
            local levels = final.LDObjectLevel[level]
            if levels.Name then
                print("Processing Level ", levels.Name)
                gid = 1
                finalString = '<?xml version="1.0" encoding="UTF-8"?>'
                local fileName = levels.Name..".ldx"
                finalString = finalString .. '<level version="1.0" width="' .. levels.CanvasWidth .. '" height="' .. levels.CanvasHeight .. '" target="' .. levels["@Target"] .. '" backgroundcolor="' .. levels.BackColorARGB .. '" gravityX="' .. levels.GravityX .. '" gravityY="' .. levels.GravityY .. '" parallaxinfinite="' .. levels.ParallaxInfinite .. '" name="' .. levels.Name .. '">\n'
                finalProjectString = finalProjectString ..  '<level name="' .. levels.Name .. '" fileName="' .. fileName .. '" open="0" scale="1" scrollX="0" scrollY="0" layer="0"/>'
                addAssetsTexturePacker(levels.Name)
                addAssets(levels.Name)
                addLayers(levels.Name)
                finalString = finalString .. '</level>'
				-- local path = system.pathForFile( fileName, system.DocumentsDirectory)
				print (path .. projectFilePath .. fileName)
                local file = io.open(path .. projectFilePath .. fileName, "w")
                file:write(finalString)
                file:close()
                finalString = ""
            end
        end

        finalProjectString = finalProjectString .. '</project>'
        local file = io.open(path .. projectFilePath .. projectFileName..".ldp", "w")
        file:write(finalProjectString)
        file:close()
        print(projectFileName..".ldp", "Finished Successfully!")
    end
    addLevels()
end