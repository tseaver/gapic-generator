require "minitest/autorun"
require "minitest/spec"

require "grpc"

require "google/cloud/showcase/v1/showcase_client"
require "google/showcase/v1/showcase_services_pb"

describe Google::Cloud::Showcase::V1::ShowcaseClient do
  before(:all) do
    @client = Google::Cloud::Showcase::V1::ShowcaseClient.new(
      credentials: GRPC::Core::Channel.new(
        "localhost:8080", nil, :this_channel_is_insecure))
  end

  describe 'echo' do
    it 'invokes echo without error' do
      # Create expected grpc response
      content = "Echo Content"
      expected_response = { content: content }
      expected_response = Google::Gax::to_proto(
        expected_response, Google::Showcase::V1::EchoResponse)

      # Call method
      response = @client.echo(content: content)

      # Verify the response
      assert_equal(expected_response, response)
    end
  end

  describe 'timeout' do
    it 'invokes timeout without error' do
      # Create expected grpc response
      response_delay = {seconds: 2}
      success = { content: "Timeout Content" }
      expected_response = Google::Gax::to_proto(
        success, Google::Showcase::V1::TimeoutResponse)

      # Call method
      response = @client.timeout(response_delay, success: success)

      # Verify the response
      assert_equal(expected_response, response)
    end
  end
end
