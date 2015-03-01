require 'rails_helper'

describe "Create new checklist item", type: :request do
  let(:checklist) { FactoryGirl.create(:checklist) }
  let(:data) { { description: 'My checklist item' } }

  let(:path) { "/api/v1/checklists/#{checklist.id}/items" }
  let(:path_404) { "/api/v1/checklists/123394857/items" }

  context "with valid data" do
    it "returns item resource" do
      post path, data

      expect(response).to have_http_status(201)
      expect(response).to match_response_schema('item')
      expect(json['description']).to eq(data[:description])
    end
  end

  context "when description is empty" do
    it "returns validation failed error" do
      data[:description] = ''
      post path, data

      expect(response).to have_http_status(422)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('validation_failed')

      expected_errors = { 'description' => ['required', 'too_short'] }
      expect(json['errors']).to eq(expected_errors)
    end
  end

  context "when description is too short" do
    it "returns validation failed error" do
      data[:description] = 'a'
      post path, data

      expect(response).to have_http_status(422)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('validation_failed')

      expected_errors = { 'description' => ['too_short'] }
      expect(json['errors']).to eq(expected_errors)
    end
  end

  context "when description is too long" do
    it "returns validation failed error" do
      data[:description] = 'This is item description' * 20
      post path, data

      expect(response).to have_http_status(422)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('validation_failed')

      expected_errors = { 'description' => ['too_long'] }
      expect(json['errors']).to eq(expected_errors)
    end
  end

  context "when checklist not exists" do
    it "returns not found error" do
      post path_404, {}

      expect(response).to have_http_status(404)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('resource_not_found')
    end
  end
end