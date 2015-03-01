require 'rails_helper'

describe "Update checklist item", type: :request do
  let(:item) { FactoryGirl.create(:item) }
  let(:data) { { description: 'Update item description' } }

  let(:path) { "/api/v1/items/#{item.id}" }
  let(:path_404) { "/api/v1/items/0" }

  context "with valid data" do
    it "returns item resource with updated data" do
      put path, data

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('item')
      expect(json['id']).to eq(item.id)
      expect(json['updated_at']).to_not eq(item.updated_at)
    end
  end

  context "when description is empty" do
    it "returns validation failed error" do
      data[:description] = ''
      put path, data

      # TODO: DRY - validation_failed error
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
      put path, data

      # TODO: DRY - validation_failed error
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
      put path, data

      # TODO: DRY - validation_failed error
      expect(response).to have_http_status(422)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('validation_failed')

      expected_errors = { 'description' => ['too_long'] }
      expect(json['errors']).to eq(expected_errors)
    end
  end

  context "when item not exists" do
    it "returns not found error" do
      put path_404, data

      # TODO: DRY - resource_not_found error
      expect(response).to have_http_status(404)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('resource_not_found')
    end
  end
end