extends Control

# Variables
var logged = {
  hour = 0,
  minute = 0,
  second = 0,
  }

onready var hourLabel = $"VBoxContainer/CenterContainer/TimeSplit/Hour";
onready var minuteLabel = $"VBoxContainer/CenterContainer/TimeSplit/Minute";
onready var secondLabel = $"VBoxContainer/CenterContainer/TimeSplit/Second";


var timer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
  #Variables.currentScene = Variables.CurrentSceneIs.TIMER

  _prepareTimer()

  hourLabel.rect_min_size = Vector2(120,0);
  minuteLabel.rect_min_size = Vector2(120,0);
  secondLabel.rect_min_size = Vector2(120,0);

  Variables.stopwatchRun = false;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  var systemMs = 1
  if (timer != null):
    systemMs = systemMs - timer.time_left
    systemMs = float(str(systemMs).left(5))*1000

  logged.milsec = systemMs;
  timer.paused = !Variables.stopwatchRun;

  # Pad numbers with a leading zero if the number is less than 10
  # Convert variable to string, then check if it is 2 digits long
  if len(str(logged.hour)) < 2:
    logged.hour = str("0") + str(logged.hour);
  if len(str(logged.minute)) < 2:
    logged.minute = str("0") + str(logged.minute);
  if len(str(logged.second)) < 2:
    logged.second = str("0") + str(logged.second);

  # Set the text
  hourLabel.set_text(str(logged.hour));
  minuteLabel.set_text(str(logged.minute));
  secondLabel.set_text(str(logged.second));

  # Set timer button
  if (Variables.setTimer):
    pass

  # Start/stop timer button
  if (Variables.timerRun):
    pass

  # Reset timer button
  if (Variables.resetTimer):
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

func _prepareTimer():
  # Countdown timer for counting up
  timer = Timer.new()
  timer.autostart = true
  timer.wait_time = 1
  timer.name = "Timer"
  timer.paused = !Variables.stopwatchRun;
  # warning-ignore:return_value_discarded
  timer.connect("timeout", self, "_on_Timeout")
  add_child(timer)

