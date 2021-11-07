import servo
import gpio

main:
  servo_motor_pin := gpio.Pin 25 --output
  servo_motor := servo.Motor servo_motor_pin

  // Opening and closing times in UTC timezone
  opening_time := "17:33:00"
  closing_time := "17:34:00"

  // Convert string to a UTC time instance
  opening_time_utc := Time.from_string "$(Time.now.stringify[0..10])T$(opening_time)Z"
  closing_time_utc := Time.from_string "$(Time.now.stringify[0..10])T$(closing_time)Z"

  while true:

    if closing_time_utc > Time.now > opening_time_utc:
      servo_motor.degrees = 50
      sleep --ms=2000 // Wait for the door to open
      print "Door opened, will close at: $closing_time UTC"
    else:
      servo_motor.degrees = -90
      sleep --ms=2000 // Wait for the door to close
      print "Door closed, will open at: $opening_time UTC"
