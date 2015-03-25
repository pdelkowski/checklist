shared_examples_for "resource_not_found error" do
  it { expect(response).to have_http_status(404) }
  it { expect(response).to match_response_schema('error') }
  it { expect(json['status_code']).to eq(404) }
  it { expect(json['error_code']).to eq('resource_not_found') }
end

shared_examples_for "validation_failed error" do
  it { expect(response).to have_http_status(422) }
  it { expect(response).to match_response_schema('error') }
  it { expect(json['status_code']).to eq(422) }
  it { expect(json['error_code']).to eq('validation_failed') }
end