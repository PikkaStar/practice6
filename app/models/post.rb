class Post < ApplicationRecord
  belongs_to :customer

  validates :title,presence: true
  validates :body,presence: true,length: {minimum: 2}


end