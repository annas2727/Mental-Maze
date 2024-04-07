extends CanvasLayer


signal finished_read


var array = [#source: https://adaa.org/understanding-anxiety/facts-statistics
	"\"40 million adults are affected by anxiety disorders in the United States\" (ADAA).",
	"\"Nearly one-half of those diagnosed with depression are also diagnosed with an anxiety disorder\" (ADAA).",
	"\"Anxiety disorders develop from a complex set of risk factors, including genetics, brain chemistry, personality, and life events\" (ADAA).",
	#source: https://www.who.int/news-room/fact-sheets/detail/anxiety-disorders#:~:text=Key%20facts,onset%20during%20childhood%20or%20adolescence.
	"\"Anxiety disorders are the world's most common mental disorders\" (WHO).",
	"\"More women are affected by anxiety disorders than men\" (WHO).",
	"\"Symptoms of anxiety often have onset during childhood or adolescence\" (WHO).",
	"\"Approximately 1 in 4 people with anxiety disorders receive treatment for this condition\" (WHO).",
]


func hide_popup():
	$NextButton.hide()
	$Popup.hide()
	
func show_popup(index):
	$Popup.text = array[index]
	$Popup.show()
	await get_tree().create_timer(1.0).timeout
	$NextButton.show()


func _on_next_button_pressed():
	$NextButton.hide()
	$Popup.hide()
	finished_read.emit()
	
func _ready():
	hide_popup()
