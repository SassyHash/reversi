#*- coding: utf-8 -*-
module Reversi

  class Board


  COLUMNS= {
    "A" => 0,
    "B" => 1,
    "C" => 2,
    "D" => 3,
    "E" => 4,
    "F" => 5,
    "G" => 6,
    "H" => 7
  }

  DIRECTIONS =[[1,0],[1,1],[0,1],[0,-1],
              [-1,0],[-1,-1],[1,-1],[-1,1]]

    def self.make_board
      board = Array.new(8){Array.new(8)}
      board[3][3] = :white
      board[4][4] = :white
      board[3][4] = :black
      board[4][3] = :black
      board
    end

    attr_reader :board, :player1

    def initialize(board = Board.make_board)
      @board = board
      @player1, @player2 = Player.new(:white), Player.new(:black)
      @valid = false
    end

    def print_board
      print "   "
      COLUMNS.keys.each {|letter| print " #{letter} "}
      puts ""
      puts "   -----------------------  "
      @board.each_with_index do |line, line_index|
        print "#{line_index+1} |"
        line.each do |square|
          case square
          when nil then print " \u2610 "
          when :white then print " ☆ "
          when :black then print " ★ "
          end
        end
        puts ''
      end
    end

    def play
      until win?
        [@player1, @player2].each do |current_player|
          if has_moves?(current_player)
            print_board
            current_player.get_move(self)
          else
            next
          end
        end
      end
    end

    def has_moves?(current_player)
      color = current_player.color
      @board.each_with_index do |row, row_i|
        row.each_with_index do |square, square_i|
          next unless square.nil?
          @valid = false
          change_path_tiles(row_i, square_i, color)
          return true if @valid
        end
      end
      false
    end

    def win?
      has_moves?(@player1) || has_moves?(@player2)
    end

    def make_move(indices, color)
      row, column = (indices[0]-1), COLUMNS[indices[1]]
      @board[row][column] = color
      @valid = false
      change_path_tiles(row, column, color)
      raise "illegal move" unless @valid
    end

    def change_path_tiles(row, column, color)
      target = [row, column]

      DIRECTIONS.each do |direction|
        take_these = []
        row, column = row + direction[0], column + direction[1]

        while @board[row][column] != color && @board[row][column]
          take_these << [row,column]
          row, column = row + direction[0], column + direction[1]
        end

        if @board[row][column] == color
          take_these.each do |indices|
            @valid = true
            @board[indices[0]][indices[1]] = color
          end
        end

        row, column = target[0], target[1]
      end
    end

  end

  class Player
    attr_reader :color

    def initialize(color)
      @color = color
    end

    def get_move(game)
      input = gets
      game.make_move(input, self.color)
    end

  end

end





