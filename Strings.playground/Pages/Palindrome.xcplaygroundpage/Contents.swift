import Foundation

//: # Palindrome
//: ---
//: A string is called palindrome if it reads the same when reversed.
//: - Example:
//: `ABCDCBA` is a palindrome because when reversed it is `ABCDCBA`, which is same as the original.

//: Given a string determine whether it is a palindrome or not

extension String {
    var isPalindrome: Bool {
        var left = startIndex
        var right = self.index(before: endIndex)
        while left < right {
            if self[left] != self[right] {
                break
            }
            left = index(after: left)
            right = index(before: right)
        }
        return left >= right
    }
}

"ABCDEF".isPalindrome
"ABCDCBA".isPalindrome
"ABCCBA".isPalindrome
"nitin".isPalindrome

//: Time Complexity: O(n), where n is the number of character in the string\
//: Space Complexity: O(1), as constant auxilary space is used.
