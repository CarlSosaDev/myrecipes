class Message < ApplicationRecord

    belongs_to :chef
    validates :chef_id, presence: true
    validates :content, presence: true

def self.most_recent
 order(:created_at).last(20)

end

end
