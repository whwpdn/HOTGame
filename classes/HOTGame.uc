class HOTGame extends UTGame;

var int EnemiesLeft;
var HOTEnemy EnemyPawn;
var vector EnemyPawnPos;
var int x,y;
var int WaveNum;
simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    EnemyPawnPos.x = 200.0f;
    EnemyPawnPos.y = 300.0f;
    EnemyPawnPos.z = 70.0f;

    GoalScore = EnemiesLeft;

    SetTimer(5.0, false, 'ActivateSpawners');
}

simulated function ActivateSpawners()
{
        if(WaveNum <2){
            for(x=0; x<2; x++)
            {
                for(y=0;y<2;y++){
                    EnemyPawnPos.y += 100.0f;
                    EnemyPawn = Spawn(class'HOTEnemy',,,EnemyPawnPos,,,);
                }
                EnemyPawnPos.x += 100.0f;
                EnemyPawnPos.y = 300.0f;
            }
             WaveNum++;
        }

    SetTimer(5.0, true, 'ActivateSpawners');
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

function AddDefaultInventory( pawn PlayerPawn )
{
	local int i;
	for (i=0; i<DefaultInventory.Length; i++)
	{
		// Ensure we don't give duplicate items
		if (PlayerPawn.FindInventoryType( DefaultInventory[i] ) == None)
		{
			// Only activate the first weapon
			PlayerPawn.CreateInventory(DefaultInventory[i], (i > 0));
		}
	}
	PlayerPawn.AddDefaultInventory();
}

defaultproperties
{   WaveNum=0;
    EnemiesLeft=50
    //bScoreDeaths=false
    PlayerControllerClass=class'HOTGame.HOTPlayerController'
    DefaultPawnClass=class'HOTGame.HOTPawn'
    //DefaultInventory(0)=class'UTWeap_LinkGun'
    DefaultInventory(0)=class'HOTGame.HOTWeapon'
}
