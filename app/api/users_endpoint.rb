class UsersEndpoint < Api
  format :json
  default_format :json

  namespace :users do

    desc 'user registration api'
    params do
      requires :email, type: String, desc: 'Email Address', documentation: {param_type: 'body'}
      requires :password, type: String, desc: 'Password', documentation: {param_type: 'body'}
    end
    post '/registration' do
      user = User.new(params)
      if user.save!
        token = SecureRandom.urlsafe_base64(nil, false)
        user.update(confirmation_token: token)
        { status: true, 
          data: user.as_json(except: [:created_at, :updated_at]), 
          message: 'Registration successful',
          confirmation_url: "https://localhost:3000/api/users/confirm?confirmation_token=#{token}"
        }
      end
    end

    desc 'Confirm the registered user after generating the confirmation token.'
    get '/confirm' do
      user = User.find_by(confirmation_token: params[:confirmation_token])
      if user && user.update(confirmation_token: nil)
        {
          status: true,
          message: "User Confirmed"
        }
      else
        error!({message:'Email not confirmed', error:'401' },nil,nil)
      end
    end

    desc 'login api after checking the validity of password and that the confirmation token is nil and adding auth token'
    post '/login' do
      user = User.find_by(email: params[:email])
      if user.valid_password?(params[:password]) && user.confirmation_token.nil?
        random_token = SecureRandom.urlsafe_base64(nil, false)
        user.update(auth_token: random_token)
        {
          status: true,
          message: 'User signed and confirmed.',
          data: random_token
        }
      else
        error!({message:'Please confirm your email', error:'401' },nil,nil)
      end
    end

  end
end
