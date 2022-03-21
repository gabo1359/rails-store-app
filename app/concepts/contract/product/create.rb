module Contract::Product
  class Create < Reform::Form
    property :sku
    property :name
    property :description
    property :price
    property :stock

    validates_uniqueness_of :sku
    validates :sku, presence: true
    validates :name, presence: true
    validates :descrption, presence: true
    validates :price, presence: true
    validates :stock, presence: true
  end
end
