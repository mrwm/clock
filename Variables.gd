extends Node


enum CurrentSceneIs { ALARM, CLOCK, TIMER, STOPWATCH }
var currentScene = null
var defaultScene = CurrentSceneIs.STOPWATCH

var showSettings = false;

# Clock
var showSeconds = false;
var use24hour = false;

# Stopwatch
var stopwatchRun;       # true/false
var stopwatchLap = [];
var stopwatchFlip;      # true/false
var stopwatchReset;     # true/false
