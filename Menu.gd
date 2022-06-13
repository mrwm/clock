extends Control

# Declare member variables here. Examples:
onready var touchpos = $"VBoxContainer/touchpos";
onready var secondToggle = $"VBoxContainer/SecondToggle";
onready var use24Toggle = $"VBoxContainer/Use24Toggle";

var menuPostion = null
var menuSize = null
var menuHide = 0

# Called when the node enters the scene tree for the first time.
func _ready():
  menuPostion = self.rect_position;
  touchpos.set_text(""); # leave empty for padding bottom of screen
  use24Toggle.connect("toggled", self,"_on_User24Toggle_toggled");
  menuSize = self.rect_size;
  for i in $VBoxContainer.get_child_count():
    menuHide += $VBoxContainer.get_child(i).rect_size.y;
    pass
  menuHide = menuHide - $VBoxContainer.get_child(0).rect_size.y;
  self.rect_position.y = menuHide;
  pass # Replace with function body.


# TODO:
#
# - Make the settings button slide up & reveal more info when pressed
# - Make the menu slide up when a slide-up gesture is detected
#



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

func _showMenu():
  pass
