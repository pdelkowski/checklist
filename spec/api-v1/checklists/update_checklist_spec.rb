require 'rails_helper'

describe "Update checklist", type: :request do
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

  context "when name is empty" do
    it "returns validation error" do
      put path, { name: '' }

      expect(response).to have_http_status(422)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('validation_failed')

      expected_errors = { 'name' => ['required', 'too_short'] }
      expect(json['errors']).to eq(expected_errors)
    end
  end

  context "when name is too short" do
    it "returns validation error" do
      put path, { name: 'a' }

      expect(response).to have_http_status(422)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('validation_failed')

      expected_errors = { 'name' => ['too_short'] }
      expect(json['errors']).to eq(expected_errors)
    end
  end

  context "with too long name" do
    it "returns validation error" do
      put path, { name: 'This is checklist name' * 20 }

      expect(response).to have_http_status(422)
      expect(response).to match_response_schema('error')

      expect(json['error_code']).to eq('validation_failed')
      expected_errors = {
          'name' => ['too_long']
      }
      expect(json['errors']).to eq(expected_errors)
    end
  end
end