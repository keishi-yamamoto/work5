class Relationship < ApplicationRecord
  # 参照したいクラス名、実際のクラス名
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
