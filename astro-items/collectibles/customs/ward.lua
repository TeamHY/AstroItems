local isc = require("astro-items.lib.isaacscript-common")

AstroItems.Collectible.WARD = Isaac.GetItemIdByName("Ward")
AstroItems.Collectible.PINK_WARD = Isaac.GetItemIdByName("Pink Ward")

if EID then
    AstroItems:AddEIDCollectible(AstroItems.Collectible.WARD, "와드", "...", "스테이지 중심 5x5의 방을 보여줍니다.")
    AstroItems:AddEIDCollectible(AstroItems.Collectible.PINK_WARD, "핑크 와드", "...", "스테이지 중심 5x5의 방을 보여줍니다.#숨어 있는 적을 아군으로 만듭니다.")
end

---@param range number
local function DisplayWardRoom(range)
    local level = Game():GetLevel()

    for i = -range, range do
        for j = -range, range do
            local index = AstroItems:ConvertRoomPositionToIndex(Vector(i + 6, j + 6))

            if index ~= -1 then
                local room = level:GetRoomByIdx(index)

                if room.Flags & RoomDescriptor.FLAG_RED_ROOM ~= RoomDescriptor.FLAG_RED_ROOM and room.DisplayFlags & RoomDescriptor.DISPLAY_BOX ~= RoomDescriptor.DISPLAY_BOX then
                    room.DisplayFlags = room.DisplayFlags | RoomDescriptor.DISPLAY_BOX | RoomDescriptor.DISPLAY_ICON
                end
            end
        end
    end

    level:UpdateVisibility()
end

AstroItems:AddCallback(
    ModCallbacks.MC_POST_NEW_LEVEL,
    function(_)
        for i = 1, Game():GetNumPlayers() do
            local player = Isaac.GetPlayer(i - 1)

            if player:HasCollectible(AstroItems.Collectible.WARD) or player:HasCollectible(AstroItems.Collectible.PINK_WARD) then
                DisplayWardRoom(math.max(player:GetCollectibleNum(AstroItems.Collectible.WARD), player:GetCollectibleNum(AstroItems.Collectible.PINK_WARD)) * 2)
                break
            end
        end
    end
)

AstroItems:AddCallbackCustom(
    isc.ModCallbackCustom.POST_PLAYER_COLLECTIBLE_ADDED,
    ---@param player EntityPlayer
    ---@param collectibleType CollectibleType
    function(_, player, collectibleType)
        if collectibleType == AstroItems.Collectible.WARD or collectibleType == AstroItems.Collectible.PINK_WARD then
            DisplayWardRoom(math.max(player:GetCollectibleNum(AstroItems.Collectible.WARD), player:GetCollectibleNum(AstroItems.Collectible.PINK_WARD)) * 2)
        end
    end
)

AstroItems:AddCallback(
    ModCallbacks.MC_POST_NPC_INIT,
    ---@param entityNPC EntityNPC
    function(_, entityNPC)
        for i = 1, Game():GetNumPlayers() do
            local player = Isaac.GetPlayer(i - 1)
        
            if player:HasCollectible(AstroItems.Collectible.PINK_WARD) then
                if entityNPC.Type == EntityType.ENTITY_NEEDLE or entityNPC.Type == EntityType.ENTITY_WIZOOB or entityNPC.Type == EntityType.ENTITY_RED_GHOST or entityNPC.Type == EntityType.ENTITY_POLTY then
                    entityNPC:AddEntityFlags(EntityFlag.FLAG_CHARM)
                    entityNPC:AddEntityFlags(EntityFlag.FLAG_FRIENDLY)
                end
            end

            break
        end
    end
)

