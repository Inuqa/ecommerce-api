class Order < ApplicationRecord
  enum status: { pendiente: 0, pagado: 1, enviado: 2, cancelado: 3 }
  belongs_to :user
  has_many :line_items, dependent: :destroy

  scope :filter_by_status, ->(status) { where status: status }

  scope :filter_by_email, ->(email) { joins(:user).where("user.email": email) }

  scope :filter_by_id, ->(id) { where id: id }

  validates :name, :last_name, :address, :city, :comuna, :phone, :status, presence: true

  def payed_mail
    @order = Order.find(id)
    OrderMailer.with(order: @order).order_payed.deliver_later
  end

  def status_payed?
    status == 'pagado'
  end
end
