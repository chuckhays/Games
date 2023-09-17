import Foundation

enum Value {
    case x, o, empty, invalid
}

protocol GameBoard {
    func valueInSpace(x: Int, y: Int) -> Value
    var xSize: Int { get }
    var ySize: Int { get }
}

class GameBoardImpl: GameBoard {
    
    public let xSize: Int
    public let ySize: Int
    private var values: [[Value]]
    init(xSize: Int, ySize: Int) {
        self.xSize = xSize
        self.ySize = ySize
        values = Array(repeating: Array(repeating: .empty, count: ySize), count:xSize)
    }
    
    public func valueInSpace(x: Int, y: Int) -> Value {
        guard x >= 0 && x < xSize && y >= 0 && y < ySize  else {
            return .invalid
        }
        return values[x][y]
    }
    
    public func setValue(x: Int, y:Int, value:Value) -> Bool {
        // Check if x/y are valid.
        guard x >= 0 && x < xSize && y >= 0 && y < ySize  else {
            return false
        }
        // Check if spot is empty.
        guard values[x][y] == .empty else {
            return false
        }
        values[x][y] = value
        return true
    }
    
}
