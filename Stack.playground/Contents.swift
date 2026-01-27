import Foundation

//: #### Array based implementation
class ArrayStack<Element> {
    private var store: [Element]
    
    var isEmpty: Bool {
        return store.isEmpty
    }
    
    var count: Int {
        return store.count
    }
    
    init(store: [Element] = []) {
        self.store = store
    }
    
    func push(_ element: Element) {
        store.append(element)
    }
    
    func pop() -> Element? {
        guard !store.isEmpty else { return nil }
        return store.removeLast()
    }
    
    func peek() -> Element? {
        return store.last
    }
}

var s1 = ArrayStack<Int>()
s1.isEmpty
s1.peek()
s1.push(5)
s1.peek()
s1.isEmpty

class LinkedListStack<Element> {
    private class Node {
        var value: Element
        var next: Node?
        
        init(value: Element, next: Node? = nil) {
            self.value = value
            self.next = next
        }
    }
    
    private var head: Node?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    private(set) var count: Int = 0
    
    func push(_ element: Element) {
        let newElement = Node(value: element, next: head)
        head = newElement
        count += 1
    }
    
    func pop() -> Element? {
        let element = head
        head = head?.next
        count = max(0, count - 1)
        return element?.value
    }
    
    func peek() -> Element? {
        return head?.value
    }
}

var s2 = LinkedListStack<Int>()
s2.isEmpty
s2.peek()
s2.push(5)
s2.peek()
s2.isEmpty
s2.push(10)
s2.push(20)
s2.count
s2.pop()
