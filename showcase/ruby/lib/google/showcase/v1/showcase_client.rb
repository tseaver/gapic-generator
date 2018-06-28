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
#
# EDITING INSTRUCTIONS
# This file was generated from the file
# https://github.com/googleapis/googleapis/blob/master/google/showcase/v1/showcase.proto,
# and updates to that file get reflected here through a refresh process.
# For the short term, the refresh process will only be runnable by Google
# engineers.

require "json"
require "pathname"

require "google/gax"
require "google/gax/operation"
require "google/longrunning/operations_client"

require "google/showcase/v1/showcase_pb"
require "google/showcase/v1/credentials"

module Google
  module Showcase
    module V1
      # A service to showcase Generated API Client features and common API patterns
      # used by Google.
      #
      # @!attribute [r] showcase_stub
      #   @return [Google::Showcase::V1::Showcase::Stub]
      class ShowcaseClient
        attr_reader :showcase_stub

        # The default address of the service.
        SERVICE_ADDRESS = "showcase.googleapis.com".freeze

        # The default port of the service.
        DEFAULT_SERVICE_PORT = 443

        # The default set of gRPC interceptors.
        GRPC_INTERCEPTORS = []

        DEFAULT_TIMEOUT = 30

        PAGE_DESCRIPTORS = {
          "pagination" => Google::Gax::PageDescriptor.new(
            "page_token",
            "next_page_token",
            "responses")
        }.freeze

        private_constant :PAGE_DESCRIPTORS

        # The scopes needed to make gRPC calls to all of the methods defined in
        # this service.
        ALL_SCOPES = [
          "https://www.googleapis.com/auth/cloud-platform"
        ].freeze

        class OperationsClient < Google::Longrunning::OperationsClient
          self::SERVICE_ADDRESS = ShowcaseClient::SERVICE_ADDRESS
          self::GRPC_INTERCEPTORS = ShowcaseClient::GRPC_INTERCEPTORS
        end

        SINGLE_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
          "id/{id}/single"
        )

        private_constant :SINGLE_PATH_TEMPLATE

        FIRST_PATH_TEMPLATE = Google::Gax::PathTemplate.new(
          "id/{id}/first"
        )

        private_constant :FIRST_PATH_TEMPLATE

        # Returns a fully-qualified single resource name string.
        # @param id [String]
        # @return [String]
        def self.single_path id
          SINGLE_PATH_TEMPLATE.render(
            :"id" => id
          )
        end

        # Returns a fully-qualified first resource name string.
        # @param id [String]
        # @return [String]
        def self.first_path id
          FIRST_PATH_TEMPLATE.render(
            :"id" => id
          )
        end

        # @param credentials [Google::Auth::Credentials, String, Hash, GRPC::Core::Channel, GRPC::Core::ChannelCredentials, Proc]
        #   Provides the means for authenticating requests made by the client. This parameter can
        #   be many types.
        #   A `Google::Auth::Credentials` uses a the properties of its represented keyfile for
        #   authenticating requests made by this client.
        #   A `String` will be treated as the path to the keyfile to be used for the construction of
        #   credentials for this client.
        #   A `Hash` will be treated as the contents of a keyfile to be used for the construction of
        #   credentials for this client.
        #   A `GRPC::Core::Channel` will be used to make calls through.
        #   A `GRPC::Core::ChannelCredentials` for the setting up the RPC client. The channel credentials
        #   should already be composed with a `GRPC::Core::CallCredentials` object.
        #   A `Proc` will be used as an updater_proc for the Grpc channel. The proc transforms the
        #   metadata for requests, generally, to give OAuth credentials.
        # @param scopes [Array<String>]
        #   The OAuth scopes for this service. This parameter is ignored if
        #   an updater_proc is supplied.
        # @param client_config [Hash]
        #   A Hash for call options for each method. See
        #   Google::Gax#construct_settings for the structure of
        #   this data. Falls back to the default config if not specified
        #   or the specified config is missing data points.
        # @param timeout [Numeric]
        #   The default timeout, in seconds, for calls made through this client.
        # @param metadata [Hash]
        #   Default metadata to be sent with each request. This can be overridden on a per call basis.
        # @param exception_transformer [Proc]
        #   An optional proc that intercepts any exceptions raised during an API call to inject
        #   custom error handling.
        def initialize \
            credentials: nil,
            scopes: ALL_SCOPES,
            client_config: {},
            timeout: DEFAULT_TIMEOUT,
            metadata: nil,
            exception_transformer: nil,
            lib_name: nil,
            lib_version: ""
          # These require statements are intentionally placed here to initialize
          # the gRPC module only when it's required.
          # See https://github.com/googleapis/toolkit/issues/446
          require "google/gax/grpc"
          require "google/showcase/v1/showcase_services_pb"

          credentials ||= Google::Showcase::V1::Credentials.default

          @operations_client = OperationsClient.new(
            credentials: credentials,
            scopes: scopes,
            client_config: client_config,
            timeout: timeout,
            lib_name: lib_name,
            lib_version: lib_version,
          )

          if credentials.is_a?(String) || credentials.is_a?(Hash)
            updater_proc = Google::Showcase::V1::Credentials.new(credentials).updater_proc
          end
          if credentials.is_a?(GRPC::Core::Channel)
            channel = credentials
          end
          if credentials.is_a?(GRPC::Core::ChannelCredentials)
            chan_creds = credentials
          end
          if credentials.is_a?(Proc)
            updater_proc = credentials
          end
          if credentials.is_a?(Google::Auth::Credentials)
            updater_proc = credentials.updater_proc
          end

          package_version = Gem.loaded_specs['google-showcase'].version.version

          google_api_client = "gl-ruby/#{RUBY_VERSION}"
          google_api_client << " #{lib_name}/#{lib_version}" if lib_name
          google_api_client << " gapic/#{package_version} gax/#{Google::Gax::VERSION}"
          google_api_client << " grpc/#{GRPC::VERSION}"
          google_api_client.freeze

          headers = { :"x-goog-api-client" => google_api_client }
          headers.merge!(metadata) unless metadata.nil?
          client_config_file = Pathname.new(__dir__).join(
            "showcase_client_config.json"
          )
          defaults = client_config_file.open do |f|
            Google::Gax.construct_settings(
              "google.showcase.v1.Showcase",
              JSON.parse(f.read),
              client_config,
              Google::Gax::Grpc::STATUS_CODE_NAMES,
              timeout,
              page_descriptors: PAGE_DESCRIPTORS,
              errors: Google::Gax::Grpc::API_ERRORS,
              metadata: headers
            )
          end

          # Allow overriding the service path/port in subclasses.
          service_path = self.class::SERVICE_ADDRESS
          port = self.class::DEFAULT_SERVICE_PORT
          interceptors = self.class::GRPC_INTERCEPTORS
          @showcase_stub = Google::Gax::Grpc.create_stub(
            service_path,
            port,
            chan_creds: chan_creds,
            channel: channel,
            updater_proc: updater_proc,
            scopes: scopes,
            interceptors: interceptors,
            &Google::Showcase::V1::Showcase::Stub.method(:new)
          )

          @echo = Google::Gax.create_api_call(
            @showcase_stub.method(:echo),
            defaults["echo"],
            exception_transformer: exception_transformer
          )
          @expand = Google::Gax.create_api_call(
            @showcase_stub.method(:expand),
            defaults["expand"],
            exception_transformer: exception_transformer
          )
          @collect = Google::Gax.create_api_call(
            @showcase_stub.method(:collect),
            defaults["collect"],
            exception_transformer: exception_transformer
          )
          @chat = Google::Gax.create_api_call(
            @showcase_stub.method(:chat),
            defaults["chat"],
            exception_transformer: exception_transformer
          )
          @timeout = Google::Gax.create_api_call(
            @showcase_stub.method(:timeout),
            defaults["timeout"],
            exception_transformer: exception_transformer
          )
          @setup_retry = Google::Gax.create_api_call(
            @showcase_stub.method(:setup_retry),
            defaults["setup_retry"],
            exception_transformer: exception_transformer
          )
          @retry = Google::Gax.create_api_call(
            @showcase_stub.method(:retry),
            defaults["retry"],
            exception_transformer: exception_transformer
          )
          @longrunning = Google::Gax.create_api_call(
            @showcase_stub.method(:longrunning),
            defaults["longrunning"],
            exception_transformer: exception_transformer
          )
          @pagination = Google::Gax.create_api_call(
            @showcase_stub.method(:pagination),
            defaults["pagination"],
            exception_transformer: exception_transformer
          )
          @parameter_flattening = Google::Gax.create_api_call(
            @showcase_stub.method(:parameter_flattening),
            defaults["parameter_flattening"],
            exception_transformer: exception_transformer
          )
          @resource_name = Google::Gax.create_api_call(
            @showcase_stub.method(:resource_name),
            defaults["resource_name"],
            exception_transformer: exception_transformer
          )
        end

        # Service calls

        # A method used to show unary methods. This method will return the message
        # that was given.
        #
        # @param content [String]
        #   The content to be echoed by the server.
        # @param error [Google::Rpc::Status | Hash]
        #   The error to be thrown by the server.
        #   A hash of the same form as `Google::Rpc::Status`
        #   can also be provided.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @yield [result, operation] Access the result along with the RPC operation
        # @yieldparam result [Google::Showcase::V1::EchoResponse]
        # @yieldparam operation [GRPC::ActiveCall::Operation]
        # @return [Google::Showcase::V1::EchoResponse]
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #   response = showcase_client.echo

        def echo \
            content: nil,
            error: nil,
            options: nil,
            &block
          req = {
            content: content,
            error: error
          }.delete_if { |_, v| v.nil? }
          req = Google::Gax::to_proto(req, Google::Showcase::V1::EchoRequest)
          @echo.call(req, options, &block)
        end

        # A method used to show server-side streaming methods. This method will
        # split the given content into words and will pass each word back through
        # the stream.
        #
        # @param content [String]
        #   The content that will be split into words and returned on the stream.
        # @param error [Google::Rpc::Status | Hash]
        #   The error that is thrown after all words are sent on the stream.
        #   A hash of the same form as `Google::Rpc::Status`
        #   can also be provided.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @return [Enumerable<Google::Showcase::V1::EchoResponse>]
        #   An enumerable of Google::Showcase::V1::EchoResponse instances.
        #
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #   showcase_client.expand.each do |element|
        #     # Process element.
        #   end

        def expand \
            content: nil,
            error: nil,
            options: nil
          req = {
            content: content,
            error: error
          }.delete_if { |_, v| v.nil? }
          req = Google::Gax::to_proto(req, Google::Showcase::V1::ExpandRequest)
          @expand.call(req, options)
        end

        # A method used to show client-side streaming methods. This method will
        # collect the contents given to it. When the stream is closed by the client,
        # this method will return the a concatenation of the strings passed to it.
        #
        # @param reqs [Enumerable<Google::Showcase::V1::EchoRequest>]
        #   The input requests.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @return [Google::Showcase::V1::EchoResponse]
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        #
        # @note
        #   EXPERIMENTAL:
        #     Streaming requests are still undergoing review.
        #     This method interface might change in the future.
        #
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #   request = {}
        #   requests = [request]
        #   response = showcase_client.collect(requests)

        def collect reqs, options: nil
          request_protos = reqs.lazy.map do |req|
            Google::Gax::to_proto(req, Google::Showcase::V1::EchoRequest)
          end
          @collect.call(request_protos, options)
        end

        # @param reqs [Enumerable<Google::Showcase::V1::EchoRequest>]
        #   The input requests.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @return [Enumerable<Google::Showcase::V1::EchoResponse>]
        #   An enumerable of Google::Showcase::V1::EchoResponse instances.
        #
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        #
        # @note
        #   EXPERIMENTAL:
        #     Streaming requests are still undergoing review.
        #     This method interface might change in the future.
        #
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #   request = {}
        #   requests = [request]
        #   showcase_client.chat(requests).each do |element|
        #     # Process element.
        #   end

        def chat reqs, options: nil
          request_protos = reqs.lazy.map do |req|
            Google::Gax::to_proto(req, Google::Showcase::V1::EchoRequest)
          end
          @chat.call(request_protos, options)
        end

        # This method is to show how a client handles a request timing out. The
        # server will wait the requested amount of response_delay and then return
        # the response specified in the request.
        #
        # @param response_delay [Google::Protobuf::Duration | Hash]
        #   The amount of time to wait before returning a response.
        #   A hash of the same form as `Google::Protobuf::Duration`
        #   can also be provided.
        # @param error [Google::Rpc::Status | Hash]
        #   The error that will be returned by the server. If this code is specified
        #   to be the OK rpc code, an empty response will be returned.
        #   A hash of the same form as `Google::Rpc::Status`
        #   can also be provided.
        # @param success [Google::Showcase::V1::TimeoutResponse | Hash]
        #   The response to be returned that will signify successful method call.
        #   A hash of the same form as `Google::Showcase::V1::TimeoutResponse`
        #   can also be provided.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @yield [result, operation] Access the result along with the RPC operation
        # @yieldparam result [Google::Showcase::V1::TimeoutResponse]
        # @yieldparam operation [GRPC::ActiveCall::Operation]
        # @return [Google::Showcase::V1::TimeoutResponse]
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #
        #   # TODO: Initialize +response_delay+:
        #   response_delay = {}
        #   response = showcase_client.timeout(response_delay)

        def timeout \
            response_delay,
            error: nil,
            success: nil,
            options: nil,
            &block
          req = {
            response_delay: response_delay,
            error: error,
            success: success
          }.delete_if { |_, v| v.nil? }
          req = Google::Gax::to_proto(req, Google::Showcase::V1::TimeoutRequest)
          @timeout.call(req, options, &block)
        end

        # This method is used to setup the Retry method. The given list of retry behavior
        # will be bound to an ID defined by the server. Subsequent Retry requests
        # of the given ID will respond with the behavior specified in this request.
        #
        # @param responses [Array<Google::Rpc::Status | Hash>]
        #   The server will respond in the order that is given in this field.
        #   A hash of the same form as `Google::Rpc::Status`
        #   can also be provided.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @yield [result, operation] Access the result along with the RPC operation
        # @yieldparam result [Google::Showcase::V1::RetryId]
        # @yieldparam operation [GRPC::ActiveCall::Operation]
        # @return [Google::Showcase::V1::RetryId]
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #
        #   # TODO: Initialize +responses+:
        #   responses = []
        #   response = showcase_client.setup_retry(responses)

        def setup_retry \
            responses,
            options: nil,
            &block
          req = {
            responses: responses
          }.delete_if { |_, v| v.nil? }
          req = Google::Gax::to_proto(req, Google::Showcase::V1::SetupRetryRequest)
          @setup_retry.call(req, options, &block)
        end

        # This method is used to show how a client handles errors that can be
        # retried. Requests to a given RetryId will respond in the way specified
        # in SetupRetry method.
        #
        # @param id [String]
        #   An ID which will the given list of responses will be bound to on the
        #   server.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @yield [result, operation] Access the result along with the RPC operation
        # @yieldparam result []
        # @yieldparam operation [GRPC::ActiveCall::Operation]
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #
        #   # TODO: Initialize +id+:
        #   id = ''
        #   showcase_client.retry(id)

        def retry \
            id,
            options: nil,
            &block
          req = {
            id: id
          }.delete_if { |_, v| v.nil? }
          req = Google::Gax::to_proto(req, Google::Showcase::V1::RetryId)
          @retry.call(req, options, &block)
          nil
        end

        # This method is used to show how a client handles a long running operation.
        # Upon receiving a request, the server will create a new ID and mark that
        # the ID created will complete at the time denoted in the request. If the
        # completion time has already passed, the server will return a longrunning
        # operation that signifies a completed operation. Upon subsequent requests
        # to the operations mixin service, if the operation is incomplete, the
        # the server will return metadata denoting the percent that the operation
        # is complete, else the server will return a completed operation that will
        # either denote that the operation has succeeded or failed.
        #
        # @param completion_time [Google::Protobuf::Timestamp | Hash]
        #   The time after which this operation will succeed. If, upon the first,
        #   the time has passed, the initial response will return a completed
        #   operation.
        #   A hash of the same form as `Google::Protobuf::Timestamp`
        #   can also be provided.
        # @param error [Google::Rpc::Status | Hash]
        #   The error that will be returned in the operation signifying a failed
        #   operation. If the OK rpc status code is returned, the operation will
        #   succeed with an empty operation.
        #   A hash of the same form as `Google::Rpc::Status`
        #   can also be provided.
        # @param success [Google::Showcase::V1::LongrunningResponse | Hash]
        #   The response that will be returned upon operation success.
        #   A hash of the same form as `Google::Showcase::V1::LongrunningResponse`
        #   can also be provided.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @return [Google::Gax::Operation]
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #
        #   # TODO: Initialize +completion_time+:
        #   completion_time = {}
        #
        #   # Register a callback during the method call.
        #   operation = showcase_client.longrunning(completion_time) do |op|
        #     raise op.results.message if op.error?
        #     op_results = op.results
        #     # Process the results.
        #
        #     metadata = op.metadata
        #     # Process the metadata.
        #   end
        #
        #   # Or use the return value to register a callback.
        #   operation.on_done do |op|
        #     raise op.results.message if op.error?
        #     op_results = op.results
        #     # Process the results.
        #
        #     metadata = op.metadata
        #     # Process the metadata.
        #   end
        #
        #   # Manually reload the operation.
        #   operation.reload!
        #
        #   # Or block until the operation completes, triggering callbacks on
        #   # completion.
        #   operation.wait_until_done!

        def longrunning \
            completion_time,
            error: nil,
            success: nil,
            options: nil
          req = {
            completion_time: completion_time,
            error: error,
            success: success
          }.delete_if { |_, v| v.nil? }
          req = Google::Gax::to_proto(req, Google::Showcase::V1::LongrunningRequest)
          operation = Google::Gax::Operation.new(
            @longrunning.call(req, options),
            @operations_client,
            Google::Showcase::V1::LongrunningResponse,
            Google::Showcase::V1::LongrunningMetadata,
            call_options: options
          )
          operation.on_done { |operation| yield(operation) } if block_given?
          operation
        end

        # This method is used to show how a client will handle a method that lists
        # responses in a paginated method. The request will specify an ID and the
        # maximum number of responses to return. If the ID has not been seen before
        # the server will mark the ID specified and the maximum number to be
        # returned. The page token will be a stringified integer denoting the
        # the number to start the page at.
        #
        # @param max_response [Integer]
        #   The maximum number that will be returned in the response.
        # @param page_size [Integer]
        #   The maximum number of resources contained in the underlying API
        #   response. If page streaming is performed per-resource, this
        #   parameter does not affect the return value. If page streaming is
        #   performed per-page, this determines the maximum number of
        #   resources in a page.
        # @param page_size_override [Integer]
        #   This field is used to show the client's ability to handle servers that
        #   return a page that is larger the specified page size.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @yield [result, operation] Access the result along with the RPC operation
        # @yieldparam result [Google::Gax::PagedEnumerable<Integer>]
        # @yieldparam operation [GRPC::ActiveCall::Operation]
        # @return [Google::Gax::PagedEnumerable<Integer>]
        #   An enumerable of Integer instances.
        #   See Google::Gax::PagedEnumerable documentation for other
        #   operations such as per-page iteration or access to the response
        #   object.
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #
        #   # TODO: Initialize +max_response+:
        #   max_response = 0
        #
        #   # Iterate over all results.
        #   showcase_client.pagination(max_response).each do |element|
        #     # Process element.
        #   end
        #
        #   # Or iterate over results one page at a time.
        #   showcase_client.pagination(max_response).each_page do |page|
        #     # Process each page at a time.
        #     page.each do |element|
        #       # Process element.
        #     end
        #   end

        def pagination \
            max_response,
            page_size: nil,
            page_size_override: nil,
            options: nil,
            &block
          req = {
            max_response: max_response,
            page_size: page_size,
            page_size_override: page_size_override
          }.delete_if { |_, v| v.nil? }
          req = Google::Gax::to_proto(req, Google::Showcase::V1::PaginationRequest)
          @pagination.call(req, options, &block)
        end

        # This method is used to show how a client will handle configuration to
        # flatten a request. The server will simply echo the request and
        #
        # @param content [String]
        #   Simply a string for content.
        # @param repeated_content [Array<String>]
        #   A list of strings to show how flattening affects repeated fields.
        # @param nested [Google::Showcase::V1::ParameterFlatteningMessage | Hash]
        #   A message to show flattenings that cause a message type to become a param.
        #   A hash of the same form as `Google::Showcase::V1::ParameterFlatteningMessage`
        #   can also be provided.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @yield [result, operation] Access the result along with the RPC operation
        # @yieldparam result [Google::Showcase::V1::ParameterFlatteningMessage]
        # @yieldparam operation [GRPC::ActiveCall::Operation]
        # @return [Google::Showcase::V1::ParameterFlatteningMessage]
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #   response = showcase_client.parameter_flattening

        def parameter_flattening \
            content: nil,
            repeated_content: nil,
            nested: nil,
            options: nil,
            &block
          req = {
            content: content,
            repeated_content: repeated_content,
            nested: nested
          }.delete_if { |_, v| v.nil? }
          req = Google::Gax::to_proto(req, Google::Showcase::V1::ParameterFlatteningMessage)
          @parameter_flattening.call(req, options, &block)
        end

        # This method is used to show how a client will handle request strings that
        # are configured to follow a certain pattern or set of patterns. The server
        # will simply echo the request.
        #
        # @param single_template [String]
        #   This field will have a single template bound to it.
        # @param multiple_templates [String]
        #   This field will be a oneof resource name with many templates bound to it.
        # @param options [Google::Gax::CallOptions]
        #   Overrides the default settings for this call, e.g, timeout,
        #   retries, etc.
        # @yield [result, operation] Access the result along with the RPC operation
        # @yieldparam result [Google::Showcase::V1::ResourceNameMessage]
        # @yieldparam operation [GRPC::ActiveCall::Operation]
        # @return [Google::Showcase::V1::ResourceNameMessage]
        # @raise [Google::Gax::GaxError] if the RPC is aborted.
        # @example
        #   require "google/showcase"
        #
        #   showcase_client = Google::Showcase.new(version: :V1)
        #   formatted_single_template = Google::Showcase::V1::ShowcaseClient.single_path("[ID]")
        #   formatted_multiple_templates = Google::Showcase::V1::ShowcaseClient.first_path("[ID]")
        #   response = showcase_client.resource_name(formatted_single_template, formatted_multiple_templates)

        def resource_name \
            single_template,
            multiple_templates,
            options: nil,
            &block
          req = {
            single_template: single_template,
            multiple_templates: multiple_templates
          }.delete_if { |_, v| v.nil? }
          req = Google::Gax::to_proto(req, Google::Showcase::V1::ResourceNameMessage)
          @resource_name.call(req, options, &block)
        end
      end
    end
  end
end
