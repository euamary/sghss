# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  audited only: [:name, :phone, :company_id, :role_id, :email_address]

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end

  def add_role(role_name)
    role = Role.find_by(name: role_name)
    return false unless role
    user_roles.create(role: role) unless has_role?(role_name)
  end

  def remove_role(role_name)
    role = Role.find_by(name: role_name)
    return false unless role
    user_roles.find_by(role: role)&.destroy
  end

  def admin?
    has_role?('admin')
  end
end
