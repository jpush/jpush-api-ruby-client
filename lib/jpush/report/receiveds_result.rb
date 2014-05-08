
module JPush

  class ReceivedsResult
    ERROR_CODE_OK = 0
    RESPONSE_OK = 200
    def self.result(response_result)
      receiveds_result = {'is_result_ok' => response_result[:response_code] == RESPONSE_OK,
                        'rate_limit_quota' => response_result[:x_rate_limit_limit],
                        'rate_limit_remaining' => response_result[:x_rate_limit_remaining],
                        'rate_limit_reset' => response_result[:x_rate_limit_reset],
                        'received_list' => response_result[:response_content]
                        }
      receiveds_result
    end
  end
end