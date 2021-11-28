extends RayCast2D

onready var parent = get_parent()
onready var laser_beam := $Line2D
onready var tween := $Tween
onready var casting_particles := $CastingParticles
onready var collision_particles := $CollisionParticles
onready var beam_particles := $BeamParticles

var is_casting := false setget set_is_casting

func _ready() -> void:
	set_physics_process(false)
	laser_beam.points[1] = Vector2.ZERO
	cast_to = Vector2(parent._laser_distance * 20,0)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		self.is_casting = event.pressed


func _physics_process(delta: float) -> void:
	var cast_point := cast_to
	force_raycast_update()
	
	collision_particles.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		collision_particles.global_position = get_collision_normal().angle()
		collision_particles.position = cast_point
	
	laser_beam.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5


func _fire_laser():
	self.is_casting


func set_is_casting(cast : bool) -> void:
	is_casting = cast
	set_physics_process(is_casting)
	
	beam_particles.emitting = is_casting
	casting_particles.emitting = is_casting
	if is_casting:
		appear()
	else:
		collision_particles.emitting = false
		disappear()
	set_physics_process(is_casting)


func appear() -> void:
	tween.stop_all()
	tween.interpolate_property(laser_beam, "width", 0, 1.0, 0.2)
	tween.start()


func disappear() -> void:
	tween.stop_all()
	tween.interpolate_property(laser_beam, "width", 1.0, 0, 0.2)
	tween.start()
