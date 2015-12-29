require 'arduino_firmata'
require 'slack-ruby-client'
require 'pry'
require 'pry-state'

arduino = ArduinoFirmata.connect

Slack.configure do |config|
  config.token = ENV['MOTIONBOT_API_TOKEN']
end

client = Slack::Web::Client.new
response = client.auth_test

if response["ok"] == true
  puts "#{response["user"]} authorized and connected to #{response["team"]}"
else
  puts "Error authorizing with slack"
end

led_pin = 13
pir_pin = 8

arduino.pin_mode pir_pin, ArduinoFirmata::INPUT

loop do
  reading = arduino.digital_read(pir_pin)

  if reading == true
    arduino.digital_write(led_pin, true)

    client.chat_postMessage(channel: "#command_center",
                            text: "Motion detected!",
                            as_user: true)

    arduino.digital_write(led_pin, false)
    sleep(30)
  end

  arduino.digital_write(lid_pin, false)
end
