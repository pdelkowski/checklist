require 'rails_helper'

describe "Get the checklist", type: :request do
  let(:checklist) { create(:checklist) }
  let(:path) { "/api/v1/checklists/#{checklist.id}" }

  context "when checklist exists" do
    it "returns checklist resource" do
      get path

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('checklist')
      expect(json['id']).to eq(checklist.id)
    end
  end

  context "when checklist not exists" do
    it "return resource not found error" do
      get "#{path}12435"

      expect(response).to have_http_status(404)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('resource_not_found')
    end
  end
end