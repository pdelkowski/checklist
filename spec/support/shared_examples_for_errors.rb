RSpec.shared_examples "a validation error" do
  it "expect validation error response" do
    expect(response).to have_http_status(422)
    expect(json).to include('status_code', 'error_code', 'message', 'errors')
    expect(json['status_code']).to eq(422)
    expect(json['error_code']).to eq('validation_failed')
    expect(json['errors']).to_not be_empty
  end
end