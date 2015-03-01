require 'rails_helper'

describe "Mark item as uncompleted", type: :request do
  let(:item) { FactoryGirl.create(:item_completed) }

  let(:path) { "/api/v1/items/#{item.id}/uncomplete" }

  it "returns completed item resource" do
    post path

    expect(response).to have_http_status(200)
    expect(response).to match_response_schema('item')
    expect(json['completed_at']).to be_nil
  end

  context "when item is uncompleted" do
    let(:item_uncompleted) { FactoryGirl.create(:item) }
    let(:path) { "/api/v1/items/#{item.id}/uncomplete" }

    it "returns unchanged item resource" do
      post path

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('item')
      expect(json['completed_at']).to be_nil
    end
  end

  context "when item does not exists" do
    let(:path) { "/api/v1/items/0/uncomplete" }

    it "returns resource_not_found error" do
      post path

      # TODO: DRY - resource_not_found error
      expect(response).to have_http_status(404)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('resource_not_found')
    end
  end
end