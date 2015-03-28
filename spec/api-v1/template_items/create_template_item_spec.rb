require 'rails_helper'

describe "POST /api/v1/templates/:id/items", type: :request do
  subject { response }
  
  let(:template) { create(:template) }
  let(:url) { api_v1_template_items_url(template) }
  let(:post_attributes) { build(:template_item_attributes) }
  
  before :each do
    post url, post_attributes
  end
  
  context "with valid input" do
    it "creates the resource" do
      is_expected.to have_http_status(201)
      is_expected.to match_response_schema('template_item')
    end
    
    it "makes resource available on the list" do
      get url
      
      is_expected.to have_http_status(200)
      is_expected.to match_response_schema('template_items_collection')
      expect(json.count).to eq(1)
    end
  end

  context "with empty name" do
    let(:post_attributes) { build(:template_item_attributes, name: '') }
    include_examples "validation_failed error", { 'name' => ['required', 'too_short'] }
  end
  
  context "with too short name" do
    let(:post_attributes) { build(:template_item_attributes, name: 'a') }
    include_examples "validation_failed error", { 'name' => ['too_short'] }
  end
  
  context "with too long name" do
    let(:post_attributes) { build(:template_item_attributes, name: Faker::Lorem.characters(150)) }
    include_examples "validation_failed error", { 'name' => ['too_long'] }
  end
  
  context "when template does not exists" do
    let(:template) { 0 }
    include_examples "resource_not_found error"
  end
end
