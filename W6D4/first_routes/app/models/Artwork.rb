# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord 
    validates :title, presence: true, uniqueness: { scope: :artist_id }
    validates :image_url, presence: true 
    validates :artist_id, presence: true


    belongs_to :artist,
        foreign_key: :artist_id,
        class_name: :User

    has_many :collection_pieces, 
        foreign_key: :artwork_id
    
    has_many :collections, 
        through: :collection_pieces,
        source: :collection 

    has_many :artwork_shares, 
        foreign_key: :artwork_id,
        class_name: :ArtworkShare,
        dependent: :destroy
    
    has_many :shared_viewers,
        through: :artwork_shares, 
        source: :viewer

    has_many :comments, 
        foreign_key: :artwork_id,
        dependent: :destroy

    has_many :likes, as: :likeable

    has_many :likers,
        through: :likes, 
        source: :user 



end
