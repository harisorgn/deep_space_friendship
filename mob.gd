extends RigidBody2D

export var min_speed = 50
export var max_speed = 400

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func init(init_position, init_direction):
	position = init_position
	rotation = init_direction
	
	linear_velocity = Vector2(rand_range(min_speed, max_speed), 0)
	linear_velocity = linear_velocity.rotated(rotation)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
