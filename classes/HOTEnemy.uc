class HOTEnemy extends UTPawn;

var float BumpDamage;
var Actor Enemy;
var float MovementSpeed;
var float AttackDistance;
var HOTEnemyAIcontroller EAIController;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    SpawnDefaultcontroller();

}
event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    Health -= DamageAmount;
    if(Health<=0){
        Destroy();
        if(EventInstigator != none && EventInstigator.PlayerReplicationInfo != none)
            WorldInfo.Game.ScoreObjective(EventInstigator.PlayerReplicationInfo, 1);
    }
}

defaultproperties
{
    Health=5
    Begin Object Name=CollisionCylinder
    CollisionHeight=+44.000000
    end object
    Begin Object class=SkeletalMeshComponent Name=PawnSkeletalMesh
        SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
        AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
        AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
    HiddenGame=FALSE
    HiddenEditor=FALSE
    End Object
    Mesh=PawnSkeletalMesh
    Components.Add(PawnSkeletalMesh)

    ControllerClass=class'HOTGame.HOTEnemyAIcontroller'
    bJumpCapable=false
    bCanJump=false
    GroundSpeed=200.0
}
