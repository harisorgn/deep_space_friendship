extends Area2D

signal hit

var speed = 500
var rotation_speed = 3.5

var screen_size

var rotation_dir = 0
var velocity = Vector2()

func _ready():
	screen_size = get_viewport_rect().size
	connect("body_entered", self, "_on_player_body_entered")
	
	$AnimatedSprite.animation = "afroditi"

func _process(delta):
	velocity = Vector2()
	rotation_dir = 0
	
	if Input.is_action_pressed("ui_right"):
		#velocity.x += 1
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		#velocity.x -= 1
		rotation_dir -= 1
	if Input.is_action_pressed("ui_down"):
		#velocity.y += 1
		velocity = Vector2(0, speed).rotated(rotation)
	if Input.is_action_pressed("ui_up"):
		#velocity.y -= 1
		velocity = Vector2(0, -speed).rotated(rotation)
		
	#if velocity.length() > 0:
	#	velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
#	if velocity.x != 0:
#		$AnimatedSprite.flip_v = false
#		$AnimatedSprite.flip_h = velocity.x < 0
#
#	elif velocity.y != 0:
#		$AnimatedSprite.flip_v = velocity.y > 0
	rotation += rotation_dir * rotation_speed * delta 
	
func _on_player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
