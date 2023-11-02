extends StateBase

@export var hitBoxCollisionShape: CollisionShape3D

@export var bladeMaterialEffectAnimationPlayer: AnimationPlayer
@export var VFX_Blade: Node3D


func enableHitBox():
	hitBoxCollisionShape.disabled = false
	print('hit box disabled =', hitBoxCollisionShape.disabled)
func disableHitBox():
	hitBoxCollisionShape.disabled = true
	print('hit box disabled =', hitBoxCollisionShape.disabled)

func enter():
	super.enter()
	
	character.velocity.x = 0
	character.velocity.z = 0
	
	VFX_Blade.visible = true
	bladeMaterialEffectAnimationPlayer.stop()
	bladeMaterialEffectAnimationPlayer.play('PlayerBladeVFX', -1, 2.0)

func exit():
	super.exit()
	disableHitBox()
	VFX_Blade.visible = false

func state_update(_delta):
	if animationPlayer.is_playing() == false:
		state_machine.switchTo('Idle')
