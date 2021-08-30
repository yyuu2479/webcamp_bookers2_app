class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book

  has_many :book_comments, dependent: :destroy

  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed

  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower

  has_many :entrys, dependent: :destroy
  has_many :messages, dependent: :destroy

  attachment :profile_image

  validates :name, uniqueness: true, length:{in:2..20}
  validates :introduction, length:{maximum: 50}



  # フォローするメゾット
  def follow(user_id)
    self.follower.create(followed_id: user_id)
  end

  # フォロー外すメゾット
  def unfollow(user_id)
    self.follower.find_by(followed_id: user_id).destroy
  end

  # フォローしているか確認するメゾット
  def following?(user_id)
    self.following_user.include?(user_id)
  end

end
