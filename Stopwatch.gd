extends Control

# Variables
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

onready var lapContainer = $"LapContainer";

var timer := Timer.new()

var prevTime = null;

# Called when the node enters the scene tree for the first time.
func _ready():
  #Variables.currentScene = Variables.CurrentSceneIs.STOPWATCH

  lapContainer.rect_size.y = rect_size.y / 3
  lapContainer.rect_position.y = rect_size.y - (rect_size.y / 2.15)

  _prepareTimer()

  hourLabel.rect_min_size = Vector2(120,0);
  minuteLabel.rect_min_size = Vector2(120,0);
  secondLabel.rect_min_size = Vector2(120,0);
  milsecLabel.rect_min_size = Vector2(120,0);

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
  elif len(str(logged.milsec)) < 3:
    logged.milsec = str("0") + str(logged.milsec);

  # Set the text
  hourLabel.set_text(str(logged.hour));
  minuteLabel.set_text(str(logged.minute));
  secondLabel.set_text(str(logged.second));
  milsecLabel.set_text(str(logged.milsec));

  # Reset button
  if (Variables.stopwatchReset):
    logged = {
      hour = 0,
      minute = 0,
      second = 0,
      milsec = 0
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
    # TODO: change lap to delta between each lap time instead of time lapsed
    if lapContainer.get_child(0):
      var currTime = {
        hour = logged.hour,
        minute = logged.minute,
        second = logged.second,
        milsec = logged.milsec,
       }
      var deltaTime = {
        hour = int(currTime.hour) - int(prevTime.hour),
        minute = int(currTime.minute) - int(prevTime.minute),
        second = int(currTime.second) - int(prevTime.second),
        milsec = int(currTime.milsec) - int(prevTime.milsec),
       }
      for key in deltaTime.keys():
        if deltaTime[key] < 0:
          var keyText = str(key)
          if keyText == "milsec":
            deltaTime[key] = int(currTime.milsec)*10 - int(prevTime.milsec)
            deltaTime.second = int(currTime.second) - 1
          if keyText == "second":
            deltaTime[key] = int(currTime.milsec)*10 - int(prevTime.milsec)
            deltaTime.minute = int(currTime.minute) - 1
          if keyText == "minute":
            deltaTime[key] = int(currTime.milsec)*10 - int(prevTime.milsec)
            deltaTime.hour = int(currTime.hour) - 1
      label.text = str(deltaTime.hour) + ":" + str(deltaTime.minute) + \
                  ":" + str(deltaTime.second) + ":" + str(deltaTime.milsec)
      prevTime = {
        hour = logged.hour,
        minute = logged.minute,
        second = logged.second,
        milsec = logged.milsec,
       }
    else:
      prevTime = {
        hour = logged.hour,
        minute = logged.minute,
        second = logged.second,
        milsec = logged.milsec,
       }
      label.text = str(logged.hour) + ":" + str(logged.minute) + \
                  ":" + str(logged.second) + ":" + str(logged.milsec)
    label.name = "Lap-" + str(int(logged.milsec) + int(logged.second));
    lapContainer.add_child(label);
    lapContainer.move_child(label, 0)
    if (Variables.stopwatchLap.size() > 4):
      Variables.stopwatchLap.remove(Variables.stopwatchLap.size() - 1)
      lapContainer.get_child(Variables.stopwatchLap.size()).queue_free()
  else:
    pass
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

