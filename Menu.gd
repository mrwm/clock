extends Control

# Declare member variables here. Examples:
onready var settingsBtn = $"VBoxContainer/SettingsBtn";
onready var secondToggle = $"VBoxContainer/SecondToggle";
onready var use24Toggle = $"VBoxContainer/Use24Toggle";
onready var touchpos = $"VBoxContainer/touchpos";

var menuPostion = null
var menuSize = null
var menuHide = 0

# Called when the node enters the scene tree for the first time.
func _ready():
  menuPostion = self.rect_position;
  touchpos.set_text(""); # leave empty for padding bottom of screen
  use24Toggle.connect("toggled", self,"_on_User24Toggle_toggled");
  settingsBtn.connect("toggled", self,"_on_SettingsBtn_toggled");

  # Hide the menu except for the settings button
  menuSize = self.rect_size;
  for i in $VBoxContainer.get_child_count():
    menuHide += $VBoxContainer.get_child(i).rect_size.y;
    pass
  menuHide = menuHide - ($VBoxContainer.get_child(0).rect_size.y + $VBoxContainer.get_child(0).rect_size.y);
  pass # Replace with function body.


# TODO:
#
# - Make the settings button slide up & reveal more info when pressed
# - Make the menu slide up when a slide-up gesture is detected
#

var t1 = 0.0
var t2 = 0.0
var duration = 0.13
func _process(delta):
  # Show the menu
  if (Variables.showSettings):
    if t2 < duration:
      t2 += delta
      self.rect_position.y = lerp(menuHide, 0, t2 / duration)
      t1 = 0
      settingsBtn.pressed = true
  else:
    # Hide the menu
    if t1 < duration:
      t1 += delta
      self.rect_position.y = lerp(0, menuHide, t1 / duration)
      t2 = 0
      if self.rect_position.y > menuHide:
        self.rect_position.y = menuHide
    settingsBtn.pressed = false

# Signal connect via code
func _on_SettingsBtn_toggled(button_pressed):
  Variables.showSettings = button_pressed;
  pass

# Manual signal connect
func _on_SecondToggle_toggled(button_pressed):
  Variables.showSeconds = button_pressed;
  pass # Replace with function body.

# Signal connect via code
func _on_User24Toggle_toggled(button_pressed):
  Variables.use24hour = button_pressed;
  pass
