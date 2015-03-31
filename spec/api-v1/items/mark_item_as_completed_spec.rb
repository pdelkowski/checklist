require 'rails_helper'

describe "POST /api/v1/items/:id/complete", type: :request do
  subject { response }
  
  let(:checklist) { create(:checklist) }
  let(:item) { create(:item, checklist: checklist) }
  let(:url) { "/api/v1/items/#{item.id}/complete" }
  
  before :each do
    post url
  end
  
  it "completes item" do
    is_expected.to have_http_status(200)
    is_expected.to match_response_schema('item')
    expect(json['completed_at']).to_not be_nil
  end
  
  it "increments completed counter cache in checklist" do
    get "/api/v1/checklists/#{checklist.id}"
    expect(json['completed_count']).to eq(checklist.completed_count+1)
  end
  
  context "when item is completed already" do
    let(:item) { create(:item_completed) }
    it "it is not affected" do
      is_expected.to have_http_status(200)
      is_expected.to match_response_schema('item')
      
      # Make sure to compare in same formats
      response_time = Time.parse(json['completed_at']).strftime('%Y-%m-%dT%l:%M:%S%z')
      expected_time = item.completed_at.strftime('%Y-%m-%dT%l:%M:%S%z')
      
      expect(response_time).to eq(expected_time)
    end
  end
  
  context "when item does not exists" do
    let(:item) { build(:item, id: 0) }
    include_examples "resource_not_found error"
  end
end