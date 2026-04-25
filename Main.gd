extends Node

const WEAPON_RES = "res://RealGunAndAttachmentNames/Resources/weapon_resources.gd"
const ATTACH_RES = "res://RealGunAndAttachmentNames/Resources/attachment_resources.gd"
const ATTACH_REP_NAMES = "res://RealGunAndAttachmentNames/Resources/repair_names_resources.gd"

var _lib = null

func _ready():
    if Engine.has_meta("RTVModLib"):
        var lib = Engine.get_meta("RTVModLib")
        if lib._is_ready:
            _on_lib_ready()
        else:
            lib.frameworks_ready.connect(_on_lib_ready)

func _on_lib_ready():
    _lib = Engine.get_meta("RTVModLib")
    apply_list(WEAPON_RES)
    apply_list(ATTACH_RES)
    apply_list(ATTACH_REP_NAMES)
    print("Real Gun & Attachment Names: Loaded")

func apply_list(path: String):
    var script = ResourceLoader.load(path, "", ResourceLoader.CACHE_MODE_IGNORE)
    if script is Script:
        script = script.new()

    for entry in script.list:
        var res_path: String = entry["path"]

        if entry.has("rename"):
            var new_name: String = entry["rename"]
            _lib.patch(_lib.Registry.RESOURCES, res_path, {
                "name": new_name,
                "inventory": new_name,
                "rotated": new_name,
                "equipment": new_name,
                "display": new_name
            })

        if entry.has("rename_mag"):
            _lib.patch(_lib.Registry.RESOURCES, res_path, {"name": entry["rename_mag"]})

        if entry.has("rename_hover"):
            _lib.patch(_lib.Registry.RESOURCES, res_path, {"name": entry["rename_hover"]})

        if entry.has("rename_repair"):
            _lib.patch(_lib.Registry.RESOURCES, res_path, {"name": entry["rename_repair"]})
