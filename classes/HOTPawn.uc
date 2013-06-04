class HOTPawn extends UTPawn;

//var bool bInvulnerable;
//var float InvulnerableTime;

//var HOTWeapon WeaponGun;

// 3��Ī ���� ī�޶� ����
//�÷��̾� �޽ø� �⺻���� ���̰Բ� �������̵�

simulated event BecomeViewTarget( PlayerController PC )
{
   local UTPlayerController UTPC;

   Super.BecomeViewTarget(PC);

   if (LocalPlayer(PC.Player) != None)
   {
      UTPC = UTPlayerController(PC);
      if (UTPC != None)
      {
         //�÷��̾� ��Ʈ�ѷ��� ��� �信 ���� �� �޽� ���̰�
         UTPC.SetBehindView(true);
         SetMeshVisibility(UTPC.bBehindView);
      }
   }
}

simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
   local vector CamStart, HitLocation, HitNormal, CamDirX, CamDirY, CamDirZ, CurrentCamOffset;
   local float DesiredCameraZOffset;

   CamStart = Location;
   CurrentCamOffset = CamOffset;

   DesiredCameraZOffset = 1.2 * GetCollisionHeight() + Mesh.Translation.Z;
   CameraZOffset = (fDeltaTime < 0.2) ? DesiredCameraZOffset * 5 * fDeltaTime + (1 - 5*fDeltaTime) * CameraZOffset : DesiredCameraZOffset;
   
   if ( Health <= 0 )
   {
      CurrentCamOffset = vect(0,0,0);
      CurrentCamOffset.X = GetCollisionRadius();
   }

   CamStart.Z += CameraZOffset;
   GetAxes(out_CamRot, CamDirX, CamDirY, CamDirZ);
   CamDirX *= CurrentCameraScale;

   if ( (Health <= 0) || bFeigningDeath )
   {
      // ���忡 ������ �ʰ� ī�޶� ��ġ ����
      // @todo fixmesteve.  FindSpot�� �����ϸ� (���� �ȱ׷�����) ��� ������ �� �� �ֽ��ϴ�.
      FindSpot(GetCollisionExtent(),CamStart);
   }
   if (CurrentCameraScale < CameraScale)
   {
      CurrentCameraScale = FMin(CameraScale, CurrentCameraScale + 5 * FMax(CameraScale - CurrentCameraScale, 0.3)*fDeltaTime);
   }
   else if (CurrentCameraScale > CameraScale)
   {
      CurrentCameraScale = FMax(CameraScale, CurrentCameraScale - 5 * FMax(CameraScale - CurrentCameraScale, 0.3)*fDeltaTime);
   }

   if (CamDirX.Z > GetCollisionHeight())
   {
      CamDirX *= square(cos(out_CamRot.Pitch * 0.0000958738)); // 0.0000958738 = 2*PI/65536
   }

   out_CamLoc = CamStart - CamDirX*CurrentCamOffset.X + CurrentCamOffset.Y*CamDirY + CurrentCamOffset.Z*CamDirZ;

   if (Trace(HitLocation, HitNormal, out_CamLoc, CamStart, false, vect(12,12,12)) != None)
   {
      out_CamLoc = HitLocation;
   }

   return true;
}
// 3��Ī ���� ī�޶� ����

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    DamageAmount =0;
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    //WeaponGun = Spawn(class'HOTWeapon');
    //WeaponGun.AttachTo(self);
    //WeaponGun.SetHidden(false);
    //Weapon = WeaponGun;
}
function AddDefaultInventory()
{
//    CreateInventory(class'HOTGame.HOTWeapon');
}
exec function ZKey()
{
    //InvManager.NextWeapon();
}

defaultproperties
{

}
