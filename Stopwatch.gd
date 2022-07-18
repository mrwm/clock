extends Control

# Variables
var logged = {
  hour = 0,
  minute = 0,
  second = 0
  }
var delta = {
  hour = 0,
  minute = 0,
  second = 0
  }

onready var hourLabel = $"VBoxContainer/CenterContainer/TimeSplit/Hour";
onready var minuteLabel = $"VBoxContainer/CenterContainer/TimeSplit/Minute";
onready var secondLabel = $"VBoxContainer/CenterContainer/TimeSplit/Second";

onready var lapContainer = $"LapContainer";

var timer := Timer.new()

var prevTime = null;

# Called when the node enters the scene tree for the first time.
func _ready():
  #Variables.currentScene = Variables.CurrentSceneIs.STOPWATCH

  lapContainer.rect_size.y = rect_size.y / 4
  lapContainer.rect_position.y = rect_size.y - (rect_size.y / 2.15)
  lapContainer.rect_clip_content = true

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

  timer.paused = !Variables.stopwatchRun;

  # Set the text
  hourLabel.set_text(str(logged.hour));
  minuteLabel.set_text(str(logged.minute));
  secondLabel.set_text(str(logged.second));

  # Reset button
  if (Variables.stopwatchReset):
    logged = {
      hour = "00",
      minute = "00",
      second = "00"
      }
    delta = {
      hour = 0,
      minute = 0,
      second = 0
      }
    timer.queue_free()
    _prepareTimer()
    for child in lapContainer.get_child_count():
      lapContainer.get_child(child).queue_free()
      Variables.stopwatchLap = [];
    Variables.stopwatchReset = null;
  elif (Variables.stopwatchReset != null):
    timer.start()
    pass

  # Lap button
  if (Variables.stopwatchFlip):
    Variables.stopwatchLap.append(logged);
    Variables.stopwatchFlip = false;
    var label := Label.new();
    label.align = Label.ALIGN_CENTER;
    label.valign = Label.ALIGN_CENTER;
    label.size_flags_horizontal = 3;
    label.size_flags_vertical = 1;
    # warning-ignore
    if lapContainer.get_child(0):
      var deltaText = lapContainer.get_child(0).text.split(':')
      var deltaIndex = int(deltaText[0].split('.')[0]) + 1
      label.text = str(deltaIndex) + ". " + str(delta.hour) + ":" + str(delta.minute) + \
                    ":" + str(delta.second)
    else:
      label.text = "1. " + str(logged.hour) + ":" + str(logged.minute) + \
                  ":" + str(logged.second)
    label.name = "Lap-" + str(int(systemMs) + int(logged.second));
    delta = {
      hour = 0,
      minute = 0,
      second = 0
      }
    lapContainer.add_child(label);
    lapContainer.move_child(label, 0)
    if (Variables.stopwatchLap.size() > 20):
      Variables.stopwatchLap.remove(Variables.stopwatchLap.size() - 1)
      lapContainer.get_child(Variables.stopwatchLap.size()).queue_free()
  else:
    pass

  pass

func add_second(time):
  var updatedTime = time;
  updatedTime.second = int(updatedTime.second) + 1

  if int(updatedTime.second) > 59:
    updatedTime.minute = int(updatedTime.minute) + 1;
    updatedTime.second = 0;
  if int(updatedTime.minute) > 59:
    updatedTime.hour = int(updatedTime.hour) + 1;
    updatedTime.minute = 0;

  return updatedTime;

# Do I really need to pad time?
func pad_time(time):
  """Pad numbers with a leading zero if the number is less than 10"""
  var updatedTime = time;

  # Convert variable to string, then check if it is 2 digits long
  if len(str(updatedTime.hour)) < 2:
    updatedTime.hour = str("0") + str(updatedTime.hour);
  if len(str(updatedTime.minute)) < 2:
    updatedTime.minute = str("0") + str(updatedTime.minute);
  if len(str(updatedTime.second)) < 2:
    updatedTime.second = str("0") + str(updatedTime.second);
  return updatedTime;

func _on_Timeout():
  add_second(logged)
  add_second(delta)
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

