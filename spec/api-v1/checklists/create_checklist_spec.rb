require 'rails_helper'

describe "Creating the checklist", type: :request do
  subject { response }
  
  let(:url) { api_v1_checklists_url }
  let(:post_attributes) { build(:checklist_attributes) }

  let!(:template) { create(:template) }
  let!(:template_items) { (1..10).collect { create(:template_item, template: template) } }
  
  before :each do
    post url, post_attributes
  end
  
  context "with valid input" do
    it "creates the resource" do
      is_expected.to have_http_status(201)
      is_expected.to match_response_schema('checklist')
      expect(json['id']).to_not be_nil
      expect(json['name']).to eq(post_attributes[:name])
      expect(json['completed_at']).to eq(nil)
      expect(json['items_count']).to eq(0)
      expect(json['completed_count']).to eq(0)
    end
    
    context "when create from template" do
      let(:post_attributes) { build(:checklist_attributes, from_template: template.id) }
    
      it "returns valid items counter cache" do
        expect(json['items_count']).to eq(template_items.count)
      end
    
      # it "create items based on template" do
      #   is_expected.to have_http_status(200)
      #   is_expected.to match_response_schema('items_collection')
      #   expect(json.count).to eq(template_items.count)
      # end
    end
  end
  
  context "with invalid input" do
    describe "empty name" do
      let(:post_attributes) { build(:checklist_attributes, name: '') }
      include_examples "validation_failed error", { 'name' => ['required', 'too_short'] }
    end

    describe "too short name" do
      let(:post_attributes) { build(:checklist_attributes, name: 'a') }
      include_examples "validation_failed error", { 'name' => ['too_short'] }
    end

    describe "too long name" do
      let(:post_attributes) { build(:checklist_attributes, name: Faker::Lorem.characters(150)) }
      include_examples "validation_failed error", { 'name' => ['too_long'] }
    end

    describe "defined from_template does not exists" do
      let(:post_attributes) { build(:checklist_attributes, from_template: '0') }
      include_examples "validation_failed error", { 'from_template' => ['resource_not_found'] }
    end
  end
end