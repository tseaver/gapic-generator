# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "minitest/autorun"
require "minitest/spec"

require "google/gax"

require "google/cloud/showcase"
require "google/cloud/showcase/v1/showcase_client"
require "google/showcase/v1/showcase_services_pb"
require "google/longrunning/operations_pb"

class CustomTestError < StandardError; end

# Mock for the GRPC::ClientStub class.
class MockGrpcClientStub

  # @param expected_symbol [Symbol] the symbol of the grpc method to be mocked.
  # @param mock_method [Proc] The method that is being mocked.
  def initialize(expected_symbol, mock_method)
    @expected_symbol = expected_symbol
    @mock_method = mock_method
  end

  # This overrides the Object#method method to return the mocked method when the mocked method
  # is being requested. For methods that aren't being tested, this method returns a proc that
  # will raise an error when called. This is to assure that only the mocked grpc method is being
  # called.
  #
  # @param symbol [Symbol] The symbol of the method being requested.
  # @return [Proc] The proc of the requested method. If the requested method is not being mocked
  #   the proc returned will raise when called.
  def method(symbol)
    return @mock_method if symbol == @expected_symbol

    # The requested method is not being tested, raise if it called.
    proc do
      raise "The method #{symbol} was unexpectedly called during the " \
        "test for #{@expected_symbol}."
    end
  end
end

class MockShowcaseCredentials < Google::Cloud::Showcase::V1::Credentials
  def initialize(method_name)
    @method_name = method_name
  end

  def updater_proc
    proc do
      raise "The method `#{@method_name}` was trying to make a grpc request. This should not " \
          "happen since the grpc layer is being mocked."
    end
  end
end

