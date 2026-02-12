import Foundation

//: #### Array based implementation
final class ArrayStack<Element> {
    private var store: [Element]
    
    var isEmpty: Bool {
        return store.isEmpty
    }
    
    var count: Int {
        return store.count
    }
    
    init() {
        store = []
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
    
    func debug() -> [Element] {
        return store
    }
}

var s1 = ArrayStack<Int>()
s1.isEmpty
s1.peek()
s1.push(5)
s1.peek()
s1.isEmpty

final class LinkedListStack<Element> {
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
    
    init() { }
    
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

//: # Infix, Postfix and Prefix notations
//:
//: Infix expression -> x + y
//: Prefix expression -> +xy
//: Postfix expression -> xy+
//:
//: Some advantages of prefix/postfix
//: - Do not require paranthesis, precendence and associativity rules.\
//: - Can be evaluated by traversing any expression just once. Infix\ requires more passes to evaluate.
//: #### Precedence and Associativity
//: Operators have an assigned precedence. While evaluating expressions, this precedence helps decide how the expression with several operators will be evaluated.
//: Higher precendence operators will be evaluated before lower precedence operators.
//: In case an expression has more than one operators with same precedence, the expression is evaluated by the associativity rule for such operators.
//: Associativity rule indicates whether this evaluation happens from left to right or right to left.
//: For example `* and /` have the same precedence and the associativity rule of these operators is left to right.
//: So for expression like `a + b * c / d - e` which has both `* and /` the expression will evaluate as follows:
//: ```
//: 1. Evaluate `b * c`
//: 2. Evaluate `result((b * c) / d)`
//: 3. Evaluate `a + result((b * c) / d) - e`
//: ```
//: Both `+ and -` have the same precedence and left to right associativity rule. The above expression hence is evaluated from left to right in step 3.
//: Precedence and associativity rules help parenthesize the given expression. Observe the same in the example above.
//: However, you can also guide how the expression should be evaluated by adding paranthesis.
//:
//: For example the expression `(a + b) * (c / (d - e))` will have a different evaluation as the parathensis guide how the evaluation should happen.
//:
//: #### Convert infix to postfix / prefix
//:
//: Input infix expression: `a + b * c / d - e`
//: 1. Parenthesize the expression
//:     ```
//:     a + (b * c) / d - e
//:     a + ((b * c) / d) - e
//:     (a + ((b * c) / d)) - e
//:     ((a + ((b * c) / d)) - e)
//:     ```
//: 2. Move operator to the right/left(postfix/prefix) of the operands in each paranthesis starting with the inner most paranthesis and then moving outwards.
//:     ```
//:     Postfix conversion          |       Prefix Conversion
//:     ((a + ((bc*) / d)) - e)     |       ((a + ((*bc) / d)) - e
//:     ((a + (bc*d/)) - e)         |       ((a + (/*bcd)) - e)
//:     (abc*d/+) - e               |       (+a/*bcd) - e
//:     (abc*d/+e-                  |       -+a/*bcde
//:     ```
//:

//: ### Infix to postfix conversion
//: 1. Create an empty stack and a variable for result.
//: 2. For each character `c` in expression
//:     1. If c is operand, add to result
//:     2. If c is opening bracket, add to stack
//:     3. If c is closing bracket, pop all items from the stack until a opening bracket is found. Pop the opening bracket as well.
//:     4. If c is an operator
//:         1. If stack is empty
//:             1. Push into the stack
//:         2. If stack is not empty
//:             1. If c has higher precendence than top of the stack, push c into the stack
//:             2. If c has lower precendence than top of the stack, append top to result and pop. Repeat until either a higher precedence operator is at the top of the stack or the stack is empty.
//:             3. If c has equal precedence as the top of the stack, apply associativity rules.
//:                 1. For left to right associativity, print top, pop it and then push c onto the stack.
//:                 2. For right to left associativity, push c onto the stack.
//: 3. Pop out all remaining items from the stack and append to the result.
//: 4. Return the result.

func convertToPostfix(_ expression: String) -> String {
    let stack = ArrayStack<Character>()
    
    let operators = Set<Character>(["+", "-", "*", "/", "^"])
    let precedence: [Character: Int] = ["(": 0, ")": 0, "+": 1, "-": 1, "*": 2, "/": 2, "^": 3]
    let l2rAssociativity = Set<Character>(["+", "-", "*", "/"])
    
    var postfixSequence = expression.reduce(into: [Character]()) { partialResult, character in
        if operators.contains(character) {
            while let top = stack.peek(), (precedence[character]! < precedence[top]! || (precedence[character]! == precedence[top]! && l2rAssociativity.contains(character))) {
                partialResult.append(top)
                stack.pop()
            }
            stack.push(character)
        } else if character == "(" {
            stack.push(character)
        } else if character == ")" {
            while let top = stack.peek(), top != "(" {
                stack.pop()
                partialResult.append(top)
            }
            stack.pop()
        } else {
            partialResult.append(character)
        }
    }
    while let top = stack.pop() {
        postfixSequence.append(top)
    }
    return String(postfixSequence)
}
convertToPostfix("a+b-c+d-e") // "ab+c-d+e-"
convertToPostfix("a+b*c/d-e") // "abc*d/+e-"
convertToPostfix("(A+B)/(C-D)-(E*F)") // "AB+CD-/EF*-"
convertToPostfix("a+b^c/d-e") // "abc^d/+e-"
convertToPostfix("a^b*c/d-e") // "ab^c*d/e-"
convertToPostfix("a^b^c") // (a^(bc^)) -> abc^^ | (a^(^bc)) -> ^a^bc

//: ### Evaluate Postfix Expression
//: For each character in the expression

func evaluatePostfix(_ expression: String) -> Double {
    let operators = Set<Character>(["+", "-", "*", "/", "^"])
    let stack = ArrayStack<Double>()
    func perform(_ operatorSymbol: Character, operand1: Double, operand2: Double) -> Double {
        switch operatorSymbol {
        case "+": return operand1 + operand2
        case "-": return operand1 - operand2
        case "*": return operand1 * operand2
        case "/": return operand1 / operand2
        case "^": return pow(operand1, operand2)
        default: return 0
        }
    }
    
    var operand: String = ""
    expression.forEach { character in
        if operators.contains(character) {
            guard let op2 = stack.pop(), let op1 = stack.pop() else {
                return
            }
            stack.push(perform(character, operand1: op1, operand2: op2))
        } else {
            if character.isWhitespace {
                if !operand.isEmpty {
                    stack.push(Double(operand)!)
                    operand = ""
                }
            } else {
                operand.append(character)
            }
        }
    }
    return stack.pop() ?? 0
}

evaluatePostfix("10 5 +")
evaluatePostfix("2 10 + 5 *")
evaluatePostfix("2 2 3 ^ ^")

//: # Infix to Prefix Conversion
//:
//: a + b * c / d - e
//: Prefix Conversion
//: ((a + ((*bc) / d)) - e
//: ((a + (/*bcd)) - e)
//: (+a/*bcd) - e
//: -+a/*bcde
//:
//: a ^ b * c / d - e
//: ((((a ^ b) * c) / d) - e)
//: ((((^ab) * c) / d) - e)
//: (((*^abc) / d) - e)
//: ((/*^abcd) - e)
//: (-/*^abcde)
//:
//: a + b ^ c / d - e
//: ((a + ((b ^ c) / d)) - e)
//: ((a + ((^bc) / d)) - e)
//: ((a + (/^bcd)) - e)
//: ((+a/^bcd) - e)
//: -+a/^bcde

//: Create an empty stack and a variable for result.
//: 1. Reverse the input expression.
//: 2. For each character `c` in reversed expression
//:     1. If c is operand, add to result
//:     2. If c is closing bracket, add to stack
//:     3. If c is opening bracket, pop all items from the stack until a closing bracket is found. Pop the closing bracket as well.
//:     4. If c is an operator
//:         1. If stack is empty
//:             1. Push into the stack
//:         2. If stack is not empty
//:             1. If c has higher precendence than top of the stack, push c into the stack
//:             2. If c has lower precendence than top of the stack, append top to result and pop. Repeat until either a higher precedence operator is at the top of the stack or the stack is empty.
//:             3. If c has equal precedence as the top of the stack, apply associativity rules.
//:                 1. For left to right associativity, push c onto the stack.
//:                 2. For right to left associativity, print top, pop it and then push c onto the stack.
//: 3. Pop all remaining elements from the stack and append them to the result.
//: 4. Reverse the result.
//: 5. Return the result


func convertToPrefix(_ expression: String) -> String {
    let stack = ArrayStack<Character>()
    
    let operators = Set<Character>(["+", "-", "*", "/", "^"])
    let precedence: [Character: Int] = ["(": 0, ")": 0, "+": 1, "-": 1, "*": 2, "/": 2, "^": 3]
    let l2rAssociativity = Set<Character>(["+", "-", "*", "/"])
    
    var index = expression.index(before: expression.endIndex)
    var prefixSequence: [Character] = []
    while index >= expression.startIndex {
        let character = expression[index]
        if operators.contains(character) {
            while !stack.isEmpty, (precedence[character]! < precedence[stack.peek()!]! || (precedence[character]! == precedence[stack.peek()!]! && !l2rAssociativity.contains(character))) {
                prefixSequence.append(stack.pop()!)
            }
            stack.push(character)
        } else if character == ")" {
            stack.push(character)
        } else if character == "(" {
            while let top = stack.peek(), top != ")" {
                stack.pop()
                prefixSequence.append(top)
            }
            stack.pop()
        } else {
            prefixSequence.append(character)
        }
        //        print(character, stack.debug(), prefixSequence, separator: " | ")
        if index == expression.startIndex {
            break
        }
        index = expression.index(before: index)
        
    }
    while let top = stack.pop() {
        prefixSequence.append(top)
    }
    return String(prefixSequence.reversed())
}

convertToPrefix("a+b-c+d-e")
convertToPrefix("a+b*c/d-e")
convertToPrefix("(A+B)/(C-D)-(E*F)")
convertToPrefix("a+b^c/d-e")
convertToPrefix("a^b*c/d-e")
convertToPrefix("a^b^c")
convertToPrefix("2^2^3")

//: ### Evaluate Prefix Expression
//:

func evaluatePrefix(_ expression: String) -> Double {
    let operators = Set<Character>(["+", "-", "*", "/", "^"])
    let stack = ArrayStack<Double>()
    func perform(_ operatorSymbol: Character, operand1: Double, operand2: Double) -> Double {
        switch operatorSymbol {
        case "+": return operand1 + operand2
        case "-": return operand1 - operand2
        case "*": return operand1 * operand2
        case "/": return operand1 / operand2
        case "^": return pow(operand1, operand2)
        default: return 0
        }
    }
    
    var operand: String = ""
    var index = expression.index(before: expression.endIndex)
    while index >= expression.startIndex {
        let character = expression[index]
        if operators.contains(character), let op1 = stack.pop(), let op2 = stack.pop() {
            stack.push(perform(character, operand1: op1, operand2: op2))
        } else if character.isWhitespace {
            if !operand.isEmpty {
                stack.push(Double(operand)!)
                operand = ""
            }
        } else {
            operand = String(character) + operand
        }
        print(character, stack.debug())
        if index == expression.startIndex {
            break
        }
        index = expression.index(before: index)
    }
    return stack.pop() ?? 0
}

evaluatePrefix("^ 2 ^ 2 3")
evaluatePrefix("^ 5 ^ 2 3")
