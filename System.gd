extends Node


################
# Touch events #
################

# Figure out the swipe direction
var initialPoint = Vector2(0,0);
var secondPoint = Vector2(0,0);
# The difference allowed for directional swipe
const vectorSensitivity = Vector2(200, 200)

func _input(event):
  if (event is InputEventScreenTouch) and (event.pressed):
      initialPoint = event.position;

  if (event is InputEventScreenTouch) and (!event.pressed):
    secondPoint = event.position;
    calculateDirection(initialPoint, secondPoint)

func calculateDirection(firstPt, secondPt):
  var deviation = Vector2(int(abs(firstPt.x - secondPt.x)), \
                          int(abs(firstPt.y - secondPt.y)));

  # Check which vector is dominant (X or Y)
  if (deviation.x > deviation.y):
  # Check direction of X
    if (firstPt.x > secondPt.x) and (deviation.x > vectorSensitivity.x):
      #print("initial larger x <-" + str(deviation.x))
      pass
    elif (firstPt.x < secondPt.x) and (deviation.x > vectorSensitivity.x):
      #print("initial smaller x ->" + str(deviation.x))
      pass
  else:
    # Check direction of Y
    if (firstPt.y > secondPt.y) and (deviation.y > vectorSensitivity.y):
      # TODO: Show menu on swipe up
      Variables.showSettings = true
      #print("initial larger y U " + str(deviation.y))
      pass
    elif (firstPt.y < secondPt.y) and (deviation.y > vectorSensitivity.y):
      Variables.showSettings = false
      #print("initial smaller y D " + str(deviation.y))
      pass
    else:
      #print("no change in xy: " + str(deviation))
      pass
