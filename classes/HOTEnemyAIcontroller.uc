class HOTEnemyAIcontroller extends AIController;

var() Vector TempDest;

var float AttackDistance;
var float MovementSpeed;
var vector NewLocation;
var HOTEnemyRocket RocketAttack;
var HOTEnemyWeapon EnemyWeaponGun;
var HOTTemple AT;
var HOTTemple tmp;
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
            tmp=AT;
        }
   }
}
function Attack()
{
    if(tmp.Health <=0){
        ClearTimer('Attack');
        GoToState('Idle');
    }
    else{
        HOTEnemy(Pawn).W.AttackTemple(1);
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

        class'NavMeshPath_Toward'.static.TowardGoal(NavigationHandle,tmp);
        class'NavMeshGoal_At'.static.AtActor(NavigationHandle,tmp,32,true);

        return NavigationHandle.FindPath();
    }

Begin:
    if(NavigationHandle.ActorReachable(tmp))
    {
        FlushPersistentDebugLines();

        MoveToward(tmp,tmp,300);
        if(VSize(Pawn.Location - tmp.Location) < AttackDistance)
        {
            GoToState('Attacking');
        }
    }
    else if(FindNavMeshPath())
    {
        NavigationHandle.SetFinalDestination(tmp.Location);
        FlushPersistentDebugLines();

        if(NavigationHandle.GetNextMoveLocation(TempDest,Pawn.GetCollisionRadius()))
        {
            MoveTo(TempDest,tmp);
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