extends Node3D

@onready var visual: Node3D = $VisualNode
@onready var pickUpVFX: GPUParticles3D = $VFXNode
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var rotateSpeed: float = 1.0
var coinValue: int = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visual.rotate_y(rotateSpeed * delta)
	
	if visual.visible == false and pickUpVFX.emitting == false:
		queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group('Player'):
		pickUpVFX.emitting = true
		animationPlayer.play('collected')
		
		body.AddCoin(coinValue)
