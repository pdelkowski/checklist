require 'rails_helper'

describe "GET /api/v1/templates/:id/items", type: :request do
  let(:template) { create(:template) }

  before :each do
    get api_v1_template_items_url(template)
  end

  context "when no items are defined" do
    it { expect(response).to have_http_status(200) }
    it { expect(response).to match_response_schema('template_items_collection') }
    it { expect(json.count).to eq(0) }
  end

  context "when items are defined" do
    let!(:items) { create(:template_item, template: template) }

    before :each do
      get api_v1_template_items_url(template)
    end

    it { expect(response).to have_http_status(200) }
    it { expect(response).to match_response_schema('template_items_collection') }
    # it { expect(json.count).to eq(items.count) }
  end

  context "when template does not exists" do
    let(:template) { 0 }

    it_should_return "resource_not_found error"
  end
end