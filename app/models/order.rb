class Order < ApplicationRecord
  has_many_through :order_product
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
