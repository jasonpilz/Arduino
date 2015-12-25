require 'arduino_firmata'
require 'twilio-ruby'

TWILIO_ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
TWILIO_AUTH_TOKEN  = ENV['TWILIO_AUTH_TOKEN']

@twilio = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN

twilio_number = ENV['TWILIO_NUMBER']
my_number     = ENV['MY_NUMBER']

arduino = ArduinoFirmata.connect

led_pin = 13
pir_pin = 8

arduino.pin_mode pir_pin, ArduinoFirmata::INPUT

loop do
  reading = arduino.digital_read(pir_pin)

  if reading == true
    arduino.digital_write(13, true)
    system "say", "motion detected!"

    @twilio.messages.create(
      from: twilio_number,
      to: my_number,
      body: "Motion Detected!"
    )

    arduino.digital_write(13, false)
    sleep(30)
  end

  arduino.digital_write(13, false)
end
