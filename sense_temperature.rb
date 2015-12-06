require 'arduino_firmata'
require 'net/http'

arduino = ArduinoFirmata.connect

public_key = ENV['SF_TEMP_PUBLIC_KEY']
private_key = ENV['SF_TEMP_PRIVATE_KEY']

loop do
  temp = sprintf "%.2f", arduino.analog_read(1) * (100 * 5 / 1024.0)
  time = Time.now.strftime("%I:%M%p")

  uri = URI("http://data.sparkfun.com/input/#{public_key}?private_key=#{private_key}&temp=#{temp}")
  response = Net::HTTP.get(uri)

  if response.include?("success")
    puts "Temperature reading of #{temp} degrees uploaded to data stream at #{time}"
  else
    puts "Error uploading temp reading"
  end

  sleep(60 * 30)
end

# system "say", "Temperature reading is #{temp} farenheit"
