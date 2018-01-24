require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "GET /courses" do
    before do
      @course = FactoryBot.create(:course)
      @courses = FactoryBot.create_list(:random_course, 10)
      @url = '/ims/oneroster/v1p1/courses'
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
      get @url + '/' + @courses[0].sourcedId + '?access_token=' + @token.token
      @json = JSON.parse(response.body)
      #puts @json.to_s
      expect(response).to have_http_status(200)
    end
  end
end
