require 'arduino_firmata'

arduino = ArduinoFirmata.connect

names = %w(Ella Ada Emery bobba dahdah Hunna)

loop do
  temp = arduino.analog_read(1) * 100 * 5 / 1024
  puts temp

  if temp < 60
    system "say", "Temperature reading is #{temp}...are you cold #{names.shuffle.sample}?"
  else
    system "say", "Temperature reading is #{temp} farenheit"
  end

  sleep(10)
end
