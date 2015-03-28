require 'rails_helper'

describe "DELETE /api/v1/templates_items/:id", type: :request do
  subject { response }
  
  let(:item) { create(:template_item) }
  let(:url) { api_v1_template_item_url(item) }
  
  before :each do
    delete url
  end
  
  it "returns the destroyed resource" do
    is_expected.to have_http_status(200)
    is_expected.to match_response_schema('template_item')
  end
  
  context "when requesting for item after remove it" do
    before :each do
      get url
    end
    
    include_examples "resource_not_found error"
  end
  
  context "when item does not exists" do
    let(:item) { 0 }
    include_examples "resource_not_found error"
  end
end