extends Node

var file_name = "user://savegame.save"
var data = {} # key value pairs where key is the scene instances' `name`
var player_stats = PlayerStats

var ids_to_paths_map = {
    "577775b5-2a3e-4d30-88fa-11e154898632": "res://Levels/Level1/Level1.tscn",
    "020dcb72-7a88-4796-91fd-ee74937acc8b": "res://Levels/Level2/Level2.tscn",
    "220fb8b5-bda4-4b76-9dc3-735e87723f4c": "res://Levels/Playground.tscn",
}

# Important: call set_save_data() before running this
func save() -> void:
    var file = File.new()
    file.open(file_name, File.WRITE)
    file.seek(0)
    file.store_var(data, true) # without true, data is not actually stored, causing a null pointer on load... (at least not without further setup)
    file.close()

func set_save_data(levelId: String) -> void:
    data = {
        "player": {
            "level_id": levelId,
            "health": player_stats.health,
            "max_health": player_stats.max_health,
            "keys": player_stats.keys,
        }
    }

func has_save_file() -> bool:
    var file = File.new()
    return file.file_exists(file_name)
        
# Important: call has_save_file() before this
func load():
    var file = File.new()
    file.open(file_name, File.READ)
    data = file.get_var()
    print(data)
    file.close()
    return data
