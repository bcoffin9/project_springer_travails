class Node
    attr_accessor :position, :parent, :children
    def initialize(position, parent)
        @position = position
        @parent = parent
        @children = []
    end

end