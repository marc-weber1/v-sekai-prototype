extends StaticBody3D

@onready var _viewport = get_node("Viewport")
var ws = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func apply_world_scale():
	var new_ws = XRServer.world_scale
	if (new_ws and ws != new_ws):
		ws = new_ws
		self.scale = Vector3(ws, ws, ws)

# Send player's keyboard input to the viewport
func _input(event):
	if event is InputEventKey:
		_viewport.input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	apply_world_scale()
