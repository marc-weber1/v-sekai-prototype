extends Client
class_name VRClient

@onready var head = $You/PlayerCamera
var interface : XRInterface
var lhand
var rhand
var trackers = []

@export var user_height = 1.8


func _ready():
	super()
	
	interface = XRServer.find_interface("OpenXR")
	print("Found interface.")
	if interface and interface.is_initialized():
			print("OpenXR initialised successfully")

			get_viewport().use_xr = true
	else:
			print("OpenXR not initialised, please check if your headset is connected")
	
	#Setup signals
	XRServer.interface_added.connect(self._on_interface_activated)
	XRServer.interface_removed.connect(self._on_interface_deactivated)
	XRServer.tracker_added.connect(self._on_controller_activated)
	XRServer.tracker_removed.connect(self._on_controller_deactivated)

	#OS.vsync_enabled = false
	#Engine.target_fps = 90


## SEND AVATAR UPDATES

func _process(_delta):
	# Submit data over network (how often? which thread?)
	if multiplayer.has_multiplayer_peer():
		_send_tracker_pos()

func _send_tracker_pos():
	var head_pos = null
	var lhand_pos = null
	var rhand_pos = null
	var tracker_arr = []
	
	if head:
		head_pos = head.transform
	if lhand:
		lhand_pos = lhand.transform
	if rhand:
		rhand_pos = rhand.transform
	
	rpc("update_peer_tracker_pos", head_pos, lhand_pos, rhand_pos, tracker_arr)



## SIGNALS

func _on_interface_activated(name: StringName):
	pass
	#assert(XRServer.find_interface(name).is_initialized())
	
	#print("OpenXR initialised with interface ", name)
	#get_viewport().use_xr = true
	
func _on_interface_deactivated(name: StringName):
	print("OpenXR interface disconnected: ", name)

func _on_controller_activated(name: StringName, type: int):
	print("Controller activated: ", name, ", with type ", type)
	
	if type == XRServer.TRACKER_CONTROLLER:
		# Add the controller...
	
		if multiplayer.has_multiplayer_peer():
			rpc("remote_tracker_activated", name)

func _on_controller_deactivated(name: StringName, type: int):
	print("Controller activated: ", name, ", with type ", type)
	
	if type == XRServer.TRACKER_CONTROLLER:
		# Remove the controller...
			
		if multiplayer.has_multiplayer_peer():
			rpc("remote_tracker_deactivated", name)

