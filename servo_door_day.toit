import servo
import gpio
import solar_position show *

MUMBAI_LONGITUDE ::= 73.077787
MUMBAI_LATITUDE ::= 19.047505

main:
  servo_motor_pin := gpio.Pin 25 --output
  servo_motor := servo.Motor servo_motor_pin

  now := Time.now
  today := sunrise_sunset now MUMBAI_LONGITUDE MUMBAI_LATITUDE

  if today.sunset < now < today.sunrise:
    servo_motor.degrees = 50
    sleep --ms=2000 // Wait for the door to open.
    print "Door opened, will close at: $today.sunset UTC"
  else:
    servo_motor.degrees = -90
    sleep --ms=2000 // Wait for the door to close.
    print "Door closed, will open at: $today.sunrise UTC"
