extends CharacterBody3D

# How fast the player moves, im m/s
@export var speed = 14

#Downward acceleration, when in the air, in m/s squared
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	
	# create a local variable to store the input definition
	var direction = Vector3.ZERO
	
	#check for each key press 
	#(note Z is the "deth"to go forward and backwards
	if Input.is_action_pressed("move_right"):
		direction.x += 1.0
	if Input.is_action_just_pressed("move_left"):
		direction.X -= 1.0
	if Input.is_action_just_pressed("move_forward"):
		direction.z -=1
	if Input.is_action_just_pressed("move_back"):
		direction.z +=1	
	
	
	if direction != Vector3.ZERO:
		#normalizing the vector to keep sanity
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
		
	# ground velocity
	target_velocity.x = direction.x * speed
	target_velocity.y = direction.y * speed
	
	# Vertical velocity
	if not is_on_floor():
		target_velocity.y -= (fall_acceleration * delta)
	
	#move the character
	velocity = target_velocity
	move_and_slide()
