let Piece = require("./piece");

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  let grid = new Array(8);

  for (let i = 0; i < grid.length; i++) {
    grid[i] = new Array(8);
  }

  // for (let i = 0; i < grid.length; i++) {
  //   for (let j = 0; j < grid[i].length; j++) {
  //     grid[i][j] = new Array(0);
  //   }
  // }

  grid[3][4] = (new Piece("black"));
  grid[4][3] = (new Piece("black"));
  grid[3][3] = (new Piece("white"));
  grid[4][4] = (new Piece("white"));

  return grid;
} 

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) { 
  
  let row = pos[0];
  let col = pos[1];
  if (row < 0 || col < 0 || row > 7 || col > 7) return false; 

  return true;
  
};

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  let row = pos[0];
  let col = pos[1];
  if (this.isValidPos(pos)) {
    return this.grid[row][col];
  } else {
      throw RangeError("Not valid pos!");
  }
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  let piece = this.getPiece(pos);
  if (piece && piece.color === color) {
    return true;
  } else {
    return false;
  }
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  let piece = this.getPiece(pos);
  if (piece) return true;
  else return false;
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns an empty array if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns empty array if it hits an empty position.
 *
 * Returns empty array if no pieces of the opposite color are found.
 */
Board.prototype._positionsToFlip = function(pos, color, dir, piecesToFlip){
  if (!piecesToFlip) {
    piecesToFlip = [];
  }else {
   piecesToFlip.push(pos);
  }

  let newPos = [pos[0] + dir[0], pos[1] + dir[1]];
 
  if (!this.isValidPos(newPos)) {
    return [];
  }
  if (!this.isOccupied(newPos)) {
    return [];
  }
  if (!this.isMine(newPos, color)) {
    return this._positionsToFlip(newPos, color, dir, piecesToFlip);
    } else {
     return piecesToFlip;
    }
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  if (this.isOccupied(pos)) {
    return false;
  } else {

    let arr = [];

    Board.DIRS.forEach((dir) => {
      arr = arr.concat(this._positionsToFlip(pos, color, dir));
    });

    if (arr.length > 0) {
      return true;
    }
    else {
      return false;
    }
  }
};

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  if (this.validMove(pos, color)) {
    this.grid[pos[0]][pos[1]] = new Piece(color);

    let arr = [];

    Board.DIRS.forEach(dir => {
      arr = arr.concat(this._positionsToFlip(pos, color, dir));
    });

    arr.forEach(posesToFlip => {
      let piece = this.getPiece(posesToFlip);
      piece.flip();
    }); 
  } else {
      throw Error("Not a valid move!");
  }
};

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {

  let result = [];

  for(let i = 0; i < 8; i++) {
    for(let j = 0; j < 8; j++) {
      let pos = [i, j];
      if (this.validMove(pos, color)) {
        result.push(pos);
      }
    }
  }

  return result;
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  return this.validMoves(color).length > 0
  
};



/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {

  // return !this.hasMove("black") && !this.hasMove("white");

};


/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
};



module.exports = Board;
