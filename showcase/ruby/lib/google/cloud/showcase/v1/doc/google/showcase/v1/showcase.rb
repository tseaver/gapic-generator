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

module Google
  module Showcase
    ##
    # # GAPIC Showcase API Contents
    #
    # | Class | Description |
    # | ----- | ----------- |
    # | [ShowcaseClient][] | A service to showcase Generated API Client features and common API patterns used by Google. |
    # | [Data Types][] | Data types for Google::Cloud::Showcase::V1 |
    #
    # [ShowcaseClient]: https://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-showcase/latest/google/showcase/v1/showcaseclient
    # [Data Types]: https://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-showcase/latest/google/showcase/v1/datatypes
    #
    module V1
      # The request message used for the Echo, Collect and Chat methods. If content
      # is set in this message then the request will succeed. If a status is
      # @!attribute [rw] content
      #   @return [String]
      #     The content to be echoed by the server.
      # @!attribute [rw] error
      #   @return [Google::Rpc::Status]
      #     The error to be thrown by the server.
      class EchoRequest; end

      # The response message for the EchoService methods.
      # @!attribute [rw] content
      #   @return [String]
      #     The content specified in the request.
      class EchoResponse; end

      # The request message for the Expand method.
      # @!attribute [rw] content
      #   @return [String]
      #     The content that will be split into words and returned on the stream.
      # @!attribute [rw] error
      #   @return [Google::Rpc::Status]
      #     The error that is thrown after all words are sent on the stream.
      class ExpandRequest; end

      # The request for Showcase Timeout method.
      # @!attribute [rw] response_delay
      #   @return [Google::Protobuf::Duration]
      #     The amount of time to wait before returning a response.
      # @!attribute [rw] error
      #   @return [Google::Rpc::Status]
      #     The error that will be returned by the server. If this code is specified
      #     to be the OK rpc code, an empty response will be returned.
      # @!attribute [rw] success
      #   @return [Google::Showcase::V1::TimeoutResponse]
      #     The response to be returned that will signify successful method call.
      class TimeoutRequest; end

      # The response for Showcase Timeout method.
      # @!attribute [rw] content
      #   @return [String]
      #     This content can contain anything, the server will not depend on a value
      #     here.
      class TimeoutResponse; end

      # The request for the Showcase SetupRetry method.
      # @!attribute [rw] responses
      #   @return [Array<Google::Rpc::Status>]
      #     The server will respond in the order that is given in this field.
      class SetupRetryRequest; end

      # The ID which a given list of responses will be bound to.
      # @!attribute [rw] id
      #   @return [String]
      #     An ID which will the given list of responses will be bound to on the
      #     server.
      class RetryId; end

      # The request for the Showcase Longrunning method.
      # @!attribute [rw] completion_time
      #   @return [Google::Protobuf::Timestamp]
      #     The time after which this operation will succeed. If, upon the first,
      #     the time has passed, the initial response will return a completed
      #     operation.
      # @!attribute [rw] error
      #   @return [Google::Rpc::Status]
      #     The error that will be returned in the operation signifying a failed
      #     operation. If the OK rpc status code is returned, the operation will
      #     succeed with an empty operation.
      # @!attribute [rw] success
      #   @return [Google::Showcase::V1::LongrunningResponse]
      #     The response that will be returned upon operation success.
      class LongrunningRequest; end

      # The metadata for the Showcase Longrunning method.
      # @!attribute [rw] time_remaining
      #   @return [Google::Protobuf::Duration]
      #     The amount of time remaining on this operation.
      class LongrunningMetadata; end

      # The final operation response for the Showcase Longrunning
      # method.
      # @!attribute [rw] content
      #   @return [String]
      #     The response that will be returned for a successful operation.
      class LongrunningResponse; end

      # The request for the Showcase Pagination.
      # @!attribute [rw] max_response
      #   @return [Integer]
      #     The maximum number that will be returned in the response.
      # @!attribute [rw] page_size
      #   @return [Integer]
      #     The amount of numbers to returned in the response.
      # @!attribute [rw] page_token
      #   @return [String]
      #     The position of the page to be returned. This will be a stringified int
      #     that will signifiy where to start the page from. Anything other than
      #     a stringified integer within the range of 0 and the max_response will
      #     cause an error to be thrown. This value is a string as opposed to a int32
      #     to follow general google api practices.
      # @!attribute [rw] page_size_override
      #   @return [Integer]
      #     This field is used to show the client's ability to handle servers that
      #     return a page that is larger the specified page size.
      class PaginationRequest; end

      # The response for the Showcase Pagination method.
      # @!attribute [rw] responses
      #   @return [Array<Integer>]
      #     An increasing list of responses starting at the value specified by the
      #     page token. If the page token is empty, then this list will start at 0.
      # @!attribute [rw] next_page_token
      #   @return [String]
      #     The next integer stringified.
      class PaginationResponse; end

      # The request and response message for the Showcase ParameterFlattening.
      # @!attribute [rw] content
      #   @return [String]
      #     Simply a string for content.
      # @!attribute [rw] repeated_content
      #   @return [Array<String>]
      #     A list of strings to show how flattening affects repeated fields.
      # @!attribute [rw] nested
      #   @return [Google::Showcase::V1::ParameterFlatteningMessage]
      #     A message to show flattenings that cause a message type to become a param.
      class ParameterFlatteningMessage; end

      # The request and response message for the Showcase ResourceName method.
      # @!attribute [rw] single_template
      #   @return [String]
      #     This field will have a single template bound to it.
      # @!attribute [rw] multiple_templates
      #   @return [String]
      #     This field will be a oneof resource name with many templates bound to it.
      class ResourceNameMessage; end
    end
  end
end