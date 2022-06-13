extends Control

# Declare member variables here. Examples:
onready var touchpos = $"VBoxContainer/touchpos";
onready var secondToggle = $"VBoxContainer/SecondToggle";
onready var use24Toggle = $"VBoxContainer/Use24Toggle";


# Called when the node enters the scene tree for the first time.
func _ready():
  touchpos.set_text(""); # leave empty for padding bottom of screen
  use24Toggle.connect("toggled", self,"_on_User24Toggle_toggled");
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

# Manual signal connect
func _on_SecondToggle_toggled(button_pressed):
  Variables.showSeconds = button_pressed;
  pass # Replace with function body.

# Signal connect via code
func _on_User24Toggle_toggled(button_pressed):
  Variables.use24hour = button_pressed;
  pass

