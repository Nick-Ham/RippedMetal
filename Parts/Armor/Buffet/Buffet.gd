extends armor

onready var exhaust1 = $Buffet/Exhaust
onready var exhaust2 = $Buffet/Exhaust2

func destroy():
	.destroy()
	
	exhaust1.emitting = false
	exhaust2.emitting = false
