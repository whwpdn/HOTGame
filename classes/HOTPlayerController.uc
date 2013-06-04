class HOTPlayerController extends UTPlayerController;

var vector PlayerViewOffset;
var int CurrentLevel;
var int EXP;
//var vector CurrentCameraLocation, DesiredCameraLocation;
//var rotator CurrentCameraRotation;

function getExperience(int EXPAmount)
{
    EXP += EXPAmount;
    if(EXP%10 == 0)
    {
        CurrentLevel++;
    }
}

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

// 3��Ī ī�޶� ����
state PlayerWalking
{
ignores SeePlayer, HearNoise, Bump;

   function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
   {
      if( Pawn == None )
      {
         return;
      }

      if (Role == ROLE_Authority)
      {
         // ���� Ŭ���̾�Ʈ�� ViewPitch ������Ʈ
         Pawn.SetRemoteViewPitch( Rotation.Pitch );
      }

      Pawn.Acceleration = NewAccel;

      CheckJumpOrDuck();
   }
}

function UpdateRotation( float DeltaTime )
{
   local Rotator   DeltaRot, newRotation, ViewRotation;

   ViewRotation = Rotation;
   if (Pawn!=none)
   {
      Pawn.SetDesiredRotation(ViewRotation);
   }

   // ViewRotation�� ����ǵ��� Delta�� ���
   DeltaRot.Yaw   = PlayerInput.aTurn;
   DeltaRot.Pitch   = PlayerInput.aLookUp;

   ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
   SetRotation(ViewRotation);

   NewRotation = ViewRotation;
   NewRotation.Roll = Rotation.Roll;

   if ( Pawn != None )
      Pawn.FaceRotation(NewRotation, deltatime);
}
// 3��Ī ī�޶� ���� ����

defaultproperties
{
    CurrentLevel=1
    EXP=0
}
