#!/usr/bin/env ruby
require_relative 'creature'
require_relative 'troll'
require_relative 'gobelin'

class Compagnie
  attr_accessor :aventuriers
  def initialize
    @aventuriers = []
  end

  def add_aventurier(new_aventurier)
    @aventuriers.map do |x|
      if new_aventurier.name == x
        raise 'Attention homonyme'
      end
    end
    @aventuriers.push new_aventurier
  end		

  def to_s
    aventuriers.join("\n")
  end

  def clean 
    @aventruriers.reject{|x| a.health <= 0}
  end
  
  def exploration
    aventuriers[0].encaisser(10)
    clean
    
  end
end

comp = Compagnie.new
comp.add_aventurier(Troll.new('Gruck', 27))
comp.add_aventurier(Troll.new('Grock', 24))
comp.add_aventurier(Gobelin.new('Zack', 12))
comp.add_aventurier(Gobelin.new('Zog', 13))

puts "Début: \n#{comp}"
comp.exploration
puts "\nExploration: \n#{comp}"
