require 'rails_helper'

describe "POST /api/v1/checklists/:id/items", type: :request do
  subject { response }
  
  let(:checklist) { create(:checklist) }
  let(:post_attributes) { build(:item_attributes) }
  let(:url) { api_v1_checklist_items_url(checklist) }
  
  before :each do
    post url, post_attributes
  end
  
  context "with valid input" do
    it "creates the resource" do
      is_expected.to have_http_status(201)
      is_expected.to match_response_schema('item')
    end
    
    it "makes resource available on the list" do
      get url
      
      is_expected.to have_http_status(200)
      expect(json.count).to eq(1)
    end
  end
  
  context "with empty description" do
    let(:post_attributes) { build(:item_attributes, description: '') }
    
    include_examples "validation_failed error", { 'description' => ['required', 'too_short'] }
  end
  
  context "with too short description" do
    let(:post_attributes) { build(:item_attributes, description: 'a') }
    
    include_examples "validation_failed error", { 'description' => ['too_short'] }
  end
  
  context "with too long description" do
    let(:post_attributes) { build(:item_attributes, description: Faker::Lorem.characters(150)) }
    
    include_examples "validation_failed error", { 'description' => ['too_long'] }
  end
  
  context "when checklist does not exists" do
    let(:checklist) { 0 }
    
    include_examples "resource_not_found error"
  end
end