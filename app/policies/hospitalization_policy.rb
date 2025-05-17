# frozen_string_literal: true

class HospitalizationPolicy < ApplicationPolicy
  def index?
    user.admin? || user.professional? || user.patient?
  end

  def show?
    user.admin? || 
    (user.professional? && record.professional_id == user.id) || 
    (user.patient? && record.patient_id == user.id)
  end

  def create?
    user.admin? || user.professional?
  end

  def update?
    user.admin? || 
    (user.professional? && record.professional_id == user.id)
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.professional?
        scope.where(professional_id: user.id)
      elsif user.patient?
        scope.where(patient_id: user.id)
      else
        scope.none
      end
    end
  end
end 