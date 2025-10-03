extends CharacterBody2D


const SPEED = 6000.0
const JUMP_VELOCITY = -400.0
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player_spawner: Node2D = $"../Player_Spawner"
var side = "down"

func _ready():
	pass

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO
	
	
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	
	velocity = direction * SPEED * delta
	

	
	if direction.x:
		animation_player.play("walk_side")
		side = "side"
		if direction.x < 0:
			sprite_2d.flip_h = false
		else:
			sprite_2d.flip_h = true

	
	if direction.y:
		if direction.y < 0:
			animation_player.play("walk_up")
			side = "up"
		else:
			animation_player.play("walk_down")
			side = "down"
			
	if velocity.x == 0 and velocity.y == 0:
		animation_player.play("idle_" + side)
		
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i);
		print("Collided with: ", collision.get_collider().name)


	move_and_slide()
