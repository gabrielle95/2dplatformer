extends KinematicBody2D

const VELOCITY_X = 20000;
const GRAVITY = 5000;
const VELOCITY_ZERO = 0;
const JUMPFORCE = -100000;

var player_velocity = Vector2(0,0);
const up_direction = Vector2.UP;

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		player_velocity.x = VELOCITY_X * delta;
		$AnimatedSprite.flip_h = false;
		if self.is_on_floor():
			$AnimatedSprite.play("run");
	elif Input.is_action_pressed("ui_left"):
		player_velocity.x = -VELOCITY_X * delta;
		$AnimatedSprite.flip_h = true;
		if self.is_on_floor():
			$AnimatedSprite.play("run");
	else:
		$AnimatedSprite.play("idle");
	
	player_velocity.y += GRAVITY * delta;
	
	if Input.is_action_just_pressed("ui_up") and self.is_on_floor():
		player_velocity.y = JUMPFORCE * delta;
		$AnimatedSprite.play("jump_start");
	
	if !self.is_on_floor():
		$AnimatedSprite.play("midair");
	
	player_velocity = self.move_and_slide(player_velocity, up_direction);
	
	if player_velocity.x != 0:
		player_velocity.x = lerp(player_velocity.x, 0, 0.1);
