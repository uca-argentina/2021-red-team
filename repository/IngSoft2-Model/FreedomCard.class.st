Class {
	#name : #FreedomCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
FreedomCard >> activateEffectWith: aRedGame and: aMove [ 
	aRedGame breakFree: (aMove source).
]

{ #category : #actions }
FreedomCard >> equals: anotherCard [
	^ self class = anotherCard class.
]
