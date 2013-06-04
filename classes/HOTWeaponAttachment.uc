class HOTWeaponAttachment extends UTWeaponAttachment;

simulated function AttachTo(UTPawn OwnerPawn)
{
	if (OwnerPawn.Mesh != None)
	{
		// Attach Weapon mesh to player skelmesh
		if ( Mesh != None )
		{
			// Weapon Mesh Shadow
			Mesh.SetShadowParent(OwnerPawn.Mesh);
			Mesh.SetLightEnvironment(OwnerPawn.LightEnvironment);

			OwnerPawn.Mesh.AttachComponentToSocket(Mesh, 'WeaponPoint');
		}
	}
}

/**
 * Detach weapon from skeletal mesh
 */
simulated function DetachFrom( SkeletalMeshComponent MeshCpnt )
{
	// Weapon Mesh Shadow
	if ( Mesh != None )
	{
		Mesh.SetShadowParent(None);
		Mesh.SetLightEnvironment(None);
	}
	if ( MeshCpnt != None )
	{
		// detach weapon mesh from player skelmesh
		if ( Mesh != None )
		{
			MeshCpnt.DetachComponent( mesh );
		}
	}
}
defaultproperties
{
    Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_3P'
	End Object
}