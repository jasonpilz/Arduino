require 'arduino_firmata'
require 'net/http'
require 'pry'

arduino = ArduinoFirmata.connect

num_samples = 10.0

loop do
  sum = 0.0
  sample_count = 0

  while sample_count < num_samples
    sum += arduino.analog_read(2)
    sample_count += 1
    sleep(1)
  end

  # Calibrated to RPINO Black 5v ref
  voltage = sum.to_f / (num_samples * 5.15) / 1024.0

  puts "#{voltage * 287.7} Volts"

  sleep(10)
end
