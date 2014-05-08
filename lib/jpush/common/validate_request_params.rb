
module JPush

  module ValidateRequestParams
    PUSH_PATTERNS = /[^a-zA-Z0-9]/
    MSGID_PATTERNS = /[^0-9, ]/

    def self.checkPushParams(appKey, masterSecret)
      if (appKey.to_s.length != 24 || masterSecret.to_s.length != 24 ||
          PUSH_PATTERNS.match( appKey) || PUSH_PATTERNS.match( masterSecret))
        raise ArgumentError, 'appKey and masterSecret format is incorrect.
                              They should be 24 size, and be composed with alphabet and numbers.
                              Please confirm that they are coming from JPush Web Portal.'
      end
    end
    def self.checkReportParams( msgIds)
      if (MSGID_PATTERNS.match( msgIds))
        raise ArgumentError, 'msgIds param format is incorrect.
                              It should be msg_id (number) which response from JPush Push API.
                              If there are many, use \',\' as interval.'
      end
    end

  end
end