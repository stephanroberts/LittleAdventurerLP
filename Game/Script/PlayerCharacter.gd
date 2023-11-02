extends CharacterBody3D

@onready var visual: Node3D = $VisualNode
@onready var animationPlayer: AnimationPlayer = $VisualNode/AnimationPlayer

@onready var footStepVFX: GPUParticles3D = $VisualNode/VFX/Footstep_GPUParticles3D

const SPEED = 5.0

var direction: Vector3
var slideKey_pressed: bool = false
var attackKey_pressed: bool = false

var coinNumber: int:
	set(new_value):
		coinNumber = new_value
		emit_signal('coinNumberUpdated', coinNumber)

signal coinNumberUpdated(newValue)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	slideKey_pressed = Input.is_action_just_pressed('slide')
	attackKey_pressed = Input.is_action_just_pressed('attack')

	move_and_slide()
	
func AddCoin(value: int):
	coinNumber += value
#	print(coinNumber)	
