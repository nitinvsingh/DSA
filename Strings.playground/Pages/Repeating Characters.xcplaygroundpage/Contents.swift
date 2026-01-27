import Foundation

//: # Repeating Characters
//: ---

//: ### Leftmost Repeating Character
//: Given a string, find index of the first character (whose leftmost appearance is first) that repeats.
//: - Example:
//: Input: "abccb"\
//: Output: 1, because `b` is the first(leftmost) character that repeats in the string `abccb`.

extension String {
    var firstRepeatingCharacter: Character? {
        var count = self.reduce(into: [Int](repeating: 0, count: 128)) { partialResult, character in
            if let ascii = character.asciiIndex {
                partialResult[ascii] += 1
            }
        }
        var index = startIndex
        while index < endIndex {
            let character = self[index]
            if let ascii = character.asciiIndex {
                if count[ascii] > 1 {
                    break
                }
            }
            index = self.index(after: index)
        }
        return index == endIndex ? nil : self[index]
    }
}

"geeksForgeeks".firstRepeatingCharacter
"abccb".firstRepeatingCharacter
"aabbcc".firstRepeatingCharacter
"abcccdeee".firstRepeatingCharacter
"abc".firstRepeatingCharacter

//: Time Complexity: O(n), where n is the number of characters in the string.\
//: Space Complexity: O(1), since a array of constant size is required to store the count of characters.

//: ##### Unicode safe solution

func firstRepeatingCharacter(in string: String) -> Character? {
    var count = string.reduce(into: [Character: Int]()) { partialResult, character in
        let current = partialResult[character] ?? 0
        partialResult[character] = current + 1
    }
    var index = string.startIndex
    while index < string.endIndex {
        let character = string[index]
        if let current = count[character], current > 1 {
            break
        }
        index = string.index(after: index)
    }
    return index == string.endIndex ? nil : string[index]
}

firstRepeatingCharacter(in: "geeksForgeeks")
firstRepeatingCharacter(in: "abccb")
firstRepeatingCharacter(in: "aabbcc")
firstRepeatingCharacter(in: "abcccdeee")
firstRepeatingCharacter(in: "abc")
firstRepeatingCharacter(in: "abba")

//: Time Complexity: O(n), where n is the number of characters in the input string\
//: Space Complexity: O(n), where n is ther number of elements in the array. A dictionary containing each array element is needed in this approach.

//: #### Efficient Approach 1
func firstRepeatingCharacterOptimized(_ string: String) -> Character? {
    // 1. Create an array of integers having 128/256 elements, with each element set to -1.
    // 2. Have a variable to record the smallest index of repeating characters.
    // 3. For each character, generate the ascii value based index.
    // 4. At the ascii index set index of the character in the input string as value.
    // 5. If the value was already set, update result with the value of the index if the current index is smaller than the already set result value.
    var indices = [String.Index?](repeating: nil, count: 128)
    var firstRepeating: String.Index? = nil
    var index = string.startIndex
    while index < string.endIndex {
        let character = string[index]
        if let asciiIndex = character.asciiIndex {
            if let previous = indices[asciiIndex] {
                firstRepeating = min(previous, firstRepeating ?? previous)
            } else {
                indices[asciiIndex] = index
            }
        }
        index = string.index(after: index)
    }
    return firstRepeating != nil ? string[firstRepeating!] : nil
}

firstRepeatingCharacterOptimized("geeksForgeeks")
firstRepeatingCharacterOptimized("abccb")
firstRepeatingCharacterOptimized("aabbcc")
firstRepeatingCharacterOptimized("abcccdeee")
firstRepeatingCharacterOptimized("abc")
firstRepeatingCharacterOptimized("abba")

//: Time Complexity: O(n), where n is the number of elements in the string\
//: Space Complexity: O(1), since an array of size 128 element is used to store the index of first occurence of characters.

