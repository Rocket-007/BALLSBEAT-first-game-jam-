extends Resource

export var player_name = ""
export var best_score = 0
export var scores = []

var savePath = "user://savegame1.tres"
func savegame():
	ResourceSaver.save(savePath, self)
	
func loadgame():
	if ResourceLoader.exists(savePath):
		return load(savePath)
	return null
