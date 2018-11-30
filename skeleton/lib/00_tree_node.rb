class PolyTreeNode
    
    
    def initialize(val)
        @value = val
        @parent = nil
        @children = []
    end

    def parent
        @parent
    end

    def parent=(node)
        prev_parent = self.parent
        if prev_parent
            prev_parent.children.delete(self)
        end
        @parent = node
        unless node == nil
            node.children << self unless node.children.include?(self)
        end
    end

    def add_child(node)
        node.parent = self
    end

    def remove_child(node)
        if self.children.include?(node) 
            node.parent = nil 
        else
            raise "u wot"
        end
    end

    def children
        @children
    end

    def value
        @value
    end

    def dfs(target_value)
        return self if self.value == target_value
        
        self.children.each do |child|
            dfs_answer = child.dfs(target_value)
            return dfs_answer if dfs_answer  
        end

        nil
    end

    def bfs(target_value)
        queue = [self]

        until queue.empty?
            check_node = queue.shift
            return check_node if check_node.value == target_value
            queue += check_node.children 
        end
        nil
    end

end