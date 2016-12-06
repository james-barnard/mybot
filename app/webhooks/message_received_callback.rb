class MessageReceivedCallback < MessageQuickly::Callback

  def self.webhook_name
    :messages
  end

  def initialize(event, json)
    super
  end

  def run
    coordinates = ''
    if json['entry'].first['messaging'].first['message']['attachments'].present?
      coordinates = json['entry'].first['messaging'].first['message']['attachments'].first['payload']['coordinates'].inspect
  	end
    user_id = json['entry'].first['messaging'].first['sender']['id']
    user_info = MessageQuickly::Api::UserProfile.find(user_id)

    puts "=========="
    puts user_info.inspect
    puts "=========="
    
    recipient = MessageQuickly::Messaging::Recipient.new(id: user_id)

    delivery = MessageQuickly::Api::Messages.create(recipient) do |message|
      if coordinates == ''
        message.text = 'Welcome, Please Share Your Location'
      else
        message.text = 'We Have Got Your Location, Thank You very Much'
      end
    end
    return {user_info: user_info, user_id: user_id, coordinates: coordinates}
  end

end