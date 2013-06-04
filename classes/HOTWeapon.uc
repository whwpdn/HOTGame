class HOTWeapon extends UTWeapon;

var HOTPlayerController HPC;
var bool canSkillX;
var bool canSkillC;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    HPC=HOTPlayerController(Instigator.Controller);
}

function changemodX()
{
    canSkillX=true;
}

function changemodC()
{
    canSkillC=true;
}

exec function XKey()
{
    if(HPC.CurrentLevel >=2)
    {
        if(canSkillX==true)
        {
            `Log("XKey Function In" @HPC.CurrentLevel);
            SetCurrentFireMode(1);
            canSkillX=false;
            SetTimer(6,false,'changemodX');
        }
    }
}

exec function CKey()
{
    if(HPC.CurrentLevel>=4)
    {
        if(canskillC==true)
        {
            `Log("CKey Function In");
            SetCurrentFireMode(2);
            canSkillC=false;
            SetTimer(9,false,'changemodC');
        }
    }
}

simulated function StartFire(byte FireModeNum)
{
    ProjectileFire();
    SetCurrentFireMode(0);
}

simulated function Projectile ProjectileFire()
{
    local vector  RealStartLoc;
    local Projectile SpawnedProjectile;

    IncrementFlashCount();

    if(Role == ROLE_Authority)
    {
        RealStartLoc = GetPhysicalFireStartLoc();
        SpawnedProjectile = Spawn(GetProjectileClass(),,, RealStartLoc);
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
    canSkillX=true;
    canSkillC=true;
    AttachmentClass=class'HOTGame.HOTWeaponAttachment'

    WeaponFireTypes(0)=EWFT_Projectile
    WeaponProjectiles(0)=class'HOTLinkPlasma'
    WeaponProjectiles(1)=class'HOTPawnProjectile'
    WeaponProjectiles(2)=class'UTProj_ShockBall'

    Begin Object class=AnimNodeSequence Name=MeshSequenceA
    End Object

    Begin Object Name=FirstPersonMesh
        SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_1P'
        AnimSets(0)=AnimSet'WP_ShockRifle.Anim.K_WP_ShockRifle_1P_Base'
        Animations=MeshSequenceA
        Translation=(X=8.0,Y=-13.0,Z=8.0)
        Scale=0.5
    End Object
    Mesh=FirstPersonMesh

    FiringStatesArray(0)=WeaponFiring
    FiringStatesArray(1)=WeaponFiring
}