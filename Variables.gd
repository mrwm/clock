extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var showSeconds = false;
var use24hour = false;

const SCENES = [ "clock", "timer", "stopwatch", "alarm" ]
var currentScene = SCENES[0]
