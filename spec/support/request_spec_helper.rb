module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def confirm_and_login_user(user)
    post '/api/v1/sessions', params: { email: user.email, password: user.password }
    json['token']
  end

  def json_data
    json['data']
  end
end