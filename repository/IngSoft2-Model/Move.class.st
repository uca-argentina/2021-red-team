Class {
	#name : #Move,
	#superclass : #Object,
	#instVars : [
		'player',
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Move class >> from: aPlayer with: aCard [
	^ self new initializeWith: aPlayer andWith: aCard.
]

{ #category : #actions }
Move >> activateEffect: game [ 
	card activateEffectWith: game and: self.
]

{ #category : #queries }
Move >> card [
	^ card
]

{ #category : #actions }
Move >> changeCard: aCard [ 
	^ Move from: player with: aCard.
]

{ #category : #queries }
Move >> effectOn: aPlayer [
	^ card effect.
]

{ #category : #initialize }
Move >> initializeWith: aPlayer andWith: aCard [
	player := aPlayer.
	card := aCard.
]

{ #category : #actions }
Move >> source [
	^ player.
]
