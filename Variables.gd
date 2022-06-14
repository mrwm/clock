extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var showSeconds = false;
var use24hour = false;
var showSettings = false;

enum CurrentSceneIs { CLOCK, TIMER, STOPWATCH, ALARM }
var currentScene = null
