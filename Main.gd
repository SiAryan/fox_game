extends Node2D


func _on_play_btn_pressed():
	get_tree().change_scene("res://game_scn_1.tscn")	



func _on_quit_btn_pressed():
	get_tree().quit()
