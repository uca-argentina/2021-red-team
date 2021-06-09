Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RepeatCard >> activateEffectWith: redGame and: aMove [ 
	redGame useLastBoardEffectOn: aMove target.
]

{ #category : #actions }
RepeatCard >> equals: anotherCard [
	^ self class = anotherCard class.
]
