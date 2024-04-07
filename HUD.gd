# Citation: https://www.1001fonts.com/manaspace-font.html
# Citation: https://www.1001fonts.com/karmatic-arcade-font.html

extends CanvasLayer

signal start_game

func show_message(text1, text2):
	$Message1.text = text1
	$Message2.text = text2
	$Message1.show()
	$Message2.show()

func show_game_begin():
	$TitleLabel.show()
	show_message("Welcome", "Press Start to Begin...")
	$StartButton.show()

func show_level_won(level):
	show_message("Level Completed!", "Press Start to Begin Level " + str(level))
	$StartButton.show()

func show_level_over(life, level):
	show_message("Lives Remaining: " + str(life) + "/3", "Press Start to Begin Level " + str(level))
	$StartButton.show()

func show_game_over():
	show_message("Game Over!", "Press Start to Try Again...")
	$StartButton.show()

func show_game_won():
	show_message("You Won!", "Press Start to Begin New Game…")
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	$TitleLabel.hide()
	$Message1.hide()
	$Message2.hide()
	start_game.emit()
