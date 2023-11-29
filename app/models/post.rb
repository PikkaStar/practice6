class Post < ApplicationRecord
  belongs_to :customer
  has_many :post_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy

  validates :title,presence: true
  validates :body,presence: true,length: {minimum: 2}

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end


end
