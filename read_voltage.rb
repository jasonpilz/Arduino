require 'arduino_firmata'
require 'net/http'
require 'pry'

arduino = ArduinoFirmata.connect

# 5v ref calibrated from RPINO black board
v_ref = 5.15
# These resistor values may need calibrating based on tolerance
r1 = 100000.0
r2 = 10000.0

max_input = (v_ref / (r2 / (r1 + r2)))

puts "Maximum input voltage: #{max_input} V"

loop do
  v = (arduino.analog_read(2) * v_ref) / 1024.0

  # Convert the voltage divider circuit
  # v2 = v / (r2 / (r1 + r2))
  v2 = v * 11.15

  puts "#{v2} Volts"

  sleep(5)
end
