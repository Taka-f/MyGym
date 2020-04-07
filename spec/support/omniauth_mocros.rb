module OmniauthMacros
  def facebook_mock
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      uid: '1234567890',
      info: {
        name: 'mockuser',
        email: 'sample@test.com',
        image: 'http://mock_image_url.com'
      },
      credentials: {
        token: 'hogepiyo1234'
      }
    })
  end
  
  
  def twitter_mock
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      "provider" => "twitter",
      "uid" => "123456",
      "info" => {
        "name" => "Mock User",
        "image" => "http://mock_image_url.com",
        "location" => "",
        "email" => "mock@example.com",
        "urls" => {
          "Twitter" => "https://twitter.com/MockUser1234",
          "Website" => ""
        }
      },
      "credentials" => {
        "token" => "mock_credentails_token",
        "secret" => "mock_credentails_secret"
      },
      "extra" => {
        "raw_info" => {
          "name" => "Mock User",
          "id" => "123456",
          "followers_count" => 0,
          "friends_count" => 0,
          "statuses_count" => 0
        }
      }
    })
  end
end