class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products
  belongs_to :customer
  # def products
  #   product_ids = OrderProduct.where(order_id: id).pluck(:product_id)
  #   Product.find(product_ids)
  # end
  validates :status, presence:true, inclusion: { in: ["pending", "shipped"] }

  scope :in_stock, -> (order_id) { find(order_id).products.where("inventory > ?", 0) }
  # scope :out_of_stock, -> (order_id) { find(order_id).products.outOfStock }


  def shippable?
    status != "shipped" && products.count >= 1
  end

  def ship
    shippable? && update(status: "shipped")
  end
end
