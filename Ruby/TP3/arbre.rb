#!/usr/bin/env ruby


class Arbre
	def initialize(val)
		@val=val
		@fils=Array.new(2)
	end
	
	def add(nb)
		
		if (@fils.empty || nb>@fils.first)
			@fils.push(nb)
		else
			@fils.insert(0,nb)
		end
		
		if (@fils.length==2 && nb>@fils.first)
			@fils[1].add(nb)
		else
			@fils[0].add(nb)
		end
		
	end
	
	def to_s()
		return "#{@val}=>#{@fils}"
	end
	
	def suppr(nb)
	
	end
end

rd = Random.new

a = Arbre.new(rd.rand(100))
10.times {a.add(rd.rand(100))}

a.each {|i| puts i.to_s}
