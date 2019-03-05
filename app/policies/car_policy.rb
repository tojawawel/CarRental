class CarPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    is_owner?
  end

  def destroy?
    is_owner?
  end

  def show?
    true
  end

  private
  def is_owner?
    user == record.user
  end
end
