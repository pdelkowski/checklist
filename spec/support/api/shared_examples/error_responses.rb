shared_examples_for "resource_not_found error" do
  it { expect(response).to have_http_status(404) }
  it { expect(response).to match_response_schema('error') }
  it { expect(json['status_code']).to eq(404) }
  it { expect(json['error_code']).to eq('resource_not_found') }
end

shared_examples_for "validation_failed error" do |expected_errors|
  subject { response }
  
  it "returns validation_failed error response" do
    is_expected.to have_http_status(422)
    is_expected.to match_response_schema('error')
    expect(json['status_code']).to eq(422)
    expect(json['error_code']).to eq('validation_failed')
    
    unless expected_errors.nil?
      expect(json['errors']).to eq(expected_errors)
    end
  end
end