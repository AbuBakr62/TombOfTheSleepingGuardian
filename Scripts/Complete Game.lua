local root = script.parent.parent
local RespButton = root:FindChildByName("RespawnUI")
local Respawn = RespButton:FindDescendantByName("RespawnMe")
local Effect = script.parent
local player = Game.GetLocalPlayer()
local RespCube = script:GetCustomProperty("RespawnPoint"):WaitForObject()
local Sword = script:GetCustomProperty("Advanced2HandedSword"):WaitForObject()
RespButton.visibility = Visibility.FORCE_OFF
Effect.visibility = Visibility.FORCE_OFF

function Tick()
    if Sword.owner == player then
        Effect.visibility = Visibility.FORCE_ON
        UI.SetCursorVisible(true)
        UI.SetCanCursorInteractWithUI(true)
        Events.Broadcast("PostOFF")
        Task.Wait(1)
            RespButton.visibility = Visibility.FORCE_ON
        end
end

function RespawnClicked()
    local RespPos = RespCube:GetWorldPosition()
    local RespRot = RespCube:GetWorldRotation()
    Events.BroadcastToServer("RespawnPlayer", RespPos, RespRot)
    Effect.visibility = Visibility.FORCE_OFF
    RespButton.visibility = Visibility.FORCE_OFF
    UI.SetCursorVisible(false)
    UI.SetCanCursorInteractWithUI(false)
    Events.Broadcast("PostOFF")
end
function RespawnPress()
    UI.SetCursorVisible(false)
    UI.SetCanCursorInteractWithUI(false)
end

Respawn.releasedEvent:Connect(RespawnClicked)
Respawn.pressedEvent:Connect(RespawnPress)