Class {
	#name : #SequenceOfPlayers,
	#superclass : #Object,
	#instVars : [
		'orderOfPlayers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SequenceOfPlayers class >> with: players [
	players ifEmpty: [ self error: 'cannot create a sequenceOfPlayers without players' ].
	^ self new initializeWith: players.
]

{ #category : #actions }
SequenceOfPlayers >> finishTurn [
	| currentPlayer |
	currentPlayer := orderOfPlayers removeFirst.
	orderOfPlayers addLast: currentPlayer.
]

{ #category : #initialize }
SequenceOfPlayers >> initializeWith: players [
	orderOfPlayers := players asOrderedCollection.
]

{ #category : #queries }
SequenceOfPlayers >> whosNext [
	| currentPlayer |
	currentPlayer := orderOfPlayers removeFirst.
	orderOfPlayers addLast: currentPlayer.
	^ currentPlayer.
]

{ #category : #queries }
SequenceOfPlayers >> whosTurnIsIt [
	^ orderOfPlayers first.
]
