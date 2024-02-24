# Boggle
This repository contains a program that plays a game of Boggle implemented in Smalltalk. Given an N*N grid of letters, the program will find connected chains of letters that form legal words.

## Game description
The program is given an N*N grid of random letters and a list of legal words and will return a list of words found in the grid, along with the indexes of each letter.

### Rules
1. Each subsequent letter must be a horizontal, vertical, or diagonal neighbour of the letter before it.
2. No individual letter cell may be used more than once in a single word.
3. Minimum word length is 1
4. 

## Smalltalk implementation
There are two functions for this program:
1. search: board for: words
3. find: word in: board at: point visited: visitedPoints
4. `anotherFunction()`

