require 'net/http'

module Authentication
  class Google
    GOOGLE_URL = 'https://www.googleapis.com/oauth2/v4/token'
    GOOGLE_USER_FIELDS = 'userinfo.email, userinfo.profile'

    def initialize(access_token)
      @access_token = access_token
    end

    def user!
      return if user_data.blank? || google_id.blank?

      User.find_by(google_id: google_id) || create_user!
    end

    private

    def create_user!
      User.create!(
        google_id: google_id,
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
      URI.parse("#{GOOGLE_URL}me?access_token=#{@access_token}&fields=#{GOOGLE_USER_FIELDS}")
    end
  end
end