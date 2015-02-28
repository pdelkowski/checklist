require 'rails_helper'

describe "Get list of checklist", type: :request do
  # let! disables lazy loading
  let!(:checklists) { (1..5).collect { FactoryGirl.create(:checklist) } }

  let(:path) { '/api/v1/checklists' }

  it "returns list of checklist resources" do
    get path

    expect(response).to have_http_status(200)
    expect(response).to match_response_schema('checklist_collection')
    expect(json.count).to eq(checklists.count)
  end

end