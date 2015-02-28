require 'rails_helper'

describe "Creating checklist", type: :request do
  let(:path) { '/api/v1/checklists' }

  it "expect to create new checklist" do
    data = { name: 'My Checklist' }

    post path, data

    expect(response).to have_http_status(200)
    expect(json).to include("id", "name", "completed_at", "created_at", "updated_at")
    expect(json['name']).to eq(data[:name])
    expect(json['completed_on']).to eq(nil)
  end

  context "with empty name" do
    before :each do
      post path
    end

    it_behaves_like "a validation error"

    it "expect valid errors structure" do
      validation_errors = {
          "name" => ["required", "too_short"]
      }

      expect(json['errors']).to eq(validation_errors)
    end
  end

  context "with too short name" do
    before :each do
      post path, { name: 'a' }
    end

    it_behaves_like "a validation error"

    it "expect valid errors structure" do
      validation_errors = {
          "name" => ["too_short"]
      }

      expect(json['errors']).to eq(validation_errors)
    end
  end

  context "with too long name" do
    before :each do
      post path, { name: 'Checklist name' * 20 }
    end

    it_behaves_like "a validation error"

    it "expect valid errors structure" do
      validation_errors = {
          "name" => ["too_long"]
      }

      expect(json['errors']).to eq(validation_errors)
    end
  end
end