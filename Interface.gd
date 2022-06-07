extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = OS.get_time();
var oldMinute = -1;
var timeText = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
  print(time)
  print(time.hour)
  print(Engine.time_scale)
  $"AspectRatioContainer/VBoxContainer/RichTextLabel".set_text(str(time));
  pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  time = OS.get_time();
  if (time.minute > oldMinute):
    $"AspectRatioContainer/VBoxContainer/RichTextLabel".set_text(str(time));
  oldMinute = time.minute;
  pass

func _updateTime():
  $"AspectRatioContainer/VBoxContainer/RichTextLabel".set_text(str(time));
  pass

