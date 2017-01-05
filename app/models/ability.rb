class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin == true
      can :manage, User
    else
      can :read, :all
    end
  end
end
