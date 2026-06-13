import Foundation

public final class DanniePlayer: TicTacToePlayerBase {

    public override func requestMove() -> (row: Int, col: Int) {
        let available = board.availableMoves()
        if available.count == 9 {
            return (0, 2)
        } else if available.count == 8 {
            if board.grid[1][1] == .empty {
                return (1, 1)
            } else {
                return (2, 0)
            }
        }

        guard !available.isEmpty else {
            return (0, 0)
        }

        // 1st - can we win?
        for currentRow in 0...2 {
            let left = board.grid[currentRow][0]
            let middle = board.grid[currentRow][1]
            let right = board.grid[currentRow][2]

            var numEmpty = 0
            var numMatchUs = 0
            if left == .empty {
                numEmpty = numEmpty + 1
            } else if left == piece {
                numMatchUs = numMatchUs + 1
            }
            if middle == .empty {
                numEmpty = numEmpty + 1
            } else if middle == piece {
                numMatchUs = numMatchUs + 1
            }
            if right == .empty {
                numEmpty = numEmpty + 1
            } else if right == piece {
                numMatchUs = numMatchUs + 1
            }

            if numEmpty == 1, numMatchUs == 2 {
                if left == .empty {
                    return (currentRow, 0)
                } else if middle == .empty {
                    return (currentRow, 1)
                } else if right == .empty {
                    return (currentRow, 2)
                }
            }
        }

        for currentCol in 0...2 {
            let top = board.grid[0][currentCol]
            let middle = board.grid[1][currentCol]
            let bottom = board.grid[2][currentCol]

            var numEmpty = 0
            var numMatchUs = 0
            if top == .empty {
                numEmpty = numEmpty + 1
            } else if top == piece {
                numMatchUs = numMatchUs + 1
            }
            if middle == .empty {
                numEmpty = numEmpty + 1
            } else if middle == piece {
                numMatchUs = numMatchUs + 1
            }
            if bottom == .empty {
                numEmpty = numEmpty + 1
            } else if bottom == piece {
                numMatchUs = numMatchUs + 1
            }

            if numEmpty == 1, numMatchUs == 2 {
                if top == .empty {
                    return (0, currentCol)
                } else if middle == .empty {
                    return (1, currentCol)
                } else if bottom == .empty {
                    return (2, currentCol)
                }
            }
        }

        var one = board.grid[0][0]
        var two = board.grid[1][1]
        var three = board.grid[2][2]

        var numEmpty = 0
        var numMatchUs = 0
        if one == .empty {
            numEmpty = numEmpty + 1
        } else if one == piece {
            numMatchUs = numMatchUs + 1
        }
        if two == .empty {
            numEmpty = numEmpty + 1
        } else if two == piece {
            numMatchUs = numMatchUs + 1
        }
        if three == .empty {
            numEmpty = numEmpty + 1
        } else if three == piece {
            numMatchUs = numMatchUs + 1
        }

        if numEmpty == 1, numMatchUs == 2 {
            if one == .empty {
                return (0, 0)
            } else if two == .empty {
                return (1, 1)
            } else if three == .empty {
                return (2, 2)
            }
        }

        one = board.grid[0][2]
        two = board.grid[1][1]
        three = board.grid[2][0]

        numEmpty = 0
        numMatchUs = 0
        if one == .empty {
            numEmpty = numEmpty + 1
        } else if one == piece {
            numMatchUs = numMatchUs + 1
        }
        if two == .empty {
            numEmpty = numEmpty + 1
        } else if two == piece {
            numMatchUs = numMatchUs + 1
        }
        if three == .empty {
            numEmpty = numEmpty + 1
        } else if three == piece {
            numMatchUs = numMatchUs + 1
        }

        if numEmpty == 1, numMatchUs == 2 {
            if one == .empty {
                return (0, 2)
            } else if two == .empty {
                return (1, 1)
            } else if three == .empty {
                return (2, 0)
            }
        }

        // 2nd - can we block opponent's win?
        for currentRow in 0...2 {
            let left = board.grid[currentRow][0]
            let middle = board.grid[currentRow][1]
            let right = board.grid[currentRow][2]

            var numEmpty = 0
            var numMatchThem = 0
            if left == .empty {
                numEmpty = numEmpty + 1
            } else if left == piece.opposite {
                numMatchThem = numMatchThem + 1
            }
            if middle == .empty {
                numEmpty = numEmpty + 1
            } else if middle == piece.opposite {
                numMatchThem = numMatchThem + 1
            }
            if right == .empty {
                numEmpty = numEmpty + 1
            } else if right == piece.opposite {
                numMatchThem = numMatchThem + 1
            }

            if numEmpty == 1, numMatchThem == 2 {
                if left == .empty {
                    return (currentRow, 0)
                } else if middle == .empty {
                    return (currentRow, 1)
                } else if right == .empty {
                    return (currentRow, 2)
                }
            }
        }

        for currentCol in 0...2 {
            let top = board.grid[0][currentCol]
            let middle = board.grid[1][currentCol]
            let bottom = board.grid[2][currentCol]

            var numEmpty = 0
            var numMatchThem = 0
            if top == .empty {
                numEmpty = numEmpty + 1
            } else if top == piece.opposite {
                numMatchThem = numMatchThem + 1
            }
            if middle == .empty {
                numEmpty = numEmpty + 1
            } else if middle == piece.opposite {
                numMatchThem = numMatchThem + 1
            }
            if bottom == .empty {
                numEmpty = numEmpty + 1
            } else if bottom == piece.opposite {
                numMatchThem = numMatchThem + 1
            }

            if numEmpty == 1, numMatchThem == 2 {
                if top == .empty {
                    return (0, currentCol)
                } else if middle == .empty {
                    return (1, currentCol)
                } else if bottom == .empty {
                    return (2, currentCol)
                }
            }
        }

        one = board.grid[0][0]
        two = board.grid[1][1]
        three = board.grid[2][2]

        numEmpty = 0
        var numMatchThem = 0
        if one == .empty {
            numEmpty = numEmpty + 1
        } else if one == piece.opposite {
            numMatchThem = numMatchThem + 1
        }
        if two == .empty {
            numEmpty = numEmpty + 1
        } else if two == piece.opposite {
            numMatchThem = numMatchThem + 1
        }
        if three == .empty {
            numEmpty = numEmpty + 1
        } else if three == piece.opposite {
            numMatchThem = numMatchThem + 1
        }

        if numEmpty == 1, numMatchThem == 2 {
            if one == .empty {
                return (0, 0)
            } else if two == .empty {
                return (1, 1)
            } else if three == .empty {
                return (2, 2)
            }
        }

        one = board.grid[0][2]
        two = board.grid[1][1]
        three = board.grid[2][0]

        numEmpty = 0
        numMatchThem = 0
        if one == .empty {
            numEmpty = numEmpty + 1
        } else if one == piece.opposite {
            numMatchThem = numMatchThem + 1
        }
        if two == .empty {
            numEmpty = numEmpty + 1
        } else if two == piece.opposite {
            numMatchThem = numMatchThem + 1
        }
        if three == .empty {
            numEmpty = numEmpty + 1
        } else if three == piece.opposite {
            numMatchThem = numMatchThem + 1
        }

        if numEmpty == 1, numMatchThem == 2 {
            if one == .empty {
                return (0, 2)
            } else if two == .empty {
                return (1, 1)
            } else if three == .empty {
                return (2, 0)
            }
        }

        // 3rd - strategy.

        return available.randomElement()!
    }
}
