require 'rails_helper'

RSpec.describe "Orgs", type: :request do
  describe "GET /orgss" do
    before do
      @org = FactoryBot.create(:org)
      @url = '/ims/oneroster/v1p1/orgs'
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
      get @url + '/' + @org.sourcedId + '?access_token=' + @token.token
      @json = JSON.parse(response.body)
      #puts @json.to_s
      expect(response).to have_http_status(200)
    end
  end
end
