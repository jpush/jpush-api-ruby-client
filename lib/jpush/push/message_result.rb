
module JPush

  class MessageResult
    ERROR_CODE_OK = 0
    RESPONSE_OK = 200
    def self.result(response_result)
      message_result = {'is_result_ok' => response_result[:response_code] == RESPONSE_OK && response_result[:response_content]['errcode'] == ERROR_CODE_OK,
                        'rate_limit_quota' => response_result[:x_rate_limit_limit],
                        'rate_limit_remaining' => response_result[:x_rate_limit_remaining],
                        'rate_limit_reset' => response_result[:x_rate_limit_reset],
                        'message_id' => response_result[:response_content]['msg_id'],
                        'send_no' => response_result[:response_content]['sendno'],
                        'error_code' =>  response_result[:response_content]['errcode'],
                        'error_message' =>response_result[:response_content]['errmsg']
                       }
      message_result
    end

  end
end