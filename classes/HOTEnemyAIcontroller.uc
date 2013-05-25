class HOTEnemyAIcontroller extends AIController;

var() Vector TempDest;
var Actor Target;
var float AttackDistance;
var float MovementSpeed;
var vector NewLocation;
var HOTEnemyRocket RocketAttack;
var HOTEnemyWeapon EnemyWeaponGun;
var HOTTemple AT;
//That's in our AI Controller

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
    GetEnemy();
}

//That's in our AI Controller
function GetEnemy()
{
    foreach DynamicActors(class'HOTTemple',AT){
        if(AT != none){
                        `log("Pawn"@Pawn);
                                                `log("AT"@AT);
                   Target = AT;
        }
   }
}
function Attack()
{
    if(Target ==none){
        ClearTimer('Attack');
        GoToState('Idle');
    }
    else{
        RocketAttack = Spawn(class'HOTEnemyRocket',self,,Pawn.Location);
        RocketAttack.Init(normal(Target.Location-Pawn.Location));
    }
}
state Idle
{
    function BeginState(Name PreviousStateName)
    {
        `log("Idle"@Pawn);
    }
}

auto state Seeking
{
    function Tick(float DeltaTime)
    {

    }
    function bool FindNavMeshPath()
    {
        NavigationHandle.PathConstraintList = none;
        NavigationHandle.PathGoalList = none;

        class'NavMeshPath_Toward'.static.TowardGoal(NavigationHandle,Target);
        class'NavMeshGoal_At'.static.AtActor(NavigationHandle,Target,32,true);

        return NavigationHandle.FindPath();
    }

Begin:
    if(NavigationHandle.ActorReachable(Target))
    {
        FlushPersistentDebugLines();

        MoveToward(Target,Target,300);
        if(VSize(Pawn.Location - Target.Location) < AttackDistance)
        {
            GoToState('Attacking');
        }
    }
    else if(FindNavMeshPath())
    {
        NavigationHandle.SetFinalDestination(Target.Location);
        FlushPersistentDebugLines();

        if(NavigationHandle.GetNextMoveLocation(TempDest,Pawn.GetCollisionRadius()))
        {
            MoveTo(TempDest,Target);
        }
    }

    else
    {
    }
    goto 'Begin';
}

state Attacking
{
    function Tick(float DeltaTime)
    {
        if(Target ==none)
                GotoState('Idle');
    }
    function BeginState(Name PreviousStateName)
    {
        `log("BeginState Attack"@Pawn);
        SetTimer(2.0, true,'Attack');
    }
}

DefaultProperties
{
    AttackDistance=400.0
    MovementSpeed=100.0

}