require 'rails_helper'

describe "PUT /api/v1/template_items/:id", type: :request do
  subject { response }
  
  let(:item) { create(:template_item) }
  let(:url) { api_v1_template_item_url(item) }
  let(:put_attributes) { build(:template_item_attributes) }
  
  before :each do
    put url, put_attributes
  end
  
  context "with valid input" do
    it "returns the updated resource" do
      is_expected.to have_http_status(200)
      is_expected.to match_response_schema('template_item')
      expect(json['name']).to eq(put_attributes[:name])
    end
  end
  
  context "with empty name" do
    let(:put_attributes) { build(:template_item_attributes, name: '') }
    include_examples "validation_failed error", { 'name' => ['required', 'too_short'] }
  end
  
  context "with too short name" do
    let(:put_attributes) { build(:template_item_attributes, name: 'a') }
    include_examples "validation_failed error", { 'name' => ['too_short'] }
  end
  
  context "with too long name" do
    let(:put_attributes) { build(:template_item_attributes, name: Faker::Lorem.characters(150)) }
    include_examples "validation_failed error", { 'name' => ['too_long'] }
  end
end
