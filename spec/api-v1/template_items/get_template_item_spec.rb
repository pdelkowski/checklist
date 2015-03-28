require 'rails_helper'

describe "GET /api/v1/templates_items/:id", type: :request do
  subject { response }
  
  let(:item) { create(:template_item) }
  let(:url) { api_v1_template_item_url(item) }
  
  before :each do
    get url
  end
  
  it "returns the resource" do
    is_expected.to have_http_status(200)
    is_expected.to match_response_schema('template_item')
    expect(json['id']).to eq(item.id)
  end
  
  context "when item does not exists" do
    let(:item) { 0 }
    
    include_examples "resource_not_found error"
  end
end