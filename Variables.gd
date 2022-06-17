extends Node


enum CurrentSceneIs { ALARM, CLOCK, TIMER, STOPWATCH }
var currentScene = null
var defaultScene = CurrentSceneIs.STOPWATCH

var showSettings = false;

# Clock
var showSeconds = false;
var use24hour = false;

# Stopwatch
var stopwatchRun;
var stopwatchLap = [];
var stopwatchFlip = true;
var stopwatchReset;