//: #### Leftmost Repeating character Most (most efficient approach)
//: Traverse the string from end to start and keep track of characters that have already been visited. Repeated character if present would be present at the begining of string and also the index would be smaller.
func firstRepeatingCharacterBest(_ string: String) -> Character? {
    var visited = [Bool](repeating: false, count: 128)
    var firstRepeating: String.Index? = nil
    var index = string.index(before: string.endIndex)
    while index >= string.startIndex {
        let character = string[index]
        if let asciiIndex = character.asciiIndex {
            if visited[asciiIndex] {
                firstRepeating = index
            } else {
                visited[asciiIndex] = true
            }
        }
        if index != string.startIndex {
            index = string.index(before: index)
        } else {
            break
        }
    }
    return firstRepeating != nil ? string[firstRepeating!] : nil
}

firstRepeatingCharacterBest("geeksForgeeks")
firstRepeatingCharacterBest("abccb")
firstRepeatingCharacterBest("aabbcc")
firstRepeatingCharacterBest("abcccdeee")
firstRepeatingCharacterBest("abc")
firstRepeatingCharacterBest("abba")

//: Time Complexity: O(n), where n is the number of characters in the
//: Space Complexity: O(1)


//: # Left Most Non-repeating Character
//: ---
// string = "geeks"

func firstNonrepeatingCharacter(in string: String) -> Character? {
    var count = string.reduce(into: [Character: Int]()) { partialResult, character in
        let current = partialResult[character] ?? 0
        partialResult[character] = current + 1
    }
    
    var index = string.startIndex
    while index < string.endIndex {
        let character = string[index]
        if let current = count[character], current == 1 {
            break
        }
        index = string.index(after: index)
    }
    return index != string.endIndex ? string[index] : nil
}

firstNonrepeatingCharacter(in: "abba")
firstNonrepeatingCharacter(in: "abbbccd")
firstNonrepeatingCharacter(in: "geeksforgeeks")

//: Time Complexity: O(n), where n is the number of characters in the string\
//: Space Complexity: O(n), as we need a dictionary of size n

func firstNonRepeatingCharacterImproved(in string: String) -> Character? {
    var count = [Int](repeating: 0, count: 128)
    var index = string.startIndex
    while index < string.endIndex {
        let character = string[index]
        if let asciiIndex = character.asciiIndex {
            count[asciiIndex] += 1
        }
        index = string.index(after: index)
    }
    index = string.startIndex
    while index < string.endIndex {
        let character = string[index]
        if let asciiIndex = character.asciiIndex, count[asciiIndex] == 1 {
            break
        }
        index = string.index(after: index)
    }
    return index != string.endIndex ? string[index] : nil
}

firstNonRepeatingCharacterImproved(in: "geeksforgeeks")
firstNonRepeatingCharacterImproved(in: "abbcd")
firstNonRepeatingCharacterImproved(in: "cdefedcab")

//: Time Complexity: O(n), where n is the number of characters in the string\
//: Space Complexity: O(1), as we need a fixed size array of 128 for any input string. Compared to the previous solution the space requirement stays constant.

func firstNonRepeatingCharacterOptimized(in string: String) -> Character? {
    var indices = [String.Index?](repeating: nil, count: 128)
    var index = string.startIndex
    while index < string.endIndex {
        let character = string[index]
        if let asciiIndex = character.asciiIndex {
            if indices[asciiIndex] != nil {
                indices[asciiIndex] = string.endIndex
            } else {
                indices[asciiIndex] = index
            }
        }
        index = string.index(after: index)
    }
    
    var i = 0
    var first: String.Index? = nil
    while i < indices.count {
        if indices[i] != nil && indices[i] != string.endIndex {
            first = min(indices[i]!, first ?? indices[i]!)
        }
        i += 1
    }
    return first != nil ? string[first!] : nil
}

firstNonRepeatingCharacterImproved(in: "geeksforgeeks")
firstNonRepeatingCharacterImproved(in: "abbcd")
firstNonRepeatingCharacterImproved(in: "cdefedcab")

//: Time Complexity: O(n), where n is the number of characters in the string\
//: Space Complexity: O(1), as a constant sized array is used.
