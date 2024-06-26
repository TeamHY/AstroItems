AstroItems.Collectible.LANIAKEA_SUPERCLUSTER = Isaac.GetItemIdByName("Laniakea Supercluster")

if EID then
    AstroItems:AddEIDCollectible(AstroItems.Collectible.LANIAKEA_SUPERCLUSTER, "라니아케아 초은하단", "...", "사용 시 모든 {{Planetarium}}행성방 아이템이 존재하는 방으로 이동합니다.#!!! 일회용 아이템")
end

AstroItems:AddCallback(
    ModCallbacks.MC_USE_ITEM,
    ---@param collectibleID CollectibleType
    ---@param rngObj RNG
    ---@param playerWhoUsedItem EntityPlayer
    ---@param useFlags UseFlag
    ---@param activeSlot ActiveSlot
    ---@param varData integer
    function(_, collectibleID, rngObj, playerWhoUsedItem, useFlags, activeSlot, varData)
        Isaac.ExecuteCommand("goto s.planetarium.0")

        return {
            Discharge = true,
            Remove = true,
            ShowAnim = true,
        }
    end,
    AstroItems.Collectible.LANIAKEA_SUPERCLUSTER
)
