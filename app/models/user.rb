class User < ActiveRecord::Base
  after_initialize :ensure_session_token

  validates :session_token, :email, :password_digest, presence: true
  validates :session_token, :email, uniqueness: true

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)

    user && user.is_password?(password) ? user : nil
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