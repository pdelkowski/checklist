require 'rails_helper'

describe "Get all items of checklist", type: :request do
  let(:checklist) { FactoryGirl.create(:checklist) }
  let!(:items) { (1..10).collect { FactoryGirl.create(:item, checklist: checklist) } }

  let(:path) { "/api/v1/checklists/#{checklist.id}/items" }
  let(:path_404) { '/api/v1/checklists/2434und/items' }

  context "when checklist exists" do
    it "returns collection of checklist items" do
      get path

      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('items_collection')
      expect(json.count).to eq(items.count)
    end
  end

  context "when checklist not exists" do
    it "returns not found error" do
      get path_404

      expect(response).to have_http_status(404)
      expect(response).to match_response_schema('error')
      expect(json['error_code']).to eq('resource_not_found')
    end
  end
end