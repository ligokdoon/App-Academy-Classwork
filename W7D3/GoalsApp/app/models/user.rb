class User < ApplicationRecord

    validates :username, :session_token, presence: true, uniqueness: true 
    validates :password_digest, presence: true 
    validates :password, length: { minimum: 6, allow_nil: true }

    attr_reader :password

    after_initialize :ensure_session_token #maybe use before_validation

    def self.generate_session_token 
        SecureRandom::urlsafe_base64(16)
    end

    def ensure_session_token 
        self.session_token ||= User.generate_session_token 
    end

    def password=(password)
        @password = password 
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        bc_password_digest = BCrypt::Password.new(self.password_digest)
        bc_password_digest.is_password?(password)
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return user if user && user.is_password?(password)
        nil 
    end
    
    has_many :goals,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Goal

    has_many :cheers,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Cheer

    has_many :comments,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :Comment

    has_many :profile_comments

    has_many :goal_comments,
        through: :goals,
        source: :comments

    has_many :cheers_on_own_goals,
        through: :goals,
        source: :cheers

    has_many :goals_cheered,
        through: :cheers,
        source: :goal

    
end
