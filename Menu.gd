extends Control

# Declare member variables here. Examples:
onready var menuList = $"MenuList"
var settingsBtn := Button.new()
var toggle1;
var toggle2;
var toggle3;

var menuPostion = null
var menuHide = 0

# Called when the node enters the scene tree for the first time.
func _ready():

  if (Variables.currentScene == Variables.CurrentSceneIs.ALARM):
    print("alarm")

  elif (Variables.currentScene == Variables.CurrentSceneIs.CLOCK):
    toggle1 = CheckButton.new()
    toggle1.name = "SecondToggle";
    toggle1.text = "show seconds";
    toggle2 = CheckButton.new()
    toggle2.name = "Use24Toggle";
    toggle2.text = "use 24HR clock";
    toggle3 = CheckButton.new()
    toggle3.visible = false;

  elif (Variables.currentScene == Variables.CurrentSceneIs.TIMER):
    print("timer")

  elif (Variables.currentScene == Variables.CurrentSceneIs.STOPWATCH):
    toggle1 = Button.new()
    toggle1.name = "Start";
    toggle1.text = "start";
    toggle2 = Button.new()
    toggle2.name = "Lap";
    toggle2.text = "lap";
    toggle2.disabled = true;
    toggle3 = Button.new()
    toggle3.name = "Reset";
    toggle3.text = "reset";
    toggle3.disabled = true;

  # Settings button
  settingsBtn.name = "SettingsBtn";
  settingsBtn.text = "settings";
  settingsBtn.align = Button.ALIGN_LEFT;
  settingsBtn.flat = true;
  settingsBtn.toggle_mode = true;
  # warning-ignore:return_value_discarded
  settingsBtn.connect("toggled", self, "_on_SettingsBtn_toggled");
  menuList.add_child(settingsBtn);

  # Padding label
  var paddingLabel1 := Label.new();
  paddingLabel1.name = "SettingsPad1";
  menuList.add_child(paddingLabel1);
  paddingLabel1.rect_size.y = 100

  # First toggle
  toggle1.align = Button.ALIGN_LEFT;
  toggle1.flat = true;
  toggle1.toggle_mode = true;
  # warning-ignore:return_value_discarded
  toggle1.connect("toggled", self,"_on_FirstToggle_toggled");
  menuList.add_child(toggle1);

  # Second toggle
  toggle2.align = Button.ALIGN_LEFT;
  toggle2.flat = true;
  toggle2.toggle_mode = true;
  # warning-ignore:return_value_discarded
  toggle2.connect("toggled", self,"_on_SecondToggle_toggled");
  menuList.add_child(toggle2);

  # Third toggle
  toggle3.align = Button.ALIGN_LEFT;
  toggle3.flat = true;
  toggle3.toggle_mode = true;
  # warning-ignore:return_value_discarded
  toggle3.connect("toggled", self,"_on_ThirdToggle_toggled");
  menuList.add_child(toggle3);

  # Padding label
  var paddingLabel2 := Label.new();
  paddingLabel2.name = "SettingsPad2";
  menuList.add_child(paddingLabel2);

  # Menu settings
  menuPostion = self.rect_position;
  # Hide the menu except for the settings button
  for i in $MenuList.get_child_count():
    if ($MenuList.get_child(i).visible):
      menuHide += $MenuList.get_child(i).rect_size.y;
    pass
  menuHide = menuHide - $MenuList.get_child(0).rect_size.y;
  pass # Replace with function body.


# TODO:
#
# -[x] Make the settings button slide up & reveal more info when pressed
# -[x] Make the menu slide up when a slide-up gesture is detected
# -[x] Make the menu entries via code, instead of manual
# -[x] Transfer loading menu from within different scene to the main scene
# -[x] Change menu list item order after deleting and readding them
# -[x] Load different parts of the menu depending on the current scene
# -[ ] Fix menu text after transitions
# -[ ] Change menu from settings to bottom bar
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

  if (Variables.switchScene):
    Variables.switchScene = false
    _update_btn_text(Variables.currentScene)

