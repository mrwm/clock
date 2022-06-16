extends Control

# Declare member variables here. Examples:
onready var menuList = $"MenuList"
var settingsBtn := Button.new()
var secondToggle := CheckButton.new();
var use24Toggle := CheckButton.new();

var menuPostion = null
var menuSize = null
var menuHide = 0

# Called when the node enters the scene tree for the first time.
func _ready():
  # Settings button
  settingsBtn.name = "SettingsBtn";
  settingsBtn.text = "settings";
  settingsBtn.align = Button.ALIGN_LEFT;
  settingsBtn.flat = true;
  settingsBtn.toggle_mode = true;
  settingsBtn.connect("toggled", self, "_on_SettingsBtn_toggled");
  menuList.add_child(settingsBtn);

  # Padding label
  var paddingLabel1 := Label.new();
  paddingLabel1.name = "SettingsPad1";
  menuList.add_child(paddingLabel1);

  # Second toggle
  secondToggle.name = "SecondToggle";
  secondToggle.text = "show seconds";
  secondToggle.align = Button.ALIGN_LEFT;
  secondToggle.connect("toggled", self,"_on_SecondToggle_toggled");
  menuList.add_child(secondToggle);

  # 24 Hour toggle
  use24Toggle.name = "Use24Toggle";
  use24Toggle.text = "use 24HR clock";
  use24Toggle.align = Button.ALIGN_LEFT;
  use24Toggle.connect("toggled", self,"_on_User24Toggle_toggled");
  menuList.add_child(use24Toggle);

  # Padding label
  var paddingLabel2 := Label.new();
  paddingLabel2.name = "SettingsPad2";
  menuList.add_child(paddingLabel2);

  # Menu settings
  menuPostion = self.rect_position;
  #settingsBtn.connect("toggled", self,"_on_SettingsBtn_toggled");
  # Hide the menu except for the settings button
  menuSize = self.rect_size;
  for i in $MenuList.get_child_count():
    menuHide += $MenuList.get_child(i).rect_size.y;
    pass
  menuHide = menuHide - ($MenuList.get_child(0).rect_size.y + $MenuList.get_child(0).rect_size.y);
  pass # Replace with function body.


# TODO:
#
# -[x] Make the settings button slide up & reveal more info when pressed
# -[x] Make the menu slide up when a slide-up gesture is detected
# -[x] Make the menu entries via code, instead of manual
# -[ ] Load different parts of the menu depending on the current scene
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
