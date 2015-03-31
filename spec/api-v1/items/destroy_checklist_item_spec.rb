require 'rails_helper'

describe "DELETE /api/v1/items/:id", type: :request do
  subject { response }
  
  let(:item) { create(:item) }
  let(:url) { "/api/v1/items/#{item.id}" }

  before :each do
    delete url
  end

  it "responds with destroyed item and 200 status code" do
    expect(response).to have_http_status(200)
    expect(response).to match_response_schema('item')
    expect(json['id']).to eq(item.id)
  end
  
  it "decrements items counter cache" do
    get "/api/v1/checklists/#{item.checklist.id}"
    expect(json['items_count']).to eq(0)
  end

  context "when item not exists" do
    let(:item) { build(:item, id: 0) }
    include_examples "resource_not_found error"
  end
end