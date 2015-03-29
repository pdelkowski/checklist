require 'rails_helper'

describe "DELETE /api/v1/checklists/:id", type: :request do
  subject { response }
  
  let(:checklist) { create(:checklist) }
  let!(:items) { create(:item, checklist: checklist) }
  let(:url) { api_v1_checklist_url(checklist) }
  
  before :each do
    delete url
  end
  
  it "returns the resource" do
    is_expected.to have_http_status(200)
    is_expected.to match_response_schema('checklist')
  end
  
  it "removes all items of the checklist" do
    count = Item.where(checklist_id: checklist.id).count
    expect(count).to eq(0)
  end
  
  context "when requesting removed checklist" do
    before { get url }
    include_examples "resource_not_found error"
  end
 
  context "when checklist does not exists" do
    let(:checklist) { 0 }
    let!(:items) {}
    include_examples "resource_not_found error"
  end
end