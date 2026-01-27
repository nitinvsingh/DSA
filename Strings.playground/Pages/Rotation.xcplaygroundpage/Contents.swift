import Foundation

//: # String Rotation
//: ---
//: A string is a rotation of another if it can be formed by moving characters from the start to the end (or vice versa) without rearranging them.
//:

let s1 = "abcd"
let s2 = "cdab"

//: String `s2` can be obtained from `s1` after 2 rotations from the right or left; that is moving two characters from the beginning to the end or two characters from the end to the beginning.

//: ### Rules for string rotation
//: 1. In order to check if two strings are rotation, the two strings need to be of same length.

//: ### The efficient idea 💡
//: In order to find whether a string is a rotation of another string, the brute force approach would be to generate rotations of a string and check if it matches the other string. This is inefficient as it requires generation of each rotation.\
//: A clever way to verify whether a string is a roation of another would be to double the original string and then check if the expected rotated string exist in the doubled string.\
//: - Example:
//: `s1 = "abcd", s2 = "cdab"`
//:
//: Double of s1 gives `"abcdabcd"`
//: Notice that in the doubled string, s2 is present. The range of s2 in s1 is 2...5.
//:

func rotateString(_ original: String, _ rotated: String) -> Bool {
    guard original.count == rotated.count else { return false }
    let original = original + original
    return original.contains(rotated)
}

rotateString("abcd", "cdab")
rotateString("defdefdefabcabcdef", "defdefabcabcdefdef")
rotateString("abcde", "cdeab")
rotateString("aa", "a")
rotateString("a", "aa")
