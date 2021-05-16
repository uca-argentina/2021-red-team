Class {
	#name : #BoardOfPositions,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardOfPositions class >> with: players [
	players ifEmpty: [ self error: 'cannot create a boardOfPositions without players' ].
	^ self new initializeWith: players.
]

{ #category : #queries }
BoardOfPositions >> anyPlayerFinished: laps withBoardOfSize: cells [
	^ (positions anySatisfy: [ :position | (position valueOfPosition) > (cells*laps) ]).
]

{ #category : #actions }
BoardOfPositions >> createNewPositionsWith: newPosition at: indexOfPosition [
	| newPositions |
	newPositions := positions copy.
	newPositions removeAt: indexOfPosition.
	newPositions add: newPosition beforeIndex: indexOfPosition.
	^ newPositions
]

{ #category : #initialize }
BoardOfPositions >> initializeWith: players [
	| auxiliarPositions |
	auxiliarPositions := OrderedCollection new.
	players do: [ :player | 
		auxiliarPositions add: (Position from: player) ].
	positions := auxiliarPositions
]

{ #category : #queries }
BoardOfPositions >> lapOf: name withLapSize: lapSize [
	| positionOfPlayer |
	positionOfPlayer := (self player: name in: positions) valueOfPosition.
	^ (positionOfPlayer // lapSize) + 1.
]

{ #category : #actions }
BoardOfPositions >> moveEveryone: n except: player [
	| playersToMove |
	playersToMove := (self selectAllPositionsExcept: player) collect: [ :position | position nameOfPlayer ].
	playersToMove do: [ :name | self updatePositionOf: name with: n ]
]

{ #category : #actions }
BoardOfPositions >> moveEveryoneToTheBeginningOfTheLapWithSize: lapSize [
	| moveBackwards |
	positions do: [ :position | 
		moveBackwards := (-1)*((position valueOfPosition) \\ lapSize).
		self updatePositionOf: (position nameOfPlayer) with: moveBackwards ].
]

{ #category : #queries }
BoardOfPositions >> orderPositions [
	^ positions
		asSortedCollection:
			[ :positionA :positionB | positionA valueOfPosition >= positionB valueOfPosition ]
]

{ #category : #queries }
BoardOfPositions >> player: name in: collection [
	^ collection detect: [ :position | position nameOfPlayer = name ]
]

{ #category : #queries }
BoardOfPositions >> podiumOf: name [
	| podium positionOfPlayer indexOfPlayer |
	podium := self orderPositions.
	positionOfPlayer := self player: name in: podium.
	indexOfPlayer := podium indexOf: positionOfPlayer.
	^ indexOfPlayer
]

{ #category : #queries }
BoardOfPositions >> positionOf: name [  
	| position |
	position := self player: name in: positions.
	^ position valueOfPosition.
]

{ #category : #actions }
BoardOfPositions >> selectAllPositionsExcept: player [
	^ positions
		select: [ :position | (position nameOfPlayer ~= player) ]
]

{ #category : #actions }
BoardOfPositions >> updatePositionOf: name with: value [
	| newPosition oldPosition indexOfPosition newPositions |
	oldPosition := self player: name in: positions.
	newPosition := oldPosition updatePosition: value.
	indexOfPosition := positions indexOf: oldPosition.
	newPositions := self
		createNewPositionsWith: newPosition
		at: indexOfPosition.
	positions := newPositions
]

{ #category : #queries }
BoardOfPositions >> whosFirst [
	| podium |
	podium := self orderPositions.
	^(podium first) nameOfPlayer .
]
