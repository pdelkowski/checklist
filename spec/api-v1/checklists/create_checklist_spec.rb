require 'rails_helper'

describe "Creating the checklist", type: :request do
  let(:path) { '/api/v1/checklists' }

  context "with valid data" do
    it "returns newly created checklist resource" do
      data = { name: 'My checklist' }
      post path, data

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('checklist')
      expect(json['name']).to eq(data[:name])
      expect(json['completed_at']).to eq(nil)
    end
  end

  context "with empty name attribute" do
    it "returns validation error" do
      post path, { name: '' }

      expect(response).to have_http_status(422)
      expect(response).to match_response_schema('error')

      expect(json['error_code']).to eq('validation_failed')
      expected_errors = {
          'name' => ['required', 'too_short']
      }
      expect(json['errors']).to eq(expected_errors)
    end
  end

  context "with too short name attribute" do
    it "returns validation error" do
      post path, { name: 'a' }

      expect(response).to have_http_status(422)
      expect(response).to match_response_schema('error')

      expect(json['error_code']).to eq('validation_failed')
      expected_errors = {
          'name' => ['too_short']
      }
      expect(json['errors']).to eq(expected_errors)
    end
  end
end