import Foundation

//: # Substring
//: ---
//: A smaller piece of a string is called a substring. The order of characters in the larger string is maintained in the substring.

//: ### Problem 1
//: Given two strings `a` and `b`, return the 0-based index of the first occurrence of the substring `b` in `a`. If `b` is not found, return -1.
//:
//: Sample\
//: Input: a = "GeeksForGeeks", b = "Fr"\
//: Output: -1\
//: Explanation: Substring `Fr` is not present in string `GeeksForGeeks`.
//:
//: Sample\
//: Input: a = "GeeksForGeeks", b = "For"\
//: Output: 5\
//: Explanation: Substring `For` is present in string `GeeksForGeeks` beginning at index 5.

func firstOccurence(of pattern: String, in text: String) -> String.Index? {
    var tIndex: String.Index = text.startIndex
    var pIndex: String.Index = pattern.startIndex
    while pIndex < pattern.endIndex && tIndex < text.endIndex {
        if pattern[pIndex] == text[tIndex] {
            pIndex = pattern.index(after: pIndex)
        } else {
            if pIndex > pattern.startIndex {
                pIndex = pattern.startIndex
            }
        }
        tIndex = text.index(after: tIndex)
    }
    if pIndex == pattern.endIndex {
        return text.index(tIndex, offsetBy: -1 * (pattern.count))
    } else {
        return nil
    }
}

var text = "GreeksForGreeks"
var pattern = "eeks"
firstOccurence(of: pattern, in: text)

pattern = "ForGree"
firstOccurence(of: pattern, in: text)

//: Time Complexity: O(n), where n is the number of characters in the string.\
//: Space Complexity: O(1), as constant space is needed to find the first occurence.

//: ### Problem 2
//: Given two strings `a` and `b`, return the 0-based indexes of all the occurrence of the substring `b` in `a`. If `b` is not found, return an empty array.
//:
//: Sample\
//: Input: a = "GeeksForGeeks", b = "Fr"\
//: Output: []\
//: Explanation: Substring `Fr` is not present in string `GeeksForGeeks`.
//:
//: Sample\
//: Input: a = "GeeksForGeeks", b = "Gee"\
//: Output: [0, 8]\
//: Explanation: Substring `Gee` is present in string `GeeksForGeeks` beginning at indexes 0 and 8.
func occurences(of pattern: String, in text: String) -> [String.Index] {
    let patternLength = pattern.count
    var result = [String.Index]()
    var pIndex = pattern.startIndex
    var tIndex = text.startIndex
    while tIndex < text.endIndex {
        if text[tIndex] == pattern[pIndex] {
            pIndex = pattern.index(after: pIndex)
            if pIndex == pattern.endIndex {
                let nextIndex = text.index(after: tIndex)
                let occurenceStartIndex = text.index(nextIndex, offsetBy: -1 * patternLength)
                result.append(occurenceStartIndex)
                pIndex = pattern.startIndex
            }
        } else {
            if pIndex > pattern.startIndex {
                pIndex = pattern.startIndex
            }
        }
        tIndex = text.index(after: tIndex)
    }
    return result
}
text = "GeeksForGeeks"
pattern = "eeks"
occurences(of: pattern, in: text)

text = ""
//: Time Complexity: O(n), where n is the number of characters in the text.\
//: Space Complexity: O(1), as constant space is used, except for the result.
