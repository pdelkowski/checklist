require 'rails_helper'

describe "POST /api/v1/templates", type: :request do
  before :each do
    post api_v1_templates_url, attributes
  end

  context "with valid attributes" do
    let(:attributes) { build(:template_attributes) }

    it { expect(response).to have_http_status(201) }
    it { expect(response).to match_response_schema('template') }
  end
end