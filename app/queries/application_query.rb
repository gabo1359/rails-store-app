# frozen_string_literal: false

# Application query
class ApplicationQuery
  def self.call(params)
    new(params).call
  end
end
