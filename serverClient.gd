extends Node

# Serveur sans interface graphique (headless possible)
var peer = ENetMultiplayerPeer.new()
const PORT = 8080

func _ready():
	# Initialisation réseau
	# set_multiplayer_authority(multiplayer.get_unique_id())
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	
func _on_player_connected(id):
	print("[SERVER] Nouveau joueur connecté avec l'ID:", id)
	
	add_player(id)
	
func _on_player_disconnected(id):
	print("[SERVER] Joueur déconnecté avec l'ID:", id)

@onready var player_scene = preload("res://player.tscn")
func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	var world = get_node("/root/world")
	world.call_deferred("add_child", player)
	

"""
##
### OVERMASS
##
#var peer = ENetMultiplayerPeer.new()
var peer = ENetMultiplayerPeer.new()

const PORT = 8080

func _ready():
	#peer.create_client("localhost",PORT) 192.168.1.115	109.51.39.171
	#peer.create_client("192.168.1.115:8080")
	
	#peer.create_client("127.0.0.1", 8080)
	#multiplayer.multiplayer_peer = peer
	
	#var url = "wss://vps-ad5ab9fd.vps.ovh.net/ws/"
	#var err = peer.create_client(url)
	#if err != OK:
	#	show_server_down_message("Erreur initiale de connexion : %d" % err)
	#else:
	#	multiplayer.multiplayer_peer = peer
	#	multiplayer.connection_failed.connect(_on_connection_failed)
	"""
