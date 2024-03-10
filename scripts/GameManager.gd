extends Node
@onready var points_lable = %PointsLable
var points = 0

func AddPoint():
	points += 1
	points_lable.text = "Points: " + str(points)
