class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    return unless user.present?

    can :manage, Post, author_id: user.id # and delete them if they are the author

    can :manage, Comment, author_id: user.id # and delete them if they are the author

    can :create, Like # logged in users can create likes
    return unless user.role == 'admin'

    can :manage, :all
  end
end
