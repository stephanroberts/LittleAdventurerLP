extends StateBase

var slideSpeed: float = 650
var slideDuration: float = 0.3
var remainSlideDuration: float

var facingDirection: Vector3

func enter():
	super.enter()
	character.velocity.x = 0
	character.velocity.z = 0
	remainSlideDuration = slideDuration
	
func state_update(_delta: float):
	
	remainSlideDuration -= _delta
	
	facingDirection = character.visual.transform.basis.z
	
	if remainSlideDuration > 0:
		character.velocity.x = facingDirection.x * slideSpeed * _delta
		character.velocity.z = facingDirection.z * slideSpeed * _delta
	else:
		character.velocity.x = 0
		character.velocity.z = 0
		state_machine.switchTo('Idle')
