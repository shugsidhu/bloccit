class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  before_save { self.email = email.downcase if email.present? }
  before_save :format_name
  before_save { self.role ||= :member }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_nil

  def password_digest_nil
    password_digest.nil?
  end

  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }


  has_secure_password

  enum role: [:member, :admin]


  def format_name
    if name
      names_array = []
      name.split.each do |names|
        names_array << names.capitalize
      end
      self.name = names_array.join(' ')
    end
  end
end
