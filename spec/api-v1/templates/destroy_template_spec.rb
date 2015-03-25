require 'rails_helper'

describe "DELETE /api/v1/templates/:id", type: :request do
  let(:template) { create(:template) }

  before :each do
    delete api_v1_template_url(template)
  end

  it { expect(response).to have_http_status(200) }
  it { expect(response).to match_response_schema('template') }
  it { expect(json['id']).to eq(template.id) }

  context "when template does not exists" do
    let(:template) { 0 }

    it_should_return "resource_not_found error"
  end
end