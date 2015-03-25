require 'rails_helper'

describe "GET /api/v1/templates/:id", type: :request do

  context "when template exists" do
    let(:template) { create(:template) }
    before(:each) do
      get api_v1_template_url(template)
    end

    it { expect(response).to have_http_status(200) }
    it { expect(response).to match_response_schema('template') }
    it { expect(json['id']).to eq(template.id) }
  end

  context "when template does not exists" do
    before(:each) do
      get api_v1_template_url(0)
    end

    it_should_return "resource_not_found error"
  end

end