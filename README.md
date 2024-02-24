# Boggle
This repository contains a Smalltalk program that plays a game of Boggle. 

## Game description
Given an N*N grid of letters and a list of legal words as input, the program searches for connected chains of letters on the grid that form legal words. It returns a list of found words and the indexes of each letter.

### Rules and modifications
1. Each subsequent letter must be a horizontal, vertical, or diagonal neighbour of the letter before it.
2. No individual letter cell may be used more than once in a single word.
3. There is no "Qu" tile; each letter tile contains exactly one character.
4. The minimum word length is 1
5. The input grid can be as small as 2x2 and grow arbitrarily large to NxN.


## Smalltalk implementation
The code consists of two main methods in the `Boggle` class:
1. `search:for:`
This method takes a game board and a list of legal words as input and returns a dictionary of found words along with their positions.
2. `find:in:at:visited:`
This method is a helper method used by `search:for:` to recursively find words on the board from a given position.

### Usage
To use the Boggle game solver, create an instance of the `Boggle` class and call the `search:for:` method, providing the game board and a list of legal words.

Example usage:

```smalltalk
| boggleSolver gameBoard legalWords result |
boggleSolver := Boggle new.
gameBoard := #(#($e $a) #($s $t)). "Example 2x2 game board"
legalWords := #( 'word1' 'word2' 'word3' ... ). "List of legal words"

result := boggleSolver search: gameBoard for: legalWords.
