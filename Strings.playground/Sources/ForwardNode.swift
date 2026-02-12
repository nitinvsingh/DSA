public class ForwardNode<NodeType> {
    public var value: NodeType
    public var next: ForwardNode<NodeType>?
    
    public init(value: NodeType) {
        self.value = value
    }
}

extension ForwardNode: Visualizable where NodeType: CustomStringConvertible {
    public func visualize() {
        var head: ForwardNode<NodeType>? = self
        while let nodeValue = head?.value {
            print(nodeValue.description, terminator: " -> ")
            head = head?.next
        }
        print("EndOfList")
    }
}
