class ApplicationService
  def self.call(params)
    puts params, 'params'
    new(params).call
  end
end