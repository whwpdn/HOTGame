class HOTWeapon extends UTWeapon;

simulated function AttachTo(HOTPawn OwnerPawn)
{
    if(OwnerPawn.Mesh != None)
    {
        if(Mesh != None)
        {
            Mesh.SetShadowParent(OwnerPawn.Mesh);
            OwnerPawn.Mesh.AttachComponentToSocket(Mesh, 'WeaponPoint');
        }
    }
}

simulated function StartFire(byte FireModeNum)
{
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
        SpawnedProjectile = Spawn(WeaponProjectiles[0],,, RealStartLoc);
        if(SpawnedProjectile != None && !SpawnedProjectile.bDeleteMe)
        {
            SpawnedProjectile.Init(Vector(GetAdjustedAim(RealStartLoc)));
        }
        return SpawnedProjectile;
    }
    return None;
}
defaultproperties
{
    WeaponFireTypes(0)=EWFT_Projectile

    WeaponProjectiles(0)=class'HOTPawnProjectile'
    WeaponProjectiles(1)=class'HOTPawnProjectile'
    Begin Object class=AnimNodeSequence Name=MeshSequenceA
    End Object

    Begin Object Class=UDKSkeletalMeshComponent Name=FirstPersonMesh1
        SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_1P'
        AnimSets(0)=AnimSet'WP_ShockRifle.Anim.K_WP_ShockRifle_1P_Base'
        Animations=MeshSequenceA
        Translation=(X=8.0,Y=-13.0,Z=8.0)
        Scale=0.5
    End Object

    Mesh=FirstPersonMesh1
    FiringStatesArray(0)=WeaponFiring
    FiringStatesArray(1)=WeaponFiring
}