extends Node

const WEAPON_RES = "res://mods/RealGunAttachmentNames/Resources/weapon_resources.gd"
const ATTACH_RES = "res://mods/RealGunAttachmentNames/Resources/attachment_resources.gd"
const ATTACH_REP_NAMES = "res://mods/RealGunAttachmentNames/Resources/repair_names_resources.gd"

func _ready():
    apply_list(WEAPON_RES)
    apply_list(ATTACH_RES)
    apply_list(ATTACH_REP_NAMES)

    for i in range(20):
        await get_tree().process_frame
    apply_list(ATTACH_REP_NAMES)

func apply_list(path: String):
    var script = ResourceLoader.load(path, "", ResourceLoader.CACHE_MODE_IGNORE)
    if script is Script:
        script = script.new()

    var list_data = script.list

    for entry in list_data:
        if entry.has("rename"):
            rename(entry["path"], entry["rename"])
        if entry.has("rename_mag"):
            rename_mag(entry["path"], entry["rename_mag"])
        if entry.has("hover"):
            rename_hover(entry["path"], entry["hover"])


func rename(path: String, new_name: String):
    var r = load(path)
    if r:
        r.name = new_name
        r.inventory = new_name
        r.rotated = new_name
        r.equipment = new_name
        r.display = new_name

func rename_mag(path: String, new_name: String):
    var r = load(path)
    if r:
        r.name = new_name

func rename_hover(path: String, new_name):
    var r = load(path)
    if r:
        r.name = new_name

func repair(path: String, new_name):
    var r = load(path)
    if r:
        r.name = new_name
