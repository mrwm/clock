extends Control

# Variables
var timeValue = 0;

onready var ampm = $"VBoxContainer/CenterContainer/TimeSplit/ampm";
onready var hour = $"VBoxContainer/CenterContainer/TimeSplit/Hour";
onready var minute = $"VBoxContainer/CenterContainer/TimeSplit/Minute";
onready var second = $"VBoxContainer/CenterContainer/TimeSplit/Second";

# Called when the node enters the scene tree for the first time.
func _ready():
  Variables.currentScene = Variables.CurrentSceneIs.STOPWATCH

  #print(Engine.time_scale) #How fast we want the program to run
  ampm.set_text("")
  second.set_text("")
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  timeValue += delta;
  var fps = Performance.get_monitor(Performance.TIME_FPS)
  var milSecDelta = fmod(timeValue, fps);

  var isAM = true;
  var currentHour = 0;
  var currentMinute = 0;
  var currentSecond = 0;
  var currentMilsec = 0;

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
      ampm.visible = true;
    else:
      ampm.set_text("p.m.")
      ampm.visible = true;
  else:
    pass

  hour.set_text(str(currentHour));
  minute.set_text(": " + str(currentMinute));
  pass
