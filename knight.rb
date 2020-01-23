require_relative "node.rb"

class Knight
    attr_reader :position
    def initialize pos=[1,1]
        @position = pos
    end

    #level order, iteration
    #going to do recursion and store the min answer in each call
    #depth first could creat infinite loop (stack overflow) if it drills down on the left
    def knight_moves start, target
        raise StandardError.new("Invalid ending space") if validate_space(target)
        root = Node.new(start, nil)
        target_acquired = nil
        queue = [root]
        return queue if root.position == target
        
        #build the structure to be searched
        puts "I am right before the while loop"
        while(!queue.empty? && !target_acquired)
            current = queue[0]
            potential_moves = get_possible_moves(current.position)
            potential_moves.each do |move|
                new_node = Node.new(move, current)
                current.children.push(new_node)
                queue.push(new_node)
                target_acquired = new_node if new_node.position == target
                puts "FOUND IT MOFO" if new_node.position == target
            end
            queue.shift
        end

        #search the structure, start with target node and go up parent
        current = target_acquired
        path = [current]
        while current.parent
            path.push(current.parent)
            current = current.parent
        end
        return path.reverse!
    end

    def get_possible_moves pos
        moves = []
        8.times do |num|
            modifier = calculate_move(num)
            new_position = [pos[0] + modifier[0], pos[1] + modifier[1]]
            moves.push(new_position) unless validate_space(new_position)
        end
        return moves
    end

    def calculate_move num
        case num
        when 0
            return [1,2]
        when 1
            return [2,1]
        when 2
            return [2,-1]
        when 3
            return [1,-2]
        when 4
            return [-1,-2]
        when 5
            return [-2,-1]
        when 6
            return [-2,1]
        when 7
            return [-1,2]
        else
            raise StandardError.new("Error in generating modifier")
        end
    end


    def validate_space space
        res = false
        res = (space[0] > 8 || space[0] < 1) || (space[1] > 8 || space[1] < 1) ? true : false
        return res
    end

    def print_chain arr
        puts "You can get there in #{arr.length-1} move(s)"
        puts "Here is the chain"
        arr.each { |pos| puts pos.position.to_s}
    end
end