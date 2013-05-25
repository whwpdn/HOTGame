class HOTEnemyRocket extends UTProj_Rocket;

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
    if(Other != Instigator)
	{
        Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		Explode(HitLocation, HitNormal);
	}
}

defaultproperties
{
    Damage = 5;
    DamageRadius =0;

}