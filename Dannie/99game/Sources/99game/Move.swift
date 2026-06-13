import Foundation

public struct Move: Equatable, Sendable {
    /// Index into the active player's hand.
    public let handIndex: Int
    /// Ace choice: 1 or 11. Required when playing an ace.
    public let aceValue: Int?
    /// Ten choice: +10 or -10. Required when playing a ten.
    public let tenDelta: Int?

    public init(handIndex: Int, aceValue: Int? = nil, tenDelta: Int? = nil) {
        self.handIndex = handIndex
        self.aceValue = aceValue
        self.tenDelta = tenDelta
    }
}
