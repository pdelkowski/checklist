require 'rails_helper'

describe "Updating checklist", type: :request do
  let(:checklist) { FactoryGirl.create(:checklist) }
  let(:path) { "/api/v1/checklists/#{checklist.id}" }

  context "with valid data" do
    it "returns updated checklist resource" do
      data = { name: 'New name' }
      put path, data

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('checklist')
      expect(json['name']).to eq(data[:name])
    end
  end

  context "when checklist not exists" do
    it "returns not found error" do
      put '/api/v1/checklists/100'

      expect(response).to have_http_status(404)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('resource_not_found')
    end
  end
end