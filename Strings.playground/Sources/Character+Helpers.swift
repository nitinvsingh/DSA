public extension Character {
    /// Returns a zero based index for the character based on it's ascii value. Returns nil if the character is not supported in the ascii format.
    var asciiIndex: Int? {
        guard let ascii = asciiValue else { return nil }
        return Int(ascii)
    }
}
