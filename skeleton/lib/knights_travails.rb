require_relative '00_tree_node'

class KnightPathFinder
    DELTAS = [
        [1,2],
        [2,1],
        [-1,2],
        [-2,1],
        [-2,-1],
        [-1,-2],
        [1,-2],
        [2,-1]
    ]

    attr_accessor :visited_positions

    def initialize(starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
        @visited_positions = [@root_node]
    end

    def self.valid_moves(pos)
        next_pos = []
        DELTAS.each do |delta|
            new_pos = [(pos.first + delta.first),(pos.last + delta.last)]
            next_pos << new_pos unless new_pos.any? { |num| num > 7 || num < 0 }
        end
        next_pos
    end

    def new_move_positions(pos)
        self.valid_moves(pos).reject do |move| 
            visited_positions.include?(move) 
        end
    end

    def build_move_tree
        queue = [@root_node]
        next_move_arr = self.new_move_positions(visited_positions[-1].value)

        until queue.empty?
            check_node = queue.shift
            visited_positions << check_node

            next_move_arr = self.new_move_positions(check_node.value)
            next_move_arr.each do |position|
                new_node = PolyTreeNode.new(position)
                new_node.parent = check_node
            end
            queue += check_node.children
        end
        @root_node
    end


end

