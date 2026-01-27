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
