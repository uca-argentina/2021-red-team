Class {
	#name : #CircularBoard,
	#superclass : #Object,
	#instVars : [
		'cells',
		'boardOfPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CircularBoard class >> with: players andWithAll: cells [
	| boardOfPositions |
	cells ifEmpty: [ self error: 'cant create a board without cells' ].
	players ifEmpty: [ self error: 'invalid number of players' ].
	boardOfPositions := BoardOfPositions with: players.
	^ self new initializeWith: boardOfPositions andWithAll: cells.
]

{ #category : #queries }
CircularBoard >> anyPlayerFinished: laps [
	^ boardOfPositions anyPlayerFinished: laps withBoardOfSize: cells size.
]

{ #category : #initialize }
CircularBoard >> initializeWith: positions andWithAll: collectionOfCells [
	cells := collectionOfCells.
	boardOfPositions := positions.
	
]

{ #category : #queries }
CircularBoard >> lapOfPlayer: playerName [
	^ boardOfPositions lapOfPlayer: playerName withLapSize: (cells size).
]

{ #category : #actions }
CircularBoard >> move: player with: rollValue [
	| currentPosition currentCell |
	currentPosition := boardOfPositions updatePositionOf: player with: rollValue.
	currentPosition := currentPosition \\ (cells size).
	(currentPosition = 0) ifTrue: [ currentPosition := cells size ].
	currentCell := cells at: currentPosition.
	currentCell activateEffect: self and: player.
]

{ #category : #actions }
CircularBoard >> moveEveryone: n except: player [
	boardOfPositions moveEveryone: n except: player. 
]

{ #category : #actions }
CircularBoard >> moveEveryoneToTheBeginningOfTheLap [
	boardOfPositions moveEveryoneToTheBeginningOfTheLapWithSize: cells size.
]

{ #category : #queries }
CircularBoard >> podiumOfPlayer: name [ 
	^ boardOfPositions podiumOfPlayer: name .
]

{ #category : #queries }
CircularBoard >> positionOfPlayer: player [
	| position |
	position := boardOfPositions positionOfPlayer: player.
	^ (position > (cells size)) ifTrue: [ position \\ (cells size)]
									  ifFalse: [ position ].
]

{ #category : #actions }
CircularBoard >> updatePositionOf: player with: value [  
	| newValueOfPosition |
	newValueOfPosition := boardOfPositions updatePositionOf: player with: value. 
]
