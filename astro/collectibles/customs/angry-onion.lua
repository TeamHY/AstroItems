Astro.Collectible.ANGRY_ONION = Isaac.GetItemIdByName("Angry Onion")

if EID then
    EID:addCollectible(Astro.Collectible.ANGRY_ONION, "↑ {{TearsSmall}}연사(+고정) +0.7", "화난 양파")
end

Astro:AddCallback(
    ModCallbacks.MC_EVALUATE_CACHE,
    ---@param player EntityPlayer
    ---@param cacheFlag CacheFlag
    function(_, player, cacheFlag)
        if player:HasCollectible(Astro.Collectible.ANGRY_ONION) then
            if cacheFlag == CacheFlag.CACHE_FIREDELAY then
                player.MaxFireDelay = Astro:AddTears(player.MaxFireDelay, 0.7)
            end
        end
    end
)