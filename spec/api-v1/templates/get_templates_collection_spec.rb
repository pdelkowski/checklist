require 'rails_helper'

describe "GET /api/v1/templates", type: :request do
  context "when templates are defined" do
    let!(:templates) { create(:template) }

    before(:each) { get api_v1_templates_url }

    it { expect(response).to have_http_status(200) }
    it { expect(response).to match_response_schema('template_collection') }
    it { expect(json.length).to eq(1) }
  end

  context "when no templates are defined" do
    before(:each) { get api_v1_templates_url }

    it { expect(response).to have_http_status(200) }
    it { expect(response).to match_response_schema('template_collection') }
    it { expect(json.length).to eq(0) }
  end
end