'From Pharo10.0.0 of 15 March 2023 [Build information: Pharo-10.0.0+build.538.sha.179ef655ae2b150009a860b127aa3605366659ca (64 Bit)] on 23 February 2024 at 7:07:53.273 pm'!
Object subclass: #Boggle
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'CPS506'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Boggle class
	instanceVariableNames: ''!

!Boggle class methodsFor: 'as yet unclassified' stamp: 'avallip 2/22/2024 23:55'!
search: board for: words
		
	| boardArea boardSize firstChar foundWords letterList searchResult |
	
	"calculates board size and total cells"
	boardSize := (board size).
	boardArea := boardSize * boardSize.
	
	letterList := Dictionary new. "initializes dictionary to store words based on first letter"
	foundWords := Dictionary new. "initalizes dictionary to store found words and their points"
	
	"filter valid words that fit on the board and store in dictionary based on first letter"
	words do: [ 
		:word | ((word size) <= boardArea) ifTrue: [
			firstChar := word first.
			(letterList at: firstChar ifAbsentPut: [ OrderedCollection new ]) addLast: word.
		]
	].
	
	"iterate through each letter"
	1 to: boardSize do: [ :row | 
		1 to: boardSize do: [ :col | 
			| currChar newDictArr tempWordList |
			currChar := (board at: row) at: col.
			
			"check if there are words starting with current letter"
			(letterList includesKey: currChar) ifTrue: [
				tempWordList := letterList at: currChar. "gets list of words starting with the current letter"
				newDictArr := OrderedCollection new.
				
				"iterate through words starting with current letter"
				tempWordList do: [ :word | 
					"search for remainder of word on the board from current position"
					searchResult := (self find: (word copyFrom: 2 to: word size) in: board at: (row @ col) visited: OrderedCollection new).
					
					"check if search result has valid positions"
					(searchResult isKindOf: OrderedCollection) 
						ifTrue: [ foundWords at: word put: (searchResult asArray) ] "store found word and positions"
						ifFalse: [ newDictArr addLast: word ]. "add word to new dictionary if not found"
				].
				"update dictionary with words not found from current letter"
				letterList at: currChar put: newDictArr.
				].
			].
		].
	
	^foundWords						
						
! !

!Boggle class methodsFor: 'as yet unclassified' stamp: 'avallip 2/23/2024 00:12'!
find: word in: board at: point visited: visitedPoints
	
	| boardSize col nextChar neighbourCells nextWord row searchResult |
	
	visitedPoints addLast: point. 
	
	(word size = 0) ifTrue: [ ^visitedPoints ].
	
	row := point x.
	col := point y.
	boardSize := board size.
	nextChar := word first.
	nextWord := word copyFrom: 2 to: word size.
	
	neighbourCells := {
		"in order: top left, top, top tight, right, left, bottom left, bottom, bottom right"
		(row - 1)@(col - 1).
		(row - 1)@col.
		(row + 1)@(col + 1).
		row@(col - 1).
		row@(col + 1).
		(row + 1)@(col - 1).
		(row + 1)@col.
		(row + 1)@(col + 1).
	}.
	
	"iterate over neighbouring cells to find matching word"
	neighbourCells do: [ :neighbourCell |
		"check if the neighbouring cell is valid"
		((neighbourCell x > 0 and: [ neighbourCell y > 0 ]) and: [ neighbourCell x <= boardSize and: [neighbourCell y <= boardSize ]]) ifTrue: [
			"check if the next character in word matching letter in cell"
			(((board at: neighbourCell x) at: neighbourCell y) = nextChar and: [( visitedPoints includes: neighbourCell) not ]) ifTrue: [
				"recursively search for the remaining word starting from the matches neighbouring cell"
				searchResult := self find: nextWord in: board at: neighbourCell visited: visitedPoints.
				"check if valid search result obtained"
				(searchResult isKindOf: OrderedCollection) ifTrue: [ ^searchResult].
			].
		].
	].

	"if no valid word found, remove the current point"
	visitedPoints = visitedPoints removeLast.
	^false.
	


	! !
