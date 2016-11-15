# world phsyics
class Physics
  extend Observable

  def initialize(object)
    @object = object
    self.class.add_observer self
  end

  def self.call
    descendants.each &:changed
    descendants.each &:notify_observers
  end

  def self.[](law)
    const_get(law.capitalize)
  end

  def update
    raise 'implement update on your physics subclass'
  end
end

class Physics::Gravity < Physics
  THE_CONSTANT_DOWNWARD_PULL = 7

  def update
    @object.move :down, THE_CONSTANT_DOWNWARD_PULL
  end
end

class Physics::Velocity < Physics
  def update
    # what happens to an object with up 2 that gains up 3?  how about down 2?
    @object.velocities.each do |direction, speed|
      @object.move direction, sped
    end
  end
end

class Physics::Friction < Physics
  # walking on ground should slow player
  # walking on platform should be just like ground
  # moving platform should not slip away from player, but have otherwise normal friction.
end