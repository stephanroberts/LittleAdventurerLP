extends CharacterBody3D


const SPEED = 0.5

@onready var navigationAgent: NavigationAgent3D = $NavigationAgent3D
@onready var visual: Node3D = $VisualNode
@onready var animationPlayer: AnimationPlayer = $VisualNode/AnimationPlayer

var player: Node3D

var direction: Vector3
var stopDistance: float = 2.2


func _ready():
	player = get_tree().get_first_node_in_group('Player')
	
func _physics_process(delta: float) -> void:
	
	navigationAgent.target_position = player.global_position
	
	direction = navigationAgent.get_next_path_position() - global_position
	direction.normalized()
	
	if navigationAgent.distance_to_target() < stopDistance:
		animationPlayer.play('NPC_01_IDEL')
		return
	
	velocity = velocity.lerp(direction * SPEED, delta)
	animationPlayer.play('NPC_01_WALK')
	
	if velocity.length() > 0.2:
		var lookDirection = Vector2(velocity.z, velocity.x)
		visual.rotation.y = lookDirection.angle()
	
	move_and_slide()
