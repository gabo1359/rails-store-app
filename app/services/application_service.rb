# frozen_string_literal: false

# Application service
class ApplicationService
  def self.call(params)
    new(params).call
  end
end
