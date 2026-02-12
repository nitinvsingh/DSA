import Foundation

//: # Anagram
//: ---
//: An anagram is a word, phrase, or name formed by rearranging the letters of another.
//: - Example
//: `listen` and `silent` are anagram.

//: Check whether two strings are anagram or not

extension String {
    func isAnagram(of s1: String) -> Bool {
        guard self.count == s1.count else { return false }
        var count = [Character: Int]()
        var index = s1.startIndex
        while index < s1.endIndex {
            let s1Char = s1[index]
            let s1CharCount = count[s1Char] ?? 0
            count[s1Char] = s1CharCount + 1
            
            let selfChar = self[index]
            let selfCharCount = count[selfChar] ?? 0
            count[selfChar] = selfCharCount - 1
            
            index = s1.index(after: index)
        }
        return count.allSatisfy { _, occurence in
            occurence == 0
        }
    }
    
}

"silent".isAnagram(of: "listen")
"voilent".isAnagram(of: "listen")
"eilnst".isAnagram(of: "listen")
"eilnst".isAnagram(of: "silent")
"niitn".isAnagram(of: "nitin")

//: Time Complexity: O(n), where n is the number of characters in the input string. The exact time complexity\
//: Space Complexity: O(n), where n is the number of characters in the input string. A dictionary that holds n characters is needed in this approach hence the space complexity is O(n)

//: #### Another scenario
//: The above approach would work with all kinds of string. However if you are guaranteed that input strings will have ascii format, the space complexity can be optimized to O(1) complexity.
//: 1. An array of size 128 or 256 would be created.\
//: 2. For each character in string s1 the count at position of character would be incremented by 1.
//: 3. For each character in string s2 the count at position of character would be decremented by 1.
//: 4. If both strings are anagram while traversing through the array value at each index would be zero(0). If a value is > or < than zero would indicated the two strings don't use the same number of characters. Hence they wouldn't be an anagram.

func areAnagram(s1: String, s2: String) -> Bool {
    guard s1.count == s2.count else { return false }
    var count = Array<Int>(repeating: 0, count: 128)
    var index = s1.startIndex
    while index < s1.endIndex {
        let s1Char = s1[index]
        if let ascii = s1Char.asciiValue {
            let s1CharIndex = Int(ascii)
            count[s1CharIndex] += 1
        }
        
        let s2Char = s2[index]
        if let ascii = s2Char.asciiValue {
            let s2CharIndex = Int(ascii)
            count[s2CharIndex] -= 1
        }
        
        index = s1.index(after: index)
    }
    return count.allSatisfy { value in
        value == 0
    }
}

areAnagram(s1: "listen", s2: "silent")
areAnagram(s1: "listen", s2: "voilent")
areAnagram(s1: "listen", s2: "eilnst")
areAnagram(s1: "silent", s2: "eilnst")
areAnagram(s1: "nitin", s2: "niitn")

//: Time Complexity: O(n) where n is the number of elements in both strings. In the previous case the
//: Space Complexity: O(1) as we need a constant sized array which will hold maximum of 256 elements in any given case.

