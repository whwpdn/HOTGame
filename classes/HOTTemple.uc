class HOTTemple Extends HOTActor
        placeable;

var int Health;
var HOTEnemyAIcontroller EnemyAI;
var HOTTemple AT;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

}
event TakeDamage(int DamageAmount,Controller EventInstigator,vector HitLocation,vector Momentum, class<DamageType> DamageType,Optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
     Health -= DamageAmount;

     if(Health <=0)
     {
         Destroy();
        `log("Destroy");
     }
     `log("temple take damage" @DamageAmount);
}

defaultproperties
{
    Health=100
    bBlockActors=True
    bCollideActors=True

    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled=True
    End Object
    Components.Add(MyLightEnvironment)

    Begin Object Class=StaticMeshComponent Name=TempleMesh
        StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_Y'
        LightEnvironment=MyLightEnvironment
        Scale3D=(X=0.25,Y=0.25,Z=0.5)
    End Object
    Components.Add(TempleMesh)

    Begin Object Class=CylinderComponent Name=CollisionCylinder
    CollisionRadius=32.0
    CollisionHeight=64.0
    BlockNonZeroExtent=true
    BlockZeroExtent=true
    BlockActors=true
    End Object
    CollisionComponent=CollisionCylinder
    Components.Add(MyLightEnvironment)
}