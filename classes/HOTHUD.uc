class HOTHUD extends UTGFxHUDWrapper;

event DrawHUD()
{
    super.DrawHUD();

    Canvas.DrawColor = WhiteColor;
    Canvas.Font = class'Engine'.Static.GetLargeFont();

    if(HOTGame(WorldInfo.Game) != none)
    {
        Canvas.SetPos(Canvas.ClipX * 0.1, Canvas.ClipY * 0.95);
        Canvas.DrawText("Enemies Left:" @ HOTGame(WorldInfo.Game).EnemiesLeft);
    }
}

defaultproperties
{
}
