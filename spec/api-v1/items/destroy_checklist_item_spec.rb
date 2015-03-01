require 'rails_helper'

describe "Destroy checklist item", type: :request do
  let(:item) { FactoryGirl.create(:item) }

  let(:path) { "/api/v1/items/#{item.id}" }
  let(:path_404) { "/api/v1/items/0" }

  it "responds with destroyed item and 200 status code" do
    delete path

    expect(response).to have_http_status(200)
    expect(response).to match_response_schema('item')
    expect(json['id']).to eq(item.id)
  end

  context "when item not exists" do
    it "returns not found error" do
      delete path_404

      # TODO: DRY - resource_not_found error respone
      expect(response).to have_http_status(404)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('resource_not_found')
    end
  end
end