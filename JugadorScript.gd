extends KinematicBody2D


export var fall_gravity_scale := 2000
export var low_jump_gravity_scale := 1000
export var jump_power := 10000
var jump_released = false
onready var sprite = $Sprite
onready var Animacion = $AnimationPlayer


var velocity = Vector2()
var earth_gravity = 10 
export var gravity_scale := 900
var on_floor = false
export (int) var speed = 450
var motion = Vector2()
var estado = false

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		sprite.flip_h = false
		Animacion.play("Caminar")
		velocity.x += 1
	elif Input.is_action_pressed("left"):
		sprite.flip_h = true
		Animacion.play("Caminar")
		velocity.x -= 1
	else:
		Animacion.play("Quieto")
		estado = false
		
	velocity = velocity.normalized() * speed
pass

func _physics_process(delta):
	if Input.is_action_just_released("ui_accept"):
		jump_released = true
	
	velocity += Vector2.DOWN * earth_gravity * gravity_scale * delta
	
	if velocity.y > 0: 
		velocity += Vector2.DOWN * earth_gravity * fall_gravity_scale * delta 
	elif velocity.y < 0 && jump_released:  
				velocity += Vector2.DOWN * earth_gravity * low_jump_gravity_scale * delta
	if on_floor:
		if Input.is_action_just_pressed("ui_accept"): 
			velocity = Vector2.UP * jump_power 
			jump_released = false

	velocity = move_and_slide(velocity, Vector2.UP) 

	if is_on_floor(): on_floor = true
	else: on_floor = false
	
	get_input()
