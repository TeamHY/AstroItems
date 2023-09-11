Astro.Collectible.PAVO = Isaac.GetItemIdByName("Pavo")

if EID then
    EID:addCollectible(Astro.Collectible.PAVO, "Mega Satan 1 페이즈을 제외한 모든 몬스터들의 체력이 25% 감소됩니다.#Mega Satan 1 페이즈의 체력이 20% 감소됩니다.", "공작자리")
end

Astro:AddCallback(
    ModCallbacks.MC_POST_NPC_INIT,
    ---@param entity Entity
    function(_, entity)
        local isRun = false

        for i = 1, Game():GetNumPlayers() do
            local player = Isaac.GetPlayer(i - 1)

            if player:HasCollectible(Astro.Collectible.PAVO) and not isRun then
                if entity:IsVulnerableEnemy() and entity.Type ~= EntityType.ENTITY_FIREPLACE then
                    if entity.Type == EntityType.ENTITY_MEGA_SATAN then
                        entity.HitPoints = entity.HitPoints - entity.MaxHitPoints * 0.2
                    else
                        entity.HitPoints = entity.HitPoints - entity.MaxHitPoints * 0.25
                    end
                end

                isRun = true
            end
        end
    end
)
