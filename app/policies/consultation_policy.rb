# frozen_string_literal: true

class ConsultationPolicy < ApplicationPolicy
  def index?
    user.admin? || user.professional? || user.patient?
  end

  def show?
    return true if user.admin?
    return true if user.professional? && record.professional_id == user.id
    return true if user.patient? && record.patient_id == user.id

    false
  end

  def create?
    user.admin? || user.professional?
  end

  def update?
    user.admin? || (user.professional? && record.professional_id == user.id)
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      return scope.all if user.admin?
      return scope.where(professional_id: user.id) if user.professional?
      return scope.where(patient_id: user.id) if user.patient?

      scope.none
    end
  end
end
