extends Node3D

var peer = ENetMultiplayerPeer.new()
const PORT = 8081

func _on_host_pressed() -> void:
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer # Replace with function body.
	multiplayer.peer_connected.connect(add_player)
	add_player()
	$CanvasLayer.hide()
	
func _on_join_pressed() -> void:
	peer.create_client("127.0.0.1", PORT)
	multiplayer.multiplayer_peer = peer
	$CanvasLayer.hide()

@onready var player_scene = preload("res://player.tscn")
func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)

	call_deferred("add_child", player)
