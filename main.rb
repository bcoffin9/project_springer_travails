require_relative "knight.rb"

springer = Knight.new([4,4])
chain = springer.knight_moves([4,4], [1,1])
springer.print_chain(chain)