describe Google::Cloud::Showcase::V1::ShowcaseClient do

  describe 'echo' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#echo."

    it 'invokes echo without error' do
      # Create expected grpc response
      content = "content951530617"
      expected_response = { content: content }
      expected_response = Google::Gax::to_proto(expected_response, Google::Showcase::V1::EchoResponse)

      # Mock Grpc layer
      mock_method = proc do
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub.new(:echo, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("echo")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.echo

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.echo do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes echo with error' do
      # Mock Grpc layer
      mock_method = proc do
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:echo, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("echo")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.echo
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'expand' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#expand."

    it 'invokes expand without error' do
      # Create expected grpc response
      content = "content951530617"
      expected_response = { content: content }
      expected_response = Google::Gax::to_proto(expected_response, Google::Showcase::V1::EchoResponse)

      # Mock Grpc layer
      mock_method = proc do
        OpenStruct.new(execute: [expected_response])
      end
      mock_stub = MockGrpcClientStub.new(:expand, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("expand")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.expand

          # Verify the response
          assert_equal(1, response.count)
          assert_equal(expected_response, response.first)
        end
      end
    end

    it 'invokes expand with error' do
      # Mock Grpc layer
      mock_method = proc do
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:expand, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("expand")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.expand
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'collect' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#collect."

    it 'invokes collect without error' do
      # Create request parameters
      request = {}

      # Create expected grpc response
      content = "content951530617"
      expected_response = { content: content }
      expected_response = Google::Gax::to_proto(expected_response, Google::Showcase::V1::EchoResponse)

      # Mock Grpc layer
      mock_method = proc do |requests|
        request = requests.first
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub.new(:collect, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("collect")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.collect([request])

          # Verify the response
          assert_equal(expected_response, response)
        end
      end
    end

    it 'invokes collect with error' do
      # Create request parameters
      request = {}

      # Mock Grpc layer
      mock_method = proc do |requests|
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:collect, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("collect")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.collect([request])
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'chat' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#chat."

    it 'invokes chat without error' do
      # Create request parameters
      request = {}

      # Create expected grpc response
      content = "content951530617"
      expected_response = { content: content }
      expected_response = Google::Gax::to_proto(expected_response, Google::Showcase::V1::EchoResponse)

      # Mock Grpc layer
      mock_method = proc do |requests|
        request = requests.first
        OpenStruct.new(execute: [expected_response])
      end
      mock_stub = MockGrpcClientStub.new(:chat, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("chat")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.chat([request])

          # Verify the response
          assert_equal(1, response.count)
          assert_equal(expected_response, response.first)
        end
      end
    end

    it 'invokes chat with error' do
      # Create request parameters
      request = {}

      # Mock Grpc layer
      mock_method = proc do |requests|
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:chat, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("chat")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.chat([request])
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'timeout' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#timeout."

    it 'invokes timeout without error' do
      # Create request parameters
      response_delay = {}

      # Create expected grpc response
      content = "content951530617"
      expected_response = { content: content }
      expected_response = Google::Gax::to_proto(expected_response, Google::Showcase::V1::TimeoutResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::TimeoutRequest, request)
        assert_equal(Google::Gax::to_proto(response_delay, Google::Protobuf::Duration), request.response_delay)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub.new(:timeout, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("timeout")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.timeout(response_delay)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.timeout(response_delay) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes timeout with error' do
      # Create request parameters
      response_delay = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::TimeoutRequest, request)
        assert_equal(Google::Gax::to_proto(response_delay, Google::Protobuf::Duration), request.response_delay)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:timeout, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("timeout")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.timeout(response_delay)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'setup_retry' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#setup_retry."

    it 'invokes setup_retry without error' do
      # Create request parameters
      responses = []

      # Create expected grpc response
      id = "id3355"
      expected_response = { id: id }
      expected_response = Google::Gax::to_proto(expected_response, Google::Showcase::V1::RetryId)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::SetupRetryRequest, request)
        responses = responses.map do |req|
          Google::Gax::to_proto(req, Google::Rpc::Status)
        end
        assert_equal(responses, request.responses)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub.new(:setup_retry, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("setup_retry")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.setup_retry(responses)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.setup_retry(responses) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes setup_retry with error' do
      # Create request parameters
      responses = []

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::SetupRetryRequest, request)
        responses = responses.map do |req|
          Google::Gax::to_proto(req, Google::Rpc::Status)
        end
        assert_equal(responses, request.responses)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:setup_retry, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("setup_retry")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.setup_retry(responses)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'retry' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#retry."

    it 'invokes retry without error' do
      # Create request parameters
      id = ''

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::RetryId, request)
        assert_equal(id, request.id)
        OpenStruct.new(execute: nil)
      end
      mock_stub = MockGrpcClientStub.new(:retry, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("retry")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.retry(id)

          # Verify the response
          assert_nil(response)

          # Call method with block
          client.retry(id) do |response, operation|
            # Verify the response
            assert_nil(response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes retry with error' do
      # Create request parameters
      id = ''

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::RetryId, request)
        assert_equal(id, request.id)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:retry, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("retry")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.retry(id)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'longrunning' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#longrunning."

    it 'invokes longrunning without error' do
      # Create request parameters
      completion_time = {}

      # Create expected grpc response
      content = "content951530617"
      expected_response = { content: content }
      expected_response = Google::Gax::to_proto(expected_response, Google::Showcase::V1::LongrunningResponse)
      result = Google::Protobuf::Any.new
      result.pack(expected_response)
      operation = Google::Longrunning::Operation.new(
        name: 'operations/longrunning_test',
        done: true,
        response: result
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::LongrunningRequest, request)
        assert_equal(Google::Gax::to_proto(completion_time, Google::Protobuf::Timestamp), request.completion_time)
        OpenStruct.new(execute: operation)
      end
      mock_stub = MockGrpcClientStub.new(:longrunning, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("longrunning")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.longrunning(completion_time)

          # Verify the response
          assert_equal(expected_response, response.response)
        end
      end
    end

    it 'invokes longrunning and returns an operation error.' do
      # Create request parameters
      completion_time = {}

      # Create expected grpc response
      operation_error = Google::Rpc::Status.new(
        message: 'Operation error for Google::Cloud::Showcase::V1::ShowcaseClient#longrunning.'
      )
      operation = Google::Longrunning::Operation.new(
        name: 'operations/longrunning_test',
        done: true,
        error: operation_error
      )

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::LongrunningRequest, request)
        assert_equal(Google::Gax::to_proto(completion_time, Google::Protobuf::Timestamp), request.completion_time)
        OpenStruct.new(execute: operation)
      end
      mock_stub = MockGrpcClientStub.new(:longrunning, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("longrunning")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.longrunning(completion_time)

          # Verify the response
          assert(response.error?)
          assert_equal(operation_error, response.error)
        end
      end
    end

    it 'invokes longrunning with error' do
      # Create request parameters
      completion_time = {}

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::LongrunningRequest, request)
        assert_equal(Google::Gax::to_proto(completion_time, Google::Protobuf::Timestamp), request.completion_time)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:longrunning, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("longrunning")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.longrunning(completion_time)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'pagination' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#pagination."

    it 'invokes pagination without error' do
      # Create request parameters
      max_response = 0

      # Create expected grpc response
      next_page_token = ""
      responses_element = 640301041
      responses = [responses_element]
      expected_response = { next_page_token: next_page_token, responses: responses }
      expected_response = Google::Gax::to_proto(expected_response, Google::Showcase::V1::PaginationResponse)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::PaginationRequest, request)
        assert_equal(max_response, request.max_response)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub.new(:pagination, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("pagination")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.pagination(max_response)

          # Verify the response
          assert(response.instance_of?(Google::Gax::PagedEnumerable))
          assert_equal(expected_response, response.page.response)
          assert_nil(response.next_page)
          assert_equal(expected_response.responses.to_a, response.to_a)
        end
      end
    end

    it 'invokes pagination with error' do
      # Create request parameters
      max_response = 0

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::PaginationRequest, request)
        assert_equal(max_response, request.max_response)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:pagination, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("pagination")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.pagination(max_response)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'parameter_flattening' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#parameter_flattening."

    it 'invokes parameter_flattening without error' do
      # Create expected grpc response
      content = "content951530617"
      expected_response = { content: content }
      expected_response = Google::Gax::to_proto(expected_response, Google::Showcase::V1::ParameterFlatteningMessage)

      # Mock Grpc layer
      mock_method = proc do
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub.new(:parameter_flattening, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("parameter_flattening")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.parameter_flattening

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.parameter_flattening do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes parameter_flattening with error' do
      # Mock Grpc layer
      mock_method = proc do
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:parameter_flattening, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("parameter_flattening")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.parameter_flattening
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end

  describe 'resource_name' do
    custom_error = CustomTestError.new "Custom test error for Google::Cloud::Showcase::V1::ShowcaseClient#resource_name."

    it 'invokes resource_name without error' do
      # Create request parameters
      formatted_single_template = Google::Cloud::Showcase::V1::ShowcaseClient.single_path("[ID]")
      formatted_multiple_templates = Google::Cloud::Showcase::V1::ShowcaseClient.first_path("[ID]")

      # Create expected grpc response
      single_template_2 = "singleTemplate21956345348"
      multiple_templates_2 = "multipleTemplates2-1782099715"
      expected_response = { single_template: single_template_2, multiple_templates: multiple_templates_2 }
      expected_response = Google::Gax::to_proto(expected_response, Google::Showcase::V1::ResourceNameMessage)

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::ResourceNameMessage, request)
        assert_equal(formatted_single_template, request.single_template)
        assert_equal(formatted_multiple_templates, request.multiple_templates)
        OpenStruct.new(execute: expected_response)
      end
      mock_stub = MockGrpcClientStub.new(:resource_name, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("resource_name")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          response = client.resource_name(formatted_single_template, formatted_multiple_templates)

          # Verify the response
          assert_equal(expected_response, response)

          # Call method with block
          client.resource_name(formatted_single_template, formatted_multiple_templates) do |response, operation|
            # Verify the response
            assert_equal(expected_response, response)
            refute_nil(operation)
          end
        end
      end
    end

    it 'invokes resource_name with error' do
      # Create request parameters
      formatted_single_template = Google::Cloud::Showcase::V1::ShowcaseClient.single_path("[ID]")
      formatted_multiple_templates = Google::Cloud::Showcase::V1::ShowcaseClient.first_path("[ID]")

      # Mock Grpc layer
      mock_method = proc do |request|
        assert_instance_of(Google::Showcase::V1::ResourceNameMessage, request)
        assert_equal(formatted_single_template, request.single_template)
        assert_equal(formatted_multiple_templates, request.multiple_templates)
        raise custom_error
      end
      mock_stub = MockGrpcClientStub.new(:resource_name, mock_method)

      # Mock auth layer
      mock_credentials = MockShowcaseCredentials.new("resource_name")

      Google::Showcase::V1::Showcase::Stub.stub(:new, mock_stub) do
        Google::Cloud::Showcase::V1::Credentials.stub(:default, mock_credentials) do
          client = Google::Cloud::Showcase.new(version: :v1)

          # Call method
          err = assert_raises Google::Gax::GaxError do
            client.resource_name(formatted_single_template, formatted_multiple_templates)
          end

          # Verify the GaxError wrapped the custom error that was raised.
          assert_match(custom_error.message, err.message)
        end
      end
    end
  end
end