# Update button text on current scene
func _update_btn_text(scene):
  toggle1.queue_free()
  toggle2.queue_free()
  toggle3.queue_free()

  if (scene == Variables.CurrentSceneIs.ALARM):
    print("alarm")

  elif (scene == Variables.CurrentSceneIs.CLOCK):
    toggle1 = CheckButton.new()
    toggle1.name = "SecondToggle";
    toggle1.text = "show seconds";
    toggle2 = CheckButton.new()
    toggle2.name = "Use24Toggle";
    toggle2.text = "use 24HR clock";
    toggle3 = CheckButton.new()
    toggle3.visible = false;

  elif (scene == Variables.CurrentSceneIs.TIMER):
    print("timer")

  elif (scene == Variables.CurrentSceneIs.STOPWATCH):
    toggle1 = Button.new()
    toggle1.name = "Start";
    toggle1.text = "start";
    toggle2 = Button.new()
    toggle2.name = "Lap";
    toggle2.text = "lap";
    toggle2.disabled = true;
    toggle3 = Button.new()
    toggle3.name = "Reset";
    toggle3.text = "reset";
    toggle3.disabled = true;

  # First toggle
  toggle1.align = Button.ALIGN_LEFT;
  toggle1.flat = true;
  toggle1.toggle_mode = true;
  # warning-ignore:return_value_discarded
  toggle1.connect("toggled", self,"_on_FirstToggle_toggled");
  menuList.add_child(toggle1);
  

  # Second toggle
  toggle2.align = Button.ALIGN_LEFT;
  toggle2.flat = true;
  toggle2.toggle_mode = true;
  # warning-ignore:return_value_discarded
  toggle2.connect("toggled", self,"_on_SecondToggle_toggled");
  menuList.add_child(toggle2);

  # Third toggle
  toggle3.align = Button.ALIGN_LEFT;
  toggle3.flat = true;
  toggle3.toggle_mode = true;
  # warning-ignore:return_value_discarded
  toggle3.connect("toggled", self,"_on_ThirdToggle_toggled");
  menuList.add_child(toggle3);

  # move the buttons to position
  menuList.move_child(toggle1, 2);
  menuList.move_child(toggle2, 3);
  menuList.move_child(toggle3, 4);
  pass

# Settings button
func _on_SettingsBtn_toggled(button_pressed):
  Variables.showSettings = button_pressed;
  pass

# First Toggle button
func _on_FirstToggle_toggled(button_pressed):
  #if (Variables.currentScene == Variables.CurrentSceneIs.ALARM):
  #  print("alarm")

  # replace with elif
  if (Variables.currentScene == Variables.CurrentSceneIs.CLOCK):
    Variables.showSeconds = button_pressed;

  #elif (Variables.currentScene == Variables.CurrentSceneIs.TIMER):
  #  print("timer")

  elif (Variables.currentScene == Variables.CurrentSceneIs.STOPWATCH):
    Variables.stopwatchRun = button_pressed;
    if (Variables.stopwatchRun):
      toggle1.text = "pause"
      toggle2.disabled = false;
      toggle3.disabled = false;
    else:
      toggle1.text = "resume"
      toggle2.disabled = true;
  pass

# Second Toggle button
func _on_SecondToggle_toggled(button_pressed):
  #if (Variables.currentScene == Variables.CurrentSceneIs.ALARM):
  #  print("alarm")

  # replace with elif
  if (Variables.currentScene == Variables.CurrentSceneIs.CLOCK):
    Variables.use24hour = button_pressed;

  #elif (Variables.currentScene == Variables.CurrentSceneIs.TIMER):
  #  print("timer")

  elif (Variables.currentScene == Variables.CurrentSceneIs.STOPWATCH):
    Variables.stopwatchFlip = !Variables.stopwatchFlip
  pass

# Third Toggle button
# warning-ignore:unused_argument
func _on_ThirdToggle_toggled(button_pressed):
  #if (Variables.currentScene == Variables.CurrentSceneIs.ALARM):
  #  Variables.stopwatchReset = null;
  #  print("alarm")

  # replace with elif
  if (Variables.currentScene == Variables.CurrentSceneIs.CLOCK):
    #print("clock")
    pass

  #elif (Variables.currentScene == Variables.CurrentSceneIs.TIMER):
  #  print("timer")

  elif (Variables.currentScene == Variables.CurrentSceneIs.STOPWATCH):
    toggle1.pressed = false;
    toggle2.disabled = true;
    toggle3.disabled = true;
    Variables.stopwatchRun = false;
    Variables.stopwatchReset = true;
    toggle1.text = "start"
  pass
