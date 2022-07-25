extends Client
class_name DesktopClient

@onready var head = $You/PlayerCamera


func _ready():
	super()
	print("[DEBUG] Desktop client initialized.")

## SEND AVATAR UPDATES

func _process(_delta):
	# Submit data over network (how often? which thread?)
	if multiplayer.has_multiplayer_peer():
		_send_pos()

func _send_pos():
	var head_pos = null
	
	if head:
		head_pos = head.transform
		
	rpc("update_remote_tracker_pos", head_pos, null, null, null)
