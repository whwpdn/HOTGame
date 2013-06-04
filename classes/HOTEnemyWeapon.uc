class HOTEnemyWeapon extends UDKWeapon;

simulated function AttachTo(UTPawn OwnerPawn)
{
	if (OwnerPawn.Mesh != None)
	{
		// Attach Weapon mesh to player skelmesh
		if ( Mesh != None )
		{
			// Weapon Mesh Shadow
			Mesh.SetShadowParent(OwnerPawn.Mesh);
			Mesh.SetLightEnvironment(OwnerPawn.LightEnvironment);

			OwnerPawn.Mesh.AttachComponentToSocket(Mesh, 'WeaponPoint');
		}
	}
}
function AttackTemple(byte FireModeNum){
    `log("asdf");
    ProjectileFire();
}

simulated function Projectile ProjectileFire()
{
    local vector  RealStartLoc;
    local Projectile SpawnedProjectile;
    
    IncrementFlashCount();

    if(Role == ROLE_Authority)
    {
        RealStartLoc = GetPhysicalFireStartLoc();
        SpawnedProjectile = Spawn(WeaponProjectiles[1],,, RealStartLoc);
        if(SpawnedProjectile != None && !SpawnedProjectile.bDeleteMe)
        {
            SpawnedProjectile.Init(Vector(GetAdjustedAim(RealStartLoc)));
        }
        return SpawnedProjectile;
    }
    return None;
}
DefaultProperties
{
    WeaponProjectiles(0)=class'HOTEnemyProjectile'
    WeaponProjectiles(1)=class'HOTEnemyProjectile'
    FiringStatesArray(0)=WeaponFiring
    FiringStatesArray(1)=WeaponFiring
}
