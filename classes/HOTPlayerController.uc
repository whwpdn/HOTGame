class HOTPlayerController extends UTPlayerController;

var vector PlayerViewOffset;
//var vector CurrentCameraLocation, DesiredCameraLocation;
//var rotator CurrentCameraRotation;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
}

exec function StartFire( optional byte FireModeNum )
{
    super.StartFire(FireModeNum);

}
reliable client function ClientSetHUD(class<HUD> newHUDType)
{
    if(myHUD != none)
        myHUD.Destroy();

    myHUD = spawn(class'HOTHUD', self);
    //PlayerViewOffset=(X=150,Y=0,Z=1000)
}

defaultproperties
{

}
