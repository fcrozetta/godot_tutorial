extends CharacterBody3D

# min and max speed for mob, in m/s
@export var min_speed = 10
@export var max_speed = 18

func _physics_process(delta):
	move_and_slide()

# this function will be called by the main function
func initialize(start_position, player_position):
	
	# position the mob by placing it at start_position,
	# and rotate it to look to player_position
	look_at_from_position(start_position,player_position,Vector3.UP)
	
	# then, rotate the mob randomly between -45 and +45 
	#so it does no got straight into player
	rotate_y(randf_range (-PI/4, PI/4))
	
	
	# calculate velocity
	var random_speed = randi_range(min_speed,max_speed)
	
	# calculate forward velocity
	velocity = Vector3.FORWARD * random_speed
	
	# Then we rotate the velocity vector based on 
	# the mob's Y rotation in order to move in the 
	#direction of the player
	
	velocity = velocity.rotated(Vector3.UP,rotation.y)


func _on_visibility_notifier_screen_exited():
	queue_free()
