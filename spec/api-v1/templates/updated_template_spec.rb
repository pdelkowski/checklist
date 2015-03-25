require 'rails_helper'

describe "PUT /api/v1/templates/:id", type: :request do
  let(:template) { create(:template) }

  before :each do
    put api_v1_template_url(template), attributes
  end

  context "when template does not exists" do
    let(:attributes) {}
    let(:template) { 0 }

    it_should_return "resource_not_found error"
  end

  context "when attributes are valid" do
    let(:attributes) { build(:template_attributes) }

    it { expect(response).to have_http_status(200) }
    it { expect(response).to match_response_schema('template') }
    it { expect(json['id']).to eq(template.id) }
  end

  context "when name attribute is empty" do
    let(:attributes) { build(:template_attributes, name: '') }
    let(:expected_errors) do
      { 'name' => ['required', 'too_short'] }
    end

    it_should_return "validation_failed error"
    it { expect(json['errors']).to eq(expected_errors) }
  end

  context "when name attribute is too short" do
    let(:attributes) { build(:template_attributes, name: 'a') }
    let(:expected_errors) do
      { 'name' => ['too_short'] }
    end

    it_should_return "validation_failed error"
    it { expect(json['errors']).to eq(expected_errors) }
  end

  context "when name attribute is too long" do
    let(:attributes) { build(:template_attributes, name: Faker::Lorem.characters(150)) }
    let(:expected_errors) do
      { 'name' => ['too_long'] }
    end

    it_should_return "validation_failed error"
    it { expect(json['errors']).to eq(expected_errors) }
  end
end