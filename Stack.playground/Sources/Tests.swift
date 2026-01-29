public enum TestRunResult {
    case success
    case failure(String)
}

public protocol StackProtocol {
    associatedtype Element
    var count: Int { get }
    
    func push(_ element: Element)
    func pop() -> Element?
    func peek() -> Element?
}

public class StackTests {
    
    private let implementation: StackProtocol.Type
    
    init(implementation: StackProtocol) {
        self.implementation = implementation
    }
    
    func test_init_createsStackWithNoElement() -> TestRunResult {
        let sut = makeStack()
        return sut.count == 0 ? .success : .failure(errorMessage(expected: 0, got: sut.count))
    }
    
    func test_push_increasesCountByOne() -> TestRunResult {
        let expectedCount = 2
        let sut = makeStack(ofCount: expectedCount)
        return sut.count == expectedCount ? .success : .failure(errorMessage(expected: expectedCount, got: sut.count))
    }
    
    func test_push_addsElementsToTheTopOfAnEmptyStack() -> TestRunResult {
        let expected = 25
        let sut = makeStack()
        
        sut.push(expected)
        let received = sut.peek()
        
        if let top = received, top == expected {
            return .success
        } else {
            return .failure(errorMessage(expected: expected, got: received))
        }
    }
    
    func test_push_addsElementToTheTopOfStack() -> TestRunResult {
        let expected = 20
        let sut = makeStack(ofCount: 2)
        
        sut.push(expected)
        let received = sut.peek()
        
        if let top = received, top == expected {
            return .success
        } else {
            return .failure(errorMessage(expected: expected, got: received))
        }
    }
    
    func test_peek_givesNoElementWhenStackIsEmpty() -> TestRunResult {
        let expectedResult: Int? = nil
        let sut = makeStack()
        
        let receivedResult = sut.peek()
        
        return receivedResult == nil ? .success : .failure(errorMessage(expected: expectedResult, got: receivedResult))
    }
    
    func test_pop_reducesCountByOne() -> TestRunResult {
        let expectedCount = 4
        let sut = makeStack(ofCount: 5)
        
        sut.pop()
        
        return sut.count == 4 ? .success : .failure(errorMessage(expected: expectedCount, got: sut.count))
    }
    
    func test_pop_doesNotReduceCountWhenStackIsEmpty() -> TestRunResult {
        let expectedCout = 0
        let sut = makeStack()
        
        sut.pop()
        
        return sut.count == expectedCout ? .success : .failure(errorMessage(expected: expectedCout, got: sut.count))
    }
    
    func test_pop_givesNothingWhenTheStackIsEmpty() -> TestRunResult {
        let expected: Int? = nil
        let sut = makeStack()
        let received = sut.pop()
        return received == nil ? .success : .failure(errorMessage(expected: expected, got: received))
    }
    
    func test_pop_givesTheTopMostRemovedElement() -> TestRunResult {
        let expected = 5
        let sut = makeStack(ofCount: 5)
        
        let received = sut.pop()
        
        if let top = received, top == expected {
            return .success
        } else {
            return .failure(errorMessage(expected: expected, got: received))
        }
    }
    
    public static func runSuite(forImplementation implementation: StackProtocol.Type) -> [String: TestRunResult] {
        return [
            "test_init_createsStackWithNoElement": StackTests().test_init_createsStackWithNoElement(),
            "test_push_increasesCountByOne": StackTests().test_push_increasesCountByOne(),
            "test_push_addsElementsToTheTopOfAnEmptyStack": StackTests().test_push_addsElementsToTheTopOfAnEmptyStack(),
            "test_peek_givesNoElementWhenStackIsEmpty": StackTests().test_peek_givesNoElementWhenStackIsEmpty(),
            "test_push_addsElementToTheTopOfStack": StackTests().test_push_addsElementToTheTopOfStack(),
            "test_pop_reducesCountByOne": StackTests().test_pop_reducesCountByOne(),
            "test_pop_doesNotReduceCountWhenStackIsEmpty": StackTests().test_pop_doesNotReduceCountWhenStackIsEmpty(),
            "test_pop_givesNothingWhenTheStackIsEmpty": StackTests().test_pop_givesNothingWhenTheStackIsEmpty(),
            "test_pop_givesTheTopMostRemovedElement": StackTests().test_pop_givesTheTopMostRemovedElement(),
        ]
    }

    
    //: MARK: - Helpers
    private func errorMessage<T, V>(expected: T, got: V) -> String {
        return "Expected \(expected), got \(got)"
    }
    
    private func makeStack(ofCount count: Int = 0) -> ArrayStack<Int> {
        let stack = ArrayStack<Int>()
        (0..<count).forEach { number in
            stack.push(number + 1)
        }
        return stack
    }
}



