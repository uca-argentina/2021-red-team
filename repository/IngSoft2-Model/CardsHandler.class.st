Class {
	#name : #CardsHandler,
	#superclass : #Object,
	#instVars : [
		'assignatedCards',
		'deck',
		'permanentMoves',
		'lastMove'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardsHandler class >> with: players andWith: deck [ 
	| auxCards |
	auxCards := OrderedCollection new.
	players do: [ :playerName | 2 timesRepeat: [auxCards add: (AssignatedCard from: playerName with: (deck takeACard))]].
	^ self new initializeWith: auxCards andWith: deck.
]

{ #category : #initialize }
CardsHandler >> accumulatePermanentEffectsOn: player [
	^ permanentMoves ifEmpty: [ 0 ] ifNotEmpty: [permanentMoves sum: [ :move | move effectOn: player]].
]

{ #category : #initialize }
CardsHandler >> addCardTo: aPlayerName [
	assignatedCards add: (AssignatedCard from: aPlayerName with: deck takeACard).
]

{ #category : #initialize }
CardsHandler >> addToPermanentMoves: aMove [
	permanentMoves add: aMove copy.
]

{ #category : #initialize }
CardsHandler >> amountOfMoves [
	^ assignatedCards size.
]

{ #category : #initialize }
CardsHandler >> handle: aMove with: aGame [
	self verifyIfCardIsAssignated: aMove.
	aMove activateEffect: aGame.
	self updateLastMove: aMove
]

{ #category : #initialize }
CardsHandler >> initializeWith: auxAssignatedCards andWith: aDeck [
	assignatedCards := auxAssignatedCards.
	deck := aDeck.
	permanentMoves := OrderedCollection new.
]

{ #category : #initialize }
CardsHandler >> removePermanentMove: aMove [ 
	permanentMoves ifEmpty: [ self error: 'there are no permanent cards' ].
	permanentMoves := permanentMoves reject: [ :move | move equalsMove: aMove ].
]

{ #category : #initialize }
CardsHandler >> updateLastMove: aMove [
	(aMove card equals: RedoCard new)
		ifFalse: [ lastMove := aMove copy ]
]

{ #category : #initialize }
CardsHandler >> useLastCardEffectWith: aMove andWith: aGame [
	| newCard newMove |
	lastMove ifNil: [ self error: 'Cant use a Redo Card without previews moves' ].
	newCard := lastMove card copy.
	newMove := aMove changeCard: newCard.
	assignatedCards add: (AssignatedCard from: newMove source with: newMove card).
	self handle: newMove with: aGame.
]

{ #category : #initialize }
CardsHandler >> verifyIfCardIsAssignated: aMove [
	assignatedCards
		detect: [ :assignatedCard | 
			assignatedCard player = aMove source
				and: [ assignatedCard card equals: aMove card ] ]
		ifFound: [ :assignatedCard | assignatedCards remove: assignatedCard ]
		ifNone: [ self error: 'cant use a card thats not yours' ]
]
