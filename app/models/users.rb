class Users < ActiveRecord::Base
  validates :name, :presence => true
  scope :active, -> { where( :active => true ) }
  scope :inactive, -> { where( :active => false ) }
end
