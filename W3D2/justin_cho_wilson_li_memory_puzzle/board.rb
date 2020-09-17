require_relative "card.rb"
require "byebug"

class Board 

    attr_accessor :grid, :deck
    def initialize(n=5) #n must be odd right now
        @grid = Array.new(n) { Array.new(n, " ") }#spacing?
        @deck = []
        @size = (n-1)**2
        deck_setup
        grid_setup
        populate
    end

    def deck_setup
        alphabet = ("A".."Z").to_a
        deck1 = []
        deck2 = []
        (@size/2).times do 
        char = alphabet.sample
        alphabet.delete(char)
        deck1 << Card.new(char)
        deck2 << Card.new(char)
        end
        @deck = deck1 + deck2
    end
    

    def grid_setup
        @grid[0] = [" "]
        (0..@grid.length - 2).each do |ele|
            @grid[0] << ele
        end

        i = 0
        (1...@grid.length).each do |row_num|
            @grid[row_num][0] = i 
            i += 1
        end
    end

    def [](position)
        @grid[position[0]][position[1]]
    end

    def []=(position, value)
        @grid[position[0]][position[1]] = value 
    end

    def render
        print = @grid.map do |row| 
            row.map do |ele| 
                if ele.is_a? Card 
                    if ele.face_up?
                        ele.face_value 
                    else 
                        " "
                    end
                else
                    ele
                end
            end
        end

        print.each do |row|
            puts row.join(" ")
        end
    end

#   0 1 2 3
# 0
# 1
# 2
# 3

    def populate
        alphabet = ("A".."Z").to_a
        until @grid.flatten.count(" ") == 1
            rand1, rand2, = rand(1...@grid.length), rand(1...@grid.length)

            pos = [rand1, rand2]
            
            if !self[pos].is_a? Card
                self[pos] = @deck[0]
                @deck.rotate!(1)
            end
        end
    end

    #8 card instances -> N=true, N=true 
    # S=> false
    # S =/ X => false
    # X=> true   X => true
    #16 characters 
    def won?
        @deck.all? {|card| card.face_up? }
    end

    def reveal(guessed_pos) #[i,i2]
        if !self[guessed_pos].face_up?
            self[guessed_pos].reveal
            return self[guessed_pos].face_value
        end
    end




end


#   0 1 2 3
# 0
# 1
# 2
# 3