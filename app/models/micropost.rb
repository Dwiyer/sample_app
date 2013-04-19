class Micropost < ActiveRecord::Base
  attr_accessible :content, :publish
  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, presence: true
  belongs_to :user
  default_scope order: 'microposts.created_at DESC'#designate the order of the query result, like 'user.microposts'

  def self.from_users_followed_by(user)
    followed_user_ids="select followed_id from relationships
			where follower_id=:user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id=:user_id", 
	user_id: user.id)
  end
end
