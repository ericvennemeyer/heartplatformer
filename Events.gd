extends Node

signal level_completed


#func _ready():
	#connect_heart_signals()
#
#
#func connect_heart_signals():
	#var hearts = get_tree().get_nodes_in_group("Hearts")
	#for heart in hearts:
		#heart.heart_collected.connect(_on_heart_collected)
#
#
#func _on_heart_collected():
	#var total_hearts = get_tree().get_nodes_in_group("Hearts")
	#print(total_hearts.size())
	#if total_hearts.size() == 1:
		#level_completed.emit()
