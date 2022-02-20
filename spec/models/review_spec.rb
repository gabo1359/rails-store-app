# frozen_string_literal: false

require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'review model validation' do
    it 'must have a title' do
      review = build(:review, title: '').save
      expect(review).to eq(false)
    end

    it 'must have a rating' do
      review = build(:review, rating: '').save
      expect(review).to eq(false)
    end

    it 'must have a rating between 1 and 5' do
      review = create(:review)
      expect(review.rating).to be_between(1, 5)
    end
  end
end
