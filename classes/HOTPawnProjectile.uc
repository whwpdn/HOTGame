class HOTPawnProjectile extends UDKProjectile;

var ParticleSystem ProjFlightTemplate;
var ParticleSystem ProjExplosionTemplate;
var ParticleSystemComponent ProjEffects;

simulated function PostBeginPlay()
{
    SpawnFlightEffects();
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    if(Damage>0 && DamageRadius>0)
    {
        if(Role == ROLE_Authority)
            MakeNoise(1.0);
        if(!bShuttingDown)
        {
            ProjectileHurtRadius(HitLocation, HitNormal);
        }
    }
    SpawnExplosionEffects(HitLocation, HitNormal);
    Destroy();
}
simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
    if(Other != Instigator)
	{
        Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		Explode(HitLocation, HitNormal);
	}
}
simulated function SpawnFlightEffects()
{
    ProjEffects = WorldInfo.MyEmitterPool.SpawnEmitterCustomLifetime(ProjFlightTemplate);
    ProjEffects.SetAbsolute(false, false, false);
    ProjEffects.SetLODLevel(WorldInfo.bDropDetail ? 1 : 0);
    ProjEffects.bUpdateComponentInTick = true;
    AttachComponent(ProjEffects);
}

simulated function SpawnExplosionEffects(vector HitLocation, vector HitNormal)
{
    local vector x;
    x = normal(Velocity cross HitNormal);
    x = normal(HitNormal cross x);
    WorldInfo.MyEmitterPool.SpawnEmitter(ProjExplosionTemplate, HitLocation, rotator(x));
}

defaultproperties
{
    ProjFlightTemplate=ParticleSystem'VH_Scorpion.Effects.P_Scorpion_Bounce_Projectile_Red'
    ProjExplosionTemplate=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Far'
    Speed=1000
    MaxSpeed=15000
    AccelRate=16000.0
    Damage=10
    DamageRadius=60
}
