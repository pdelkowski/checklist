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

  context "with empty name attribute" do
    let(:attributes) { build(:template_attributes, name: '') }
    let(:expected_errors) do
      { 'name' => ['required', 'too_short'] }
    end

    it_should_return "validation_failed error"
    it { expect(json['errors']).to eq(expected_errors) }
  end

  context "with too short name attribute" do
    let(:attributes) { build(:template_attributes, name: 'a') }
    let(:expected_errors) do
      { 'name' => ['too_short'] }
    end

    it_should_return "validation_failed error"
    it { expect(json['errors']).to eq(expected_errors) }
  end

  context "with too long name attribute" do
    let(:attributes) { build(:template_attributes, name: Faker::Lorem.characters(150)) }
    let(:expected_errors) do
      { 'name' => ['too_long'] }
    end

    it_should_return "validation_failed error"
    it { expect(json['errors']).to eq(expected_errors) }
  end
end