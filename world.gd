extends Node2D

@export var next_level: PackedScene

var level_time = 0.0
var start_level_ms = 0.0

@onready var level_completed = $CanvasLayer/LevelCompleted
@onready var animation_player = $AnimationPlayer
@onready var level_time_label = %LevelTimeLabel


func _ready():
	if not next_level is PackedScene:
		level_completed.next_level_button.text = "Finish"
		next_level = load("res://victory_screen.tscn")
	Events.level_completed.connect(_on_level_completed)
	connect_heart_signals()
	get_tree().paused = true
	LevelTransition.fade_from_black()
	animation_player.play("countdown")
	await animation_player.animation_finished
	get_tree().paused = false
	start_level_ms = Time.get_ticks_msec()


func _process(delta):
	level_time = Time.get_ticks_msec() - start_level_ms
	level_time_label.text = str(level_time / 1000.0)


func connect_heart_signals():
	var hearts = get_tree().get_nodes_in_group("Hearts")
	for heart in hearts:
		heart.heart_collected.connect(_on_heart_collected)


func _on_heart_collected():
	var total_hearts = get_tree().get_nodes_in_group("Hearts")
	if total_hearts.size() == 1:
		_on_level_completed()


func _on_level_completed():
	show_level_completed()
	level_completed.retry_button.grab_focus()
	get_tree().paused = true


func retry():
	await LevelTransition.fade_to_black()
	get_tree().reload_current_scene()


func go_to_next_level():
	if not next_level is PackedScene: return
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)


func show_level_completed():
	level_completed.visible = true


func _on_level_completed_next_level():
	go_to_next_level()


func _on_level_completed_retry():
	retry()
