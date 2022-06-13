extends Control

# Variables
var timeValue = null;

onready var ampm = $"VBoxContainer/CenterContainer/TimeSplit/ampm";
onready var hour = $"VBoxContainer/CenterContainer/TimeSplit/Hour";
onready var minute = $"VBoxContainer/CenterContainer/TimeSplit/Minute";
onready var second = $"VBoxContainer/CenterContainer/TimeSplit/Second";
#onready var touchpos = $"VBoxContainer/touchpos";
var touchpos = null

# Called when the node enters the scene tree for the first time.
func _ready():
  var Menu : PackedScene = load("res://Menu.tscn")
  var menu = Menu.instance()
  add_child(menu)
  touchpos = menu.get_node("VBoxContainer/touchpos")

  #print(Engine.time_scale) #How fast we want the program to run
  ampm.set_text("")
  second.set_text("")
  #touchpos.set_text("") # leave empty for padding bottom of screen
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  timeValue = OS.get_time();
  var isAM = true;
  var currentHour = timeValue.hour;
  var currentMinute = timeValue.minute;
  var currentSecond = timeValue.second;

  ampm.visible = false;
  second.visible = false;

  if (currentHour > 12):
    isAM = false;
    # Toggle between 24 and 12 hour clocks
    if (!Variables.use24hour):
      currentHour = currentHour - 12;
      ampm.visible = true;

  # Pad numbers less than 10 with a leading zero
  if currentMinute < 10:
    currentMinute = str("0") + str(currentMinute)
  if currentSecond < 10:
    currentSecond = str("0") + str(currentSecond)

  if (Variables.showSeconds):
    second.visible = true;
    second.set_text(": " + str(currentSecond))
  if (!Variables.use24hour):
    if (isAM):
      ampm.set_text("a.m.")
    else:
      ampm.set_text("p.m.")
  else:
    pass

  hour.set_text(str(currentHour));
  minute.set_text(": " + str(currentMinute));
  pass
