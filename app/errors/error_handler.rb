module ErrorHandler
  def self.included(clazz)
    clazz.class_eval do
      rescue_from StandardError do |e|
        respond(:standard_error, 500, e.to_s)
      end
      rescue_from ArgumentError do |e|
        respond('base', 422, e.to_s)
      end
      rescue_from ActiveRecord::RecordNotFound do |e|
        respond('base', 404, e.to_s)
      end
      rescue_from CustomError do |e|
        respond(e.error, e.status, e.message.to_s)
      end
      rescue_from Pundit::NotAuthorizedError do |e|
        respond(:base, 403, 'You cannot perform this action.')
      end
    end
  end

  def errors_array(errors)
    errors_a = []
    errors.each do |e, v|
      v = [v].flatten
      v.each do |message|
        json = { field_name: e, message: message }
        errors_a << json
      end
    end
    errors_a
  end

  private

  def respond(error, status, message) 
    json = Helpers::Render.json(error, message)
    render json: json, status: status
  end
end
