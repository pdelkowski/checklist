require 'rails_helper'

describe "GET /api/v1/templates/:id/items", type: :request do
  let(:template) { create(:template) }
  let(:url) { "/api/v1/templates/#{template.try(:id)}/items" }

  before :each do
    get url
  end

  context "when no items are defined" do
    it { expect(response).to have_http_status(200) }
    it { expect(response).to match_response_schema('template_items_collection') }
    it { expect(json.count).to eq(0) }
  end

  context "when items are defined" do
    let!(:items) { (1..10).collect{ create(:template_item, template: template) } }

    before :each do
      get url
    end

    it { expect(response).to have_http_status(200) }
    it { expect(response).to match_response_schema('template_items_collection') }
    it { expect(json.count).to eq(items.count) }
  end

  context "when template does not exists" do
    let(:template) { 0 }

    it_should_return "resource_not_found error"
  end
end