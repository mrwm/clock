extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timeValue = null;
var oldMinute = -1;
var requ = null;
var showSeconds = false;

onready var timeText = $"VBoxContainer/RichTextLabel";
onready var ckbx = $"VBoxContainer/CheckButton";

# Called when the node enters the scene tree for the first time.
func _ready():
  #print(Engine.time_scale)
  timeText.set_text(str(timeValue));
  pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  timeValue = OS.get_time();

  if (showSeconds):
    timeText.set_text(str(timeValue));
  else:
    if (timeValue.minute > oldMinute):
      timeText.set_text(str(timeValue));
  oldMinute = timeValue.minute;
  pass

func updateTime():
  timeText.set_text(str(timeValue));
  pass

func _on_Button_pressed():
  updateTime()
  pass # Replace with function body.




func _on_CheckButton_toggled(button_pressed):
  showSeconds = button_pressed;
  pass # Replace with function body.
