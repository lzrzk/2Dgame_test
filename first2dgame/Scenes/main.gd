extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
@export var mob_scene: PackedScene
var score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()


func new_game():
	score=0
	$Player.start($Marker2D.position)
	$StartTimer.start()
