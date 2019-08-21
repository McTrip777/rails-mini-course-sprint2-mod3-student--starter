class Order < ApplicationRecord
  has_many :orders, through: :order_product
  has_many :order_products
  belongs_to :customer
  def products
    product_ids = OrderProduct.where(order_id: id).pluck(:product_id)
    Product.find(product_ids)
  end

  def shippable?
    status != "shipped" && products.count >= 1
  end

  def ship
    shippable? && update(status: "shipped")
  end
end
