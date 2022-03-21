require 'net/http'

module Authentication
  class Facebook
    FACEBOOK_URL = 'https://graph.facebook.com/v3.0/'
    FACEBOOK_USER_FIELDS = 'id,email,name,first_name,last_name'

    def initialize(access_token)
      @access_token = access_token
    end

    def user!
      return if user_data.blank? || facebook_id.blank?
      
      User.find_by(facebook_id: facebook_id) || create_user!
    end

    private

    def create_user!
      User.create!(
        facebook_id: facebook_id,
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: Devise.friendly_token[0, 20]
      )
    end

    def user_data
      @user_data ||= begin
        response = Net::HTTP.get_response(request_uri)
        JSON.parse(response.body)
      end
    end

    def facebook_id
      user_data['id']
    end

    def email
      user_data['email']
    end

    def first_name
      user_data['first_name']
    end

    def last_name
      user_data['last_name']
    end

    def request_uri
      URI.parse("#{FACEBOOK_URL}me?access_token=#{@access_token}&fields=#{FACEBOOK_USER_FIELDS}")
    end
  end
end