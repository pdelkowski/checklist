require 'rails_helper'

describe "Mark item as completed", type: :request do
  let(:item) { FactoryGirl.create(:item) }
  let(:item_completed) { FactoryGirl.create(:item_completed) }

  let(:path) { "/api/v1/items/#{item.id}/complete" }
  let(:path_404) { "/api/v1/items/0/complete" }

  context "when item is not completed" do
    it "returns item resource" do
      post path

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('item')
      expect(json['completed_at']).to_not be_nil
    end
  end

  context "when item is completed already" do
    let(:path) { "/api/v1/items/#{item_completed.id}/complete" }

    it "returns unchanged item resource" do
      post path

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('item')

      # Make sure time is compared in the same format
      expected_time = Time.parse(json['completed_at']).strftime('%Y-%m-%dT%l:%M:%S%z')
      item_time = item_completed.completed_at.strftime('%Y-%m-%dT%l:%M:%S%z')
      expect(expected_time).to eq(item_time)
    end
  end

  context "when item does not exists" do
    it "returns response with resource_not_found error and status code 404" do
      post path_404

      # TODO: DRY - resource_not_found error
      expect(response).to have_http_status(404)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('resource_not_found')
    end
  end
end