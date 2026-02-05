import Foundation

//: # Pattern Matching
//: ---
//: ### Naive approach
//: 1. Create a window of the size of the pattern text.
//: 2. Slide this window through the test string, moving it forward one character at a time.
//: 3. A match is found if the pattern is same as the characters in the current window of the test string.
//: - Callout(Time Complexity):
//: O((n - m + 1) x m)\
//: where `n` is the number of characters in the text. `m` is the number of characters in the pattern.

//: ### An optimization when all characters in the pattern are distinct
//: For pattern with repeating characters, we are required to slide the window over by 1 as patterns can get neglected when not sliding the window by 1.
//: - Example:
//: `text = "AABAACAADAABAABA" pattern = "AABA"`
//:
//: Do a dry run with this example. If you do not slide the window over by 1, you might miss out a few occurences of the pattern.
//:
//: In case the pattern has distinct characters, as there are no repeating characters in the pattern, the posibilities of missing overlapping patterns does not arise.\
//: The idea is instead of always sliding the window over the test string by 1 place in case of a mismatch, slide the window directly to the position of mismatch.
//: So when a few characters have matched, slide the window over so that it starts at the index of the mismatch.
//: In case no characters matched, slide the window by 1 index and begin matching.
//: - Callout(Time Complexity):
//: O(n)
//:


/*
 String = "ababc"
 PP(1) = 0
 PP(2) = 0
 PP(3) = "", "a", "ab" | S(3) = "", "a", "ba", "aba" = 1
 PP(4) = "", "a", "ab", "aba", | S(4) = "", "b", "ab", "bab", "abab" = 2
 PP(5) = "", "a", "ab", "aba", "abab" | S(5) = "", "c", "bc", "abc", "babc", "ababc" = 0
 
 
 Input = "ababab"
 PropPrefix(1) = "" | Suffix(1) = "", "a" | LPS(1) = 0
 PropPrefix(2) = "", "a" | Suffix(2) = "", "b", "ab" | LPS(2) = 0
 PropPrefix(3) = "", "a", "ab" | Suffix(3) = "", "a", "ba" "aba" | LPS(3) = 1
 PropPrefix(4) = "", "a", "ab", "aba" | Suffix(4) = "", "b", "ab", "bab", "abab" | LPS(4) = 2
 PropPrefix(5) = "", "a", "ab", "aba", "abab" | Suffix(5) = "", "a", "ba", "aba", "baba", "ababa" | LPS(5) = 3
 PropPrefix(6) = "", "a", "ab", "aba", "abab", "ababa" | Suffix(6) = "", "b", "ab", "bab", "abab", "babab", "ababab" | LPS(6) = 4
 
 Input = "aaaa"
 PP(1) -> "" | S(1) -> "", "a" | LPS(1) -> 0
 PP(2) -> "", "a" | S(2) -> "", "a", "aa" | LPS(2) -> 1
 PP(3) -> "", "a", "aa" | S(3) -> "", "a", "aa", "aaa" | LPS(3) -> 2
 PP(4) -> "", "a", "aa", "aaa" | S(4) -> "", "a", "aa", "aaa", "aaaa" | LPS(4) -> 3
 
 Input = "aabbcc"
 PP(1) -> "" | S(1) -> "", a | LPS(1) -> 0
 PP(2) -> "", "a" | S(2) -> "", "a", "aa" | LPS(2) -> 1
 PP(3) -> "", "a", "aa" | S(3) -> "", "b", "ab", "aab" | LPS(3) -> 0
 PP(4) -> "", "a", "aa", "aab" | S(4) -> "", "b", "bb", "abb", "aabb" | LPS(4) -> 0
 PP(5) -> "", "a", "aa", "aab", "aabb" | S(5) -> "", "c", "bc", "bbc", "abbc", "aabbc" | LPS(5) -> 0
 PP(6) -> "", "a", "aa", "aab", "aabb", "aabbc" | S(6) -> "", "c", "cc", "bcc", ,"bbcc", "abbcc", "aabbcc" | LPS(6) -> 0
 */
