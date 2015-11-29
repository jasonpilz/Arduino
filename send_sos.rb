require 'arduino_firmata'

arduino = ArduinoFirmata.connect

# SOS
loop do
  puts "Starting SOS...."

  system "say", "S"
  3.times do
    arduino.digital_write 13, true
    sleep(0.2)
    arduino.digital_write 13, false
    sleep(0.2)
  end
  sleep(0.2)

  system "say", "O"
  3.times do
    arduino.digital_write 13, true
    sleep(0.8)
    arduino.digital_write 13, false
    sleep(0.8)
  end
  sleep(0.2)

  system "say", "S"
  3.times do
    arduino.digital_write 13, true
    sleep(0.2)
    arduino.digital_write 13, false
    sleep(0.2)
  end
  sleep(2)
  puts "Sent!\n\n"
end
