require 'rails_helper'

describe "POST /api/v1/items/:id/uncomplete", type: :request do
  subject { response }
  
  let(:checklist) { create(:checklist) }
  let(:item) { create(:item_completed, checklist: checklist) }
  let(:url) { "/api/v1/items/#{item.id}/uncomplete" }
  
  before :each do
    post url
  end
  
  it "marks item as uncompleted" do
    is_expected.to have_http_status(200)
    is_expected.to match_response_schema('item')
    expect(json['completed_at']).to be_nil
  end

  it "decrements completed counter cache in checklist" do
    get "/api/v1/checklists/#{checklist.id}"
    expect(json['completed_count']).to eq(0)
  end
  
  context "when item is uncompleted already" do
    let(:item) { create(:item) }
    it "it is not affected" do
      expect(json['completed_at']).to be_nil
    end
  end
end