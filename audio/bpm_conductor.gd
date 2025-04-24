extends AudioStreamPlayer

@export var bpm: int
@export var measures: int


# Song position var
var song_pos: float = 0.0
var song_pos_beat: int = 1
var sec_per_beat: float = 60.0 / bpm
var last_beat: int = 0
var beat_before_start: int = 0
var measure: int = 1

signal beat_signal(pos: int)
signal measure_signal(pos: int)

# Determining beat pos relative to event
var closest: int = 0
var time_off_beat: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sec_per_beat = 60.0 / bpm


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if playing:
		song_pos = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_pos -= AudioServer.get_output_latency()
		song_pos_beat = int(floor(song_pos / sec_per_beat)) + beat_before_start
		_report_beat()

func _report_beat() -> void:
	if last_beat < song_pos_beat:
		if measure > measures:
			measure = 1
		
		beat_signal.emit(song_pos_beat)
		measure_signal.emit(measure)
		
		last_beat = song_pos_beat
		measure += 1

func closest_beat(nth: int) -> Vector2:
	closest = int(round((song_pos / sec_per_beat) / nth) * nth)
	time_off_beat = abs(closest * sec_per_beat - song_pos)
	
	return Vector2(closest, time_off_beat)

func play_from_beat() -> void:
	play()

func _play_with_beat_offset(num: int) -> void:
	beat_before_start = num
	$BgmTimer.wait_time = sec_per_beat
	$BgmTimer.start()

func _on_start_timer_timeout() -> void:
	song_pos_beat += 1
	
	if song_pos_beat < beat_before_start - 1:
		$BgmTimer.start()
	elif song_pos_beat == beat_before_start - 1:
		$BgmTimer.wait_time = $BgmTimer.wait_time - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency())
		$BgmTimer.start()
	else:
		play()
		$BgmTimer.stop()
	
	_report_beat()
