extends Node


enum CurrentSceneIs { ALARM, CLOCK, TIMER, STOPWATCH }
var currentScene = null
var defaultScene = CurrentSceneIs.CLOCK
var switchScene = false

var showSettings = false;

enum SwipeDirection { UP, DOWN, LEFT, RIGHT }
var swipeDirection = null

# Clock
var showSeconds = false;
var use24hour = false;

# Stopwatch
var stopwatchRun;       # true/false
var stopwatchLap := Array([]);
var stopwatchFlip;      # true/false
var stopwatchReset;     # true/false

# Timer
var setTimer;           # true/false
var timerRun;           # true/false
var resetTimer;         # true/false
var timeLeft;           # Dictionary
