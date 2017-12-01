require 'rails_helper'

RSpec.describe "AcademicSessions", type: :request do
  describe "GET /academic_sessions" do
    before do
      @academic_session = FactoryBot.create(:academic_session)
      @academic_sessions = FactoryBot.create_list(:random_academic_session, 4)
      @app = Doorkeeper::Application.create!(name: "MyApp", redirect_uri: "https://app.com") 
      @token = Doorkeeper::AccessToken.create! application_id: @app.id
      @url = '/ims/oneroster/v1p1/academicSessions'
    end
    it 'token less' do
      get @url
      expect(response).to have_http_status(401)
    end
    it 'invalid token' do
      get @url + '?access_token=123456'
      expect(response).to have_http_status(401)
    end
    it 'valid token' do
      get @url + '?access_token=' + @token.token
      @json = JSON.parse(response.body)
      #puts @json.to_s
      expect(response).to have_http_status(200)
    end
    it 'get with sourcedId' do
      get @url + '/' + @academic_session.sourcedId + '?access_token=' + @token.token
      @json = JSON.parse(response.body)
      #puts @json.to_s
      expect(response).to have_http_status(200)
    end
  end
end
