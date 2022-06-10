extends Control

# Variables
var timeValue = null;
var requ = null;
var showSeconds = false;
var use24hour = false;

onready var timeText = $"VBoxContainer/TimeLabel";

# Called when the node enters the scene tree for the first time.
func _ready():
  #print(Engine.time_scale) #How fast we want the program to run
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  timeValue = OS.get_time();
  var isAM = true;
  var currentHour = timeValue.hour;
  var currentMinute = timeValue.minute;
  var currentSecond = timeValue.second;

  # Toggle between 24 and 12 hour clocks
  if (currentHour > 12):
    isAM = false;

  # Pad numbers less than 10 with a leading zero
  if currentMinute < 10:
    currentMinute = str("0") + str(currentMinute)
  if currentSecond < 10:
    currentSecond = str("0") + str(currentSecond)

  var formatedTime = " : " + str(currentMinute);

  if (showSeconds):
    formatedTime = formatedTime + " : " + str(currentSecond)
  if (!use24hour):
    currentHour = int(currentHour) - 12;
    if (isAM):
      formatedTime = str(currentHour) + formatedTime + " a.m."
    else:
      formatedTime = str(currentHour) + formatedTime + " p.m."
  else:
    formatedTime = str(currentHour) + formatedTime

  timeText.set_text(formatedTime);
  pass

func _on_CheckButton_toggled(button_pressed):
  showSeconds = button_pressed;
  pass

func _on_CheckButton2_toggled(_button_pressed):
  use24hour = !use24hour;
  pass
