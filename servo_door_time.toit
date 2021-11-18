import servo
import gpio

main:
  servo_motor_pin := gpio.Pin 25 --output
  servo_motor := servo.Motor servo_motor_pin

  now := Time.now
  local := now.local
  opening := local.with --h=17 --m=33
  closing := local.with --h=17 --m=34

  while true:

    if opening.time < now < closing.time:
      servo_motor.degrees = 50
      sleep --ms=2000 // Wait for the door to open.
      print "Door opened, will close at: $closing"
    else:
      servo_motor.degrees = -90
      sleep --ms=2000 // Wait for the door to close.
      print "Door closed, will open at: $opening"
