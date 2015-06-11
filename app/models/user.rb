class User < ActiveRecord::Base
  include PgSearch
  after_initialize :ensure_session_token

  validates :session_token, :email, :password_digest, presence: true
  validates :session_token, :email, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many(:authored_books,
           class_name: "Book",
           foreign_key: :author_id,
           primary_key: :id,
           inverse_of: :author
           )

  has_many :collections

  has_many(:comments,
           class_name: "Comment",
           foreign_key: :commenter_id,
           primary_key: :id,
           inverse_of: :commenter
           )
            
  has_many(:comments_on,
           class_name: "Comment",
           foreign_key: :commentable_id,
           primary_key: :id,
           as: :commentable
          )

  pg_search_scope :search_on_fname_lname, against: [:fname, :lname]

  attr_reader :password

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)

    user && user.is_password?(password) ? user : nil
  end

  def self.find_or_create_by_auth_hash(auth_hash)
    user = User.find_by(
            provider: auth_hash[:provider],
            uid: auth_hash[:uid])

    unless user
      user = User.create!(
            provider: auth_hash[:provider],
            uid: auth_hash[:uid],
            email: auth_hash[:info][:email], 
            password: SecureRandom::urlsafe_base64)
    end

    user
  end

  def generate_token
    random_token = SecureRandom.base64(16)

    until self.session_token != random_token
      random_token = SecureRandom.base64(16)
    end

    random_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password).to_s
  end

  def ensure_session_token
    self.session_token ||= generate_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_token
    self.save!
    self.session_token
  end


end
