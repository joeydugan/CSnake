extends Node

@export var snake_scene : PackedScene

# game variables
var score : int
var game_started : bool = false

var cells : int = 40
var cell_size : int = 25

var old_data : Array
var snake_data : Array
var snake : Array

var start_pos = Vector2(18, 6)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var move_direction : Vector2
var can_move: bool

# level objectives
var flag1 : bool = false
var flag2 : bool = false
var flag3 : bool = false

var num1_pos = Vector2(12 * 25, 16 * 25)
var num2_pos = Vector2(18 * 25, 12 * 25)
var num3_pos = Vector2(24 * 25, 16 * 25)

var end_flag = false

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	
func new_game():
	score = 5000
	# $Hud.get_node("ScoreLabel").text = "SCORE: " + str(score)'
	get_tree().call_group("segments", "queue_free")
	move_direction = down
	can_move = true
	$num1.position = num1_pos
	$num2.position = num2_pos
	$num3.position = num3_pos
	$num1.visible = true
	$num2.visible = true
	$num3.visible = true
	flag1 = false
	flag2 = false
	flag3 = false
	generate_snake()
	
	
func generate_snake():
	old_data.clear()
	snake_data.clear()
	snake.clear()

	for i in range(3): # change this number to make the snake bigger!
		add_segment(start_pos + Vector2(i, 0))
		
func add_segment(pos):
	snake_data.append(pos)
	var SnakeSegment = snake_scene.instantiate()
	SnakeSegment.position = (pos * cell_size) + Vector2(0, cell_size)
	add_child(SnakeSegment)
	snake.append(SnakeSegment)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if end_flag == false:
		score -= delta/3
		$Panel/Label.text = str(score)
	move_snake()
	
func move_snake():
	if can_move:
		if Input.is_action_just_pressed("move_down") and move_direction != up:
			move_direction = down
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_up") and move_direction != down:
			move_direction = up
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_left") and move_direction != right:
			move_direction = left
			can_move = false
			if not game_started:
				start_game()
		if Input.is_action_just_pressed("move_right") and move_direction != left:
			move_direction = right
			can_move = false
			if not game_started:
				start_game()
			
func start_game():
	game_started = true
	$MoveTimer.start()

func _on_move_timer_timeout():
	can_move = true
	old_data = [] + snake_data
	snake_data[0] += move_direction
	for i in range(len(snake_data)):
		if i > 0:
			snake_data[i] = old_data[i - 1]
		snake[i].position = (snake_data[i] * cell_size) + Vector2(0, cell_size)
	check_out_of_bounds()
	check_self_eaten()
	check_num1()
	check_num2()
	check_num3()
	
func check_out_of_bounds():
	if snake_data[0].x < 0 or snake_data[0].x > cells - 1 or snake_data[0].y < 0 or snake_data[0].y > cells - 10:
		new_game()

	
func check_self_eaten():
	for i in range(1, len(snake_data)):
		if snake_data[0] == snake_data[i]:
			new_game()

func check_num1():
	if snake[0].position == num1_pos:
		flag1 = true
		$num1.visible = false
		
func check_num2():
	if snake[0].position == num2_pos and flag3:
		flag2 = true
		$num2.visible = false
		end_game()
		
func check_num3():
	if snake[0].position == num3_pos and flag1:
		flag3 = true
		$num3.visible = false

			
func end_game():
	
	$MoveTimer.stop()
	end_flag = true
	
	var final_score = score
	
	if SilentWolf.Auth.logged_in_player != null:
		SilentWolf.Scores.save_score(SilentWolf.Auth.logged_in_player, final_score, 'dfs1')
	
	
	var sw_result = await SilentWolf.Scores.get_score_position(final_score, 'dfs1').sw_get_position_complete
	var position = sw_result.position
	
	var sw_result2 = await SilentWolf.Scores.get_scores(0, "dfs1").sw_get_scores_complete
	var scores = sw_result2.scores
	
	print(position)
	print(scores)
	
	
	get_tree().change_scene_to_file("res://addons/silent_wolf/Scores/Leaderboard.tscn")

