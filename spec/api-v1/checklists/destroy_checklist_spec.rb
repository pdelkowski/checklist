require 'rails_helper'

describe "Destroy the checklist", type: :request do
  let(:checklist) { FactoryGirl.create(:checklist) }
  let(:path) { "/api/v1/checklists/#{checklist.id}" }

  context "when checklist exists" do
    it "it returns checklist resource" do
      delete path

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('checklist')
      expect(json['id']).to eq(checklist.id)
    end
  end

  context "when checklist not exists" do
    it "returns resource not found error" do
      delete "#{path}18934"

      expect(response).to have_http_status(404)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('resource_not_found')
    end
  end
end