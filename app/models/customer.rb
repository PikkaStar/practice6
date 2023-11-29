class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_image

  has_many :posts,dependent: :destroy
  has_many :post_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy

  validates :name,presence: true,length: {minimum: 2}
  validates :introduction,length: {maximum: 200}

  def get_profile_image(width,height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width,height]).processed
    else
      "no_image"
    end
  end



end
