Class {
	#name : #AssignatedCard,
	#superclass : #Object,
	#instVars : [
		'player',
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AssignatedCard class >> from: aPlayer with: aCard [
	^self new initializeWith: aPlayer andWith: aCard.
]

{ #category : #initialize }
AssignatedCard >> initializeWith: aPlayer andWith: aCard [
	player := aPlayer.
	card := aCard.
]

{ #category : #queries }
AssignatedCard >> isAssignated: aCard To: aPlayer [
	^ ((aCard equals: card) and: [aPlayer = player])
]
