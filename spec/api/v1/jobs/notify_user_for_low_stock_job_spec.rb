# frozen_string_literal: false

require 'rails_helper'

RSpec.describe NotifyUserForLowStockJob, type: :job do
  it 'have an enqueued job' do
    product = create(:product)
    user = create(:user)
    create(:like, product_id: product.id, user_id: user.id)
    ActiveJob::Base.queue_adapter = :test
    expect { described_class.perform_later(product.id) }.to have_enqueued_job
  end
end
