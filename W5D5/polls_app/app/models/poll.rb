# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  author_id  :integer          not null
#  title      :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Poll < ApplicationRecord
    validates :author_id, presence: true
    validates :title, presence: true

    belongs_to :author,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :User

    has_many :questions,
        foreign_key: :poll_id

end
