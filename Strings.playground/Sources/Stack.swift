public struct Stack<Type> {
    private var store = [Type]()
    
    public init() { }
    
    public mutating func push(_ element: Type) {
        store.append(element)
    }
    
    public mutating func pop() -> Type? {
        guard !store.isEmpty else { return nil }
        return store.removeLast()
    }
    
}
