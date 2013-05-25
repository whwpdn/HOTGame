class HOTGame extends UTGame;

var int EnemiesLeft;
var HOTEnemy EnemyPawn;
var vector EnemyPawnPos;
var int x,y;
var int WaveNum;
var HOTTemple AT;
simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    EnemyPawnPos.x = 200.0f;
    EnemyPawnPos.y = 300.0f;
    EnemyPawnPos.z = 70.0f;
    foreach DynamicActors(class'HOTTemple',AT);
    GoalScore = EnemiesLeft;

    SetTimer(5.0, false, 'ActivateSpawners');
}

simulated function ActivateSpawners()
{
        if(WaveNum <1){
            for(x=0; x<1; x++)
            {
                for(y=0;y<2;y++){
                    EnemyPawnPos.y += 100.0f;
                    EnemyPawn = Spawn(class'HOTEnemy',,,EnemyPawnPos,,,);
                    EnemyPawn.ControllerClass=class'HOTGame.HOTEnemyAIcontroller';
                }
                EnemyPawnPos.x += 100.0f;
                EnemyPawnPos.y = 300.0f;
            }
             WaveNum++;
        }

   // SetTimer(5.0, false, 'ActivateSpawners');
}

function ScoreObjective(PlayerReplicationInfo Scorer, Int Score)
{

    EnemiesLeft--;
    super.ScoreObjective(Scorer, Score);
    if(EnemiesLeft == 0 )
    {
        ClearTimer('ActivateSpawners');
        `log("cleartime");
    }
}
defaultproperties
{   WaveNum=0;
    EnemiesLeft=10
    //bScoreDeaths=false
    PlayerControllerClass=class'HOTGame.HOTPlayerController'
    DefaultPawnClass=class'HOTGame.HOTPawn'
    //DefaultInventory(0)=class'UTWeap_LinkGun'
    DefaultInventory(0)=class'HOTGame.HOTWeapon'
}
