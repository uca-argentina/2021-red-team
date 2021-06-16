Class {
	#name : #PositionsBoard,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionsBoard class >> with: somePositions [
	somePositions ifEmpty: [ self error: 'cannot create a boardOfPositions without positions' ].
	^ self new initializeWith: somePositions .
]

{ #category : #queries }
PositionsBoard >> anyPlayerFinished: laps withBoardOfSize: cells [
	^ (positions anySatisfy: [ :position | (position valueOfPosition) > (cells*laps) ]).
]

{ #category : #queries }
PositionsBoard >> arePlaying: players [
	| playersInBoard |
	playersInBoard := positions collect: [ :aPosition | aPosition nameOfPlayer].
	^ players asOrderedCollection = playersInBoard 
]

{ #category : #queries }
PositionsBoard >> findPositionOf: name in: collection [
	^ collection detect: [ :position | position nameOfPlayer = name ] ifNone: [ self error: 'That player is not in the game' ].
]

{ #category : #initialize }
PositionsBoard >> initializeWith: somePositions [
	positions := somePositions.
	
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
	positions
		do: [ :position | 
			actualPositionOnLap := position valueOfPosition \\ lapSize.
			moveBackwards := actualPositionOnLap = 0
				ifTrue: [ -1 * lapSize + 1 ]
				ifFalse: [ -1 * actualPositionOnLap + 1 ].
			self updatePositionOf: position nameOfPlayer with: moveBackwards ]
]

{ #category : #queries }
PositionsBoard >> orderedPositions [
	^ positions asSortedCollection: [ :positionA :positionB | positionA >= positionB ]
]

{ #category : #queries }
PositionsBoard >> positionOf: name [  
	| position |
	position := self findPositionOf: name in: positions.
	^ position valueOfPosition.
]

{ #category : #queries }
PositionsBoard >> rankingOf: name [
	| ranking positionOfPlayer indexOfPlayer |
	ranking := self orderedPositions.
	positionOfPlayer := self findPositionOf: name in: ranking.
	indexOfPlayer := ranking indexOf: positionOfPlayer.
	^ indexOfPlayer
]

{ #category : #actions }
PositionsBoard >> selectAllPositionsExcept: player [
	^ positions
		select: [ :position | (position nameOfPlayer ~= player) ]
]

{ #category : #actions }
PositionsBoard >> updatePositionOf: name with: value [
	| newPosition oldPosition |
	oldPosition := self findPositionOf: name in: positions.
	newPosition := oldPosition updateWith: value.
	positions replaceAll: oldPosition with: newPosition.
]

{ #category : #queries }
PositionsBoard >> whosFirst [
	| podium |
	podium := self orderedPositions.
	^(podium first) nameOfPlayer .
]
