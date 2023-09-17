import Foundation

class BlockingThenRandomPlayer: RandomPlayer {
    
    override func makeMove(gameBoard: GameBoard, playerValue: Value) -> (x: Int, y: Int) {
        // Find any possible blocks, otherwise make a random move.
        
        // Check columns.
        for x in 0..<gameBoard.xSize {
            var myCount = 0
            var theirCount = 0
            var emptyCount = 0
            
            var emptyY = 0
            for y in 0..<gameBoard.ySize {
                    switch gameBoard.valueInSpace(x: x, y: y) {
                    case .x:
                        if playerValue == .x {
                            myCount+=1
                        } else {
                            theirCount+=1
                        }
                    case .o:
                        if playerValue == .o {
                            myCount+=1
                        } else {
                            theirCount+=1
                        }
                    case .empty:
                        emptyCount+=1
                        emptyY = y
                    default:
                        break
                    }
                }
            if myCount == 0 && theirCount == 2 && emptyCount == 1 {
                // We can block in this column.
                print("**** Found block col ****")
                return (x:x, y:emptyY)
            }
        }
        // Check rows.
        for y in 0..<gameBoard.ySize {
            var myCount = 0
            var theirCount = 0
            var emptyCount = 0
            
            var emptyX = 0
            for x in 0..<gameBoard.xSize {
                    switch gameBoard.valueInSpace(x: x, y: y) {
                    case .x:
                        if playerValue == .x {
                            myCount+=1
                        } else {
                            theirCount+=1
                        }
                    case .o:
                        if playerValue == .o {
                            myCount+=1
                        } else {
                            theirCount+=1
                        }
                    case .empty:
                        emptyCount+=1
                        emptyX = x
                    default:
                        break
                    }
                }
            if myCount == 0 && theirCount == 2 && emptyCount == 1 {
                // We can block in this row.
                print("**** Found block row ****")
                return (x:emptyX, y:y)
            }
        }
        
        // Check diagonals (only applies in square games).
        if gameBoard.xSize == gameBoard.ySize {
            var myCount = 0
            var theirCount = 0
            var emptyCount = 0
            var emptyI = 0
            for i in 0..<gameBoard.xSize {
                    switch gameBoard.valueInSpace(x: i, y: i) {
                    case .x:
                        if playerValue == .x {
                            myCount+=1
                        } else {
                            theirCount+=1
                        }
                    case .o:
                        if playerValue == .o {
                            myCount+=1
                        } else {
                            theirCount+=1
                        }
                    case .empty:
                        emptyCount+=1
                        emptyI = i
                    default:
                        break
                    }
                    
            }
            if myCount == 0 && theirCount == 2 && emptyCount == 1 {
                // We can block in this column.
                print("**** Found block diag 1 ****")
                return (x:emptyI, y:emptyI)
            }
            
             myCount = 0
             theirCount = 0
             emptyCount = 0
             emptyI = 0
            for i in 0..<gameBoard.xSize {
                switch gameBoard.valueInSpace(x: gameBoard.xSize - 1 - i, y: i) {
                    case .x:
                        if playerValue == .x {
                            myCount+=1
                        } else {
                            theirCount+=1
                        }
                    case .o:
                        if playerValue == .o {
                            myCount+=1
                        } else {
                            theirCount+=1
                        }
                    case .empty:
                        emptyCount+=1
                        emptyI = i
                    default:
                        break
                    }
                    
            }
            if myCount == 0 && theirCount == 2 && emptyCount == 1 {
                // We can block in this column.
                print("**** Found block diag 2 ****")
                return (x:emptyI, y:emptyI)
            }
        }
        
        return super.makeMove(gameBoard: gameBoard, playerValue:   playerValue)
    }
 
    
}
