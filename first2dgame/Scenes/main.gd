extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
@export var mob_scene: PackedScene
var score

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$AudioStreamPlayer2.play()



func new_game():
	score=0
	get_tree().call_group("mobs","queue_free")
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($Marker2D.position)
	$StartTimer.start()

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	$MobTimer.start()


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_locattion = $MobPath/MobSpawnLocation
	
	mob_spawn_locattion.progress_ratio = randf()
	
	mob.position = mob_spawn_locattion.position
	
	var direction = mob_spawn_locattion.rotation - PI / 2 
	
	direction += randf_range(-PI/4 , PI/4)
	mob.rotation = direction
	
	var velocity =Vector2(randf_range(150.0, 250.0),0.1)
	
	mob.linear_velocity = velocity.rotated(direction)
	add_child(mob)
