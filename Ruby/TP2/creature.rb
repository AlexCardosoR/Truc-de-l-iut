#!/usr/bin/env ruby
class Creature
  attr_accessor :name, :health

  def initialize(name, health)
    @name = name
    @health = health
  end

  def encaisser(damage)
    self.health = health - damage
  end

  def to_s
    "Je suis #{name}, j'ai #{health} point de vie."
  end

  def soigner(pv)
    self.health = health + pv
  end
end

