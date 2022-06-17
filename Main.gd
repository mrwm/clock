extends Node


# Mode scenes
#var AlarmScene : PackedScene = load("res://Alarm.tscn")
var ClockScene : PackedScene = load("res://Clock.tscn")
#var TimerScene : PackedScene = load("res://Timer.tscn")
var StopwatchScene : PackedScene = load("res://Stopwatch.tscn")

# only load the screen once
var isSceneLoaded = false

# Called when the node enters the scene tree for the first time.
func _ready():
  Variables.currentScene = Variables.defaultScene
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  if (!isSceneLoaded):
    match Variables.currentScene:
      Variables.CurrentSceneIs.ALARM:
        #var AlarmScene = AlarmScene.instance()
        #add_child(alarmScene)
        pass

      Variables.CurrentSceneIs.CLOCK:
        var clockScene = ClockScene.instance()
        add_child(clockScene)
        pass

      Variables.CurrentSceneIs.TIMER:
        #var timerScene = TimerScene.instance()
        #add_child(timerScene)
        pass

      Variables.CurrentSceneIs.STOPWATCH:
        var stopwatchScene = StopwatchScene.instance()
        add_child(stopwatchScene)
        pass
    isSceneLoaded = true
  pass
