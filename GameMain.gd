extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var prevDir := Vector2(1,1)
var direction := Vector2(1,1)
var speed := 3.0
onready var displayRect = get_node("Control/ColorRect")
onready var sprite = get_node("Control/Sprite")
var spritePos := Vector2(0.5, 0.5)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	displayRect.rect_size.x = OS.window_size.x
	displayRect.rect_size.y = OS.window_size.y
	displayRect.color = Color(randf(), randf(), randf(), 1)
	SetSpritePos()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var screenSize : Vector2 = OS.get_screen_size()
	var windowSize : Vector2 = OS.window_size
	var windowPos : Vector2 = OS.window_position
	
	if windowPos.x + windowSize.x > screenSize.x:
		direction.x = -1
	if windowPos.x <= 0:
		direction.x = 1
	
	if windowPos.y + windowSize.y > screenSize.y:
		direction.y = -1
	if windowPos.y <= 0:
		direction.y = 1
	
	if direction != prevDir:
		prevDir = direction
		displayRect.color = Color(randf(), randf(), randf(), 1)
	
	var velocity = direction*speed
	OS.window_position = windowPos+velocity
	SetSpritePos(velocity)


func SetSpritePos(velocity : Vector2 = Vector2(0,0)):
	var newPos : Vector2
	newPos.x = OS.get_screen_size().x * spritePos.x
	newPos.y = OS.get_screen_size().y * spritePos.y
	
	newPos -= (OS.window_position + velocity)
	
	sprite.transform.origin.x = newPos.x
	sprite.transform.origin.y = newPos.y
