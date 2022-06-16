extends Control

# Variables
var isRunning = false;
var logged = {
  hour = 0,
  minute = 0,
  second = 0,
  milsec = 0
  }

onready var hourLabel = $"VBoxContainer/CenterContainer/TimeSplit/Hour";
onready var minuteLabel = $"VBoxContainer/CenterContainer/TimeSplit/Minute";
onready var secondLabel = $"VBoxContainer/CenterContainer/TimeSplit/Second";
onready var milsecLabel = $"VBoxContainer/CenterContainer/TimeSplit/milsecLabel";

var timer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
  # Countdown timer for counting up
  timer.autostart = true;
  timer.wait_time = 1;
  timer.name = "Timer"
  timer.connect("timeout", self, "_on_Timeout")
  add_child(timer)


  Variables.currentScene = Variables.CurrentSceneIs.STOPWATCH

  hourLabel.rect_min_size = Vector2(120,0);
  minuteLabel.rect_min_size = Vector2(120,0);
  secondLabel.rect_min_size = Vector2(120,0);
  milsecLabel.rect_min_size = Vector2(120,0);

  #print(Engine.time_scale) #How fast we want the program to run
  #milsecLabel.visible = false;
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  var systemMs = 1 - timer.time_left
  systemMs = float(str(systemMs).left(5))*1000

  logged.milsec = systemMs

  # Pad numbers with a leading zero if the number is less than 10
  # Convert variable to string, then check if it is 2 digits long
  if len(str(logged.hour)) < 2:
    logged.hour = str("0") + str(logged.hour);
  if len(str(logged.minute)) < 2:
    logged.minute = str("0") + str(logged.minute);
  if len(str(logged.second)) < 2:
    logged.second = str("0") + str(logged.second);
  elif len(str(logged.milsec)) < 3:
    logged.milsec = str("0") + str(logged.milsec);

  # Set the text
  hourLabel.set_text(str(logged.hour));
  minuteLabel.set_text(str(logged.minute));
  secondLabel.set_text(str(logged.second));
  milsecLabel.set_text(str(logged.milsec));

  pass

func update_time(time):

  var updatedTime = time;

  updatedTime.second = int(updatedTime.second) + 1

  if int(updatedTime.second) > 59:
    updatedTime.minute = int(updatedTime.minute) + 1;
    updatedTime.second = 0;
  if int(updatedTime.minute) > 59:
    updatedTime.hour = int(updatedTime.hour) + 1;
    updatedTime.minute = 0;

  return updatedTime;

func _on_Timeout():
  update_time(logged)
  pass


