class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #1:Nの１側の記述
  #一人のユーザーがN個の投稿をおこなっている。このユーザーが消えたら、自動的にそのユーザーの投稿も全て消える。
  has_many :post_images, dependent: :destroy
  #一人のユーザーがN個のコメントを投稿できる。このユーザーが消えたら、自動的にそのユーザーのコメントも全て消える。
  has_many :post_comments, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io:File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
