Class {
	#name : #PositionsBoard,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionsBoard class >> with: players [
	players ifEmpty: [ self error: 'cannot create a boardOfPositions without players' ].
	^ self new initializeWith: players.
]

{ #category : #queries }
PositionsBoard >> anyPlayerFinished: laps withBoardOfSize: cells [
	^ (positions anySatisfy: [ :position | (position valueOfPosition) > (cells*laps) ]).
]

{ #category : #actions }
PositionsBoard >> createNewPositionsWith: newPosition at: indexOfPosition [
	| newPositions |
	newPositions := positions copy.
	newPositions removeAt: indexOfPosition.
	newPositions add: newPosition beforeIndex: indexOfPosition.
	^ newPositions
]

{ #category : #queries }
PositionsBoard >> findPositionOf: name in: collection [
	^ collection detect: [ :position | position nameOfPlayer = name ]
]

{ #category : #initialize }
PositionsBoard >> initializeWith: players [
	| auxiliarPositions |
	auxiliarPositions := players collect: [ :player | (Position from: player)].
	positions := auxiliarPositions asOrderedCollection .
	
]

{ #category : #queries }
PositionsBoard >> lapOf: name withLapSize: lapSize [
	| positionOfPlayer |
	positionOfPlayer := (self findPositionOf: name in: positions) valueOfPosition.
	^ (positionOfPlayer // lapSize) + 1.
]

{ #category : #actions }
PositionsBoard >> moveEveryone: n except: player [
	| playersToMove |
	playersToMove := (self selectAllPositionsExcept: player) collect: [ :position | position nameOfPlayer ].
	playersToMove do: [ :name | self updatePositionOf: name with: n ]
]

{ #category : #actions }
PositionsBoard >> moveEveryoneToTheBeginningOfTheLapWithSize: lapSize [
	| moveBackwards actualPositionOnLap |
	positions do: [ :position | 
		actualPositionOnLap := position valueOfPosition \\ lapSize.
		moveBackwards := -1*actualPositionOnLap.
		self updatePositionOf: (position nameOfPlayer) with: moveBackwards ].
]

{ #category : #queries }
PositionsBoard >> orderedPositions [
	^ positions asSortedCollection: [ :positionA :positionB | positionA >= positionB ]
]

{ #category : #queries }
PositionsBoard >> podiumOf: name [
	| podium positionOfPlayer indexOfPlayer |
	podium := self orderedPositions.
	positionOfPlayer := self findPositionOf: name in: podium.
	indexOfPlayer := podium indexOf: positionOfPlayer.
	^ indexOfPlayer
]

{ #category : #queries }
PositionsBoard >> positionOf: name [  
	| position |
	position := self findPositionOf: name in: positions.
	^ position valueOfPosition.
]

{ #category : #actions }
PositionsBoard >> selectAllPositionsExcept: player [
	^ positions
		select: [ :position | (position nameOfPlayer ~= player) ]
]

{ #category : #actions }
PositionsBoard >> updatePositionOf: name with: value [
	| newPosition oldPosition indexOfPosition newPositions |
	oldPosition := self findPositionOf: name in: positions.
	newPosition := oldPosition updatePosition: value.
	indexOfPosition := positions indexOf: oldPosition.
	newPositions := self
		createNewPositionsWith: newPosition
		at: indexOfPosition.
	positions := newPositions
]

{ #category : #queries }
PositionsBoard >> whosFirst [
	| podium |
	podium := self orderedPositions.
	^(podium first) nameOfPlayer .
]
