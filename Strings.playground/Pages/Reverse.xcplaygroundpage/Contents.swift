import Foundation

//: # Reverse words
//: ---
//: Read the string reversed. So `I love coding` becomes `coding love I`.
//:
//: ### Idea💡
//: Use stack to reverse the words in string
//: 1. Read a word (read characters until a whitespace character)
//: 2. Push this read word in a stack
//: 3. Repeat the process until the end of the string
//: 4. Begin reading from the stack.
//: Since a stack read the last in element first, the words in the string will appear reversed.

extension String {
    var reversedWords: String {
        var stack = Stack<Substring>()
        var index = startIndex
        var start = index
        while index < endIndex {
            if self[index].isWhitespace {
                stack.push(self[start..<index])
                start = self.index(after: index)
            }
            index = self.index(after: index)
        }
        stack.push(self[start..<self.endIndex])
        var result = [String]()
        while let substring = stack.pop() {
            result.append(String(substring))
        }
        return result.joined(separator: " ")
    }
}

"I love coding".reversedWords
"Greeks for geeks".reversedWords
//: Time Complexity: 

//: ### Inplace Replace
//: Reverse the string received after reversing each word in the original string.
//: So `I love coding` after step 1 becomes `I evol gnidoc`.
//: Then reversing the entire string `I evol gnidoc` gives `coding love I`.
//:
//: The same result can be achieved if the strings is first reversed and then each individual words in the reversed strings are reversed.
//: So `I love coding` becomes `gnidoc evol I`. Then reversing individual words in this reversed strings results in `coding love I`.


extension String {
    var wordReversed: String {
        var reversedCollection = self.reversed()
        var current = reversedCollection.startIndex
        var wordStart = current
        var reversed = ""
        while current < reversedCollection.endIndex {
            if reversedCollection[current].isWhitespace {
                reversed += String(reversedCollection[wordStart..<current].reversed())
                reversed += " "
                wordStart = reversedCollection.index(after: current)
            }
            current = reversedCollection.index(after: current)
        }
        reversed += String(reversedCollection[wordStart..<current].reversed())
        return reversed
    }
}

"I love coding".wordReversed
"Greeks for geeks".wordReversed
