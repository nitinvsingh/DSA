import Foundation

//: # Subsequence
//: ---
//: Subsequence of a string is obtained by `removing 0 or more` characters from the original string while maintaining order.
//: - Example:
//: Subsequences of the string `ABC` are `"", "A", "B", "C", "AB", "AC", "BC", "ABC"`.\
//: Notice the order of characters in the original string is maintained in subsequences.

//: Given a string, return whether it is a subsequence of another string
extension String {
    func isSubsequence(of string: String) -> Bool {
        var sIndex = string.startIndex
        var index = startIndex
        while index < endIndex && sIndex < string.endIndex {
            if self[index] == string[sIndex] {
                index = self.index(after: index)
            }
            sIndex = string.index(after: sIndex)
        }
        return index == endIndex
    }
}

"A".isSubsequence(of: "ABC")
"BA".isSubsequence(of: "ABC")
"BA".isSubsequence(of: "ABCA")
"AED".isSubsequence(of: "ABCDE")
"AED".isSubsequence(of: "ABECD")

//: Time Complexity: O(n), where n is the number of characters in the larger string
//: Space Complexity: O(1), as constant auxiliary space is used.
