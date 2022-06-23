extends Node


# Mode scenes
#var AlarmScene : PackedScene = load("res://Alarm.tscn")
var ClockScene : PackedScene = load("res://Clock.tscn")
#var TimerScene : PackedScene = load("res://Timer.tscn")
var StopwatchScene : PackedScene = load("res://Stopwatch.tscn")

# Only load the screen once
var isSceneLoaded = false

var screenDimentions := Vector2(0,0);

# Called when the node enters the scene tree for the first time.
func _ready():
  Variables.currentScene = Variables.defaultScene
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  screenDimentions = self.rect_size

  var clockScene = ClockScene.instance()
  var stopwatchScene = StopwatchScene.instance()

  var Menu : PackedScene = load("res://Menu.tscn")
  var menu = Menu.instance()

  if (!isSceneLoaded):
    #match Variables.currentScene:
    #  Variables.CurrentSceneIs.ALARM:
    #    #var AlarmScene = AlarmScene.instance()
    #    #add_child(alarmScene)
    #    pass

    #  Variables.CurrentSceneIs.CLOCK:
    #    var clockScene = ClockScene.instance()
    #    add_child(clockScene)
    #    clockScene.rect_size = screenDimentions
    #    pass

    #  Variables.CurrentSceneIs.TIMER:
    #    #var timerScene = TimerScene.instance()
    #    #add_child(timerScene)
    #    pass

    #  Variables.CurrentSceneIs.STOPWATCH:
    #    var stopwatchScene = StopwatchScene.instance()
    #    #stopwatchScene.rect_size = screenDimentions;
    #    add_child(stopwatchScene)
    #    pass

    # Clock
    add_child(clockScene)
    clockScene.rect_size = screenDimentions

    # Stopwatch
    add_child(stopwatchScene)
    stopwatchScene.rect_size = screenDimentions;
    stopwatchScene.visible = false;

    # Menu
    add_child(menu)
    isSceneLoaded = true

  if (Variables.swipeDirection == Variables.SwipeDirection.UP):
    print("up")
    pass
  if (Variables.swipeDirection == Variables.SwipeDirection.DOWN):
    print("down")
    pass
  if (Variables.swipeDirection == Variables.SwipeDirection.LEFT):
    Variables.currentScene = Variables.CurrentSceneIs.STOPWATCH
    clockScene.visible = false
    stopwatchScene.visible = true
    Variables.switchScene = true
    print("left")
    pass
  if (Variables.swipeDirection == Variables.SwipeDirection.RIGHT):
    Variables.currentScene = Variables.CurrentSceneIs.CLOCK
    clockScene.visible = true
    stopwatchScene.visible = false
    Variables.switchScene = true
    print("right")
    pass
  Variables.swipeDirection = null
  pass
