#!/usr/bin/env ruby
require_relative 'creature.rb'

class Gobelin < Creature
  def encaisser(damage)
    self.health = health - damage / 2
  end
end
