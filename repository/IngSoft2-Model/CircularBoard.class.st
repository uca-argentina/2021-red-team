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
	players ifEmpty: [ self error: 'cant create a board without players' ].
	boardOfPositions := PositionsBoard with: players.
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
CircularBoard >> lapOf: playerName [
	^ boardOfPositions lapOf: playerName withLapSize: (cells size).
]

{ #category : #actions }
CircularBoard >> move: player with: rollValue [
	| currentPosition currentCell |
	boardOfPositions updatePositionOf: player with: rollValue.
	currentPosition := self positionOnLap: player.
	currentCell := cells at: currentPosition.
	currentCell activateEffect: self and: player
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
CircularBoard >> podiumOf: name [ 
	^ boardOfPositions podiumOf: name .
]

{ #category : #queries }
CircularBoard >> positionOf: player [
	| position |
	position := boardOfPositions positionOf: player.
	^ (position > (cells size)) ifTrue: [ position \\ (cells size)]
									  ifFalse: [ position ].
]

{ #category : #actions }
CircularBoard >> positionOnLap: player [
	| position positionOnLap |
	position := boardOfPositions positionOf: player.
	positionOnLap := position \\ cells size.
	positionOnLap = 0
		ifTrue: [ positionOnLap := cells size ].
	^ positionOnLap
]

{ #category : #actions }
CircularBoard >> updatePositionOf: player with: value [  
	boardOfPositions updatePositionOf: player with: value. 
]

{ #category : #queries }
CircularBoard >> whoWon [
	^boardOfPositions whosFirst.
]
