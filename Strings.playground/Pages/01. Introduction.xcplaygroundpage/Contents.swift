import Foundation

//: # Strings
//: ---
//: - A string is a sequence of characters.
//: - Generally encoded in ASCII or UTF formats.
//: - Contiguous integer values. For example, A is 65, B is 66, C is 67 and so on. Similarly, a is 97, b is 98, c is 99 and so on in both ASCII and UTF.
//: - Since both formats number english characters the same way, english strings are generally interoperable across these formats.
//: - Strings end with an end of string indicator `\0`. So the string "Hello, world" the in memory representation is ['H', 'e', 'l', 'l', 'o', ',', ' ', 'w', 'o', 'r', 'l', 'd', '\0'].

//: ### Sample Problem
//: Return frequencies of characters in sorted order in a string of lower case alphabets.
//: Input: "geeksforgeeks"
//: Output: e: 4, f: 1, g: 2, k: 2, o: 1, r: 1, s: 2

func frequencies(in str: String) -> [(Character, Int)] {
    var occurences: [Int] = Array<Int>(repeating: 0, count: 26)
    let rangeStartAscii = Character("a").asciiValue!
    str.forEach { character in
        if let characterAscii = character.asciiValue {
            let index = Int(characterAscii - rangeStartAscii)
            occurences[index] += 1
        }
    }
    return occurences.enumerated().compactMap { occurence in
        if occurence.element > 0 {
            let ascii = UInt8(occurence.offset) + rangeStartAscii
            let character = Character(UnicodeScalar(ascii))
            return (character, occurence.element)
        } else {
            return nil
        }
    }
}

frequencies(in: "geeksforgeeks")

//: Time Complexity: O(n), where n is the length of the string
//: Space Complexity: O(26) or O(1), since we need only 26 memory allocations for any input.


//: ### Palindrome Check
//: Given a string return whether the string is a palindrome or not.
//: Input: ABBA
//: Output: true

func isPalindrome(_ input: String) -> Bool {
    var startIndex = input.startIndex
    var endIndex = input.index(before: input.endIndex)
    while startIndex < endIndex {
        if input[startIndex] == input[endIndex] {
            startIndex = input.index(after: startIndex)
            endIndex = input.index(before: endIndex)
        } else {
            return false
        }
    }
    return true
}

isPalindrome("ABBA")
isPalindrome("geeksforgeeks")
isPalindrome("ABCCBA")
isPalindrome("ABCDECBA")

//: ### Subsequence of other
//: A subsequence of a string is a string that is obtained after removing 0 or more characters from the string maintaining the order in which the picked characters appear in the original string.
//: For example, subsequences of string "ABC" are "", "A", "B", "C", "AB", "AC", "BC", "ABC"
//: Notice that the subsequences of a string is 2^n where n is the number of characters in the string.

//: How is a subsequence different from a substring? A substring is contiguous where as a subsequence does not have to be contiguous. Subsequences only need to maintain the order in which the characters appear in the original string.

extension String {
    func subsequences(partialResult: String = "") -> [String] {
        if self.isEmpty { return [partialResult] }
        let currentChar = String(self.first!)
        let nextIndex = index(after: startIndex)
        let rightStr = String(self[nextIndex...])
        let left = rightStr.subsequences(partialResult: partialResult)
        let right = rightStr.subsequences(partialResult: partialResult + currentChar)
        return left + right
    }
}

extension String {
    func isSubsequence(of string: String) -> Bool {
        return string.subsequences().contains { $0 == self }
    }
}

"A".isSubsequence(of: "AB")

extension String {
    func isSubsequence(ofString original: String) -> Bool {
        var sequenceIndex = self.startIndex
        var originalIndex = original.startIndex
        while sequenceIndex < endIndex && originalIndex < original.endIndex {
            if original[originalIndex] == self[sequenceIndex] {
                sequenceIndex = index(after: sequenceIndex)
            }
            originalIndex = original.index(after: originalIndex)
        }
        return sequenceIndex == endIndex
    }
}

"ADE".isSubsequence(ofString: "ABCDE")
"AED".isSubsequence(ofString: "ABCDE")
"F".isSubsequence(ofString: "ABCDE")
"".isSubsequence(ofString: "ABCDE")


//: Efficient way to verify whether a number is a

//: - #### Follow up Later
//: What is lexographical in relation to strings?

func binaryString(_ string: String) -> Int {
    var result = 0
    var count = 0
    string.forEach { character in
        if character == "1" {
            count += 1
            if count > 1 {
                result += count - 1
            }
        }
    }
    return result
}

binaryString("11111")

