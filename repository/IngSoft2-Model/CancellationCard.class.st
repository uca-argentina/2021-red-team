Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CancellationCard >> activateEffectWith: game and: aMove [ 
	game removePermanentMove: (aMove target).
]

{ #category : #actions }
CancellationCard >> equals: anotherCard [
	^ self class = anotherCard class.
]
