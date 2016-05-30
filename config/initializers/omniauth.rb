OmniAuth.config.logger = Rails.logger

OmniAuth.config.full_host = Rails.env.production? ? 'https://blk-box.herokuapp.com' : 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
  {
    :name => "google",
    :scope => "email, profile, plus.me, http://gdata.youtube.com",
    :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 50
  },
  {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end


# https://www.googleapis.com/auth/plus.login	Know the list of people in your circles, your age range, and language
# https://www.googleapis.com/auth/plus.me	Know who you are on Google
# https://www.googleapis.com/auth/userinfo.email	View your email address
# https://www.googleapis.com/auth/userinfo.profile	View your basic profile info
