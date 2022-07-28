# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Article < ApplicationRecord
  include Validatable
  has_many :comments, inverse_of: :article
  accepts_nested_attributes_for :comments, allow_destroy: true
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }  
end
