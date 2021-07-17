Class {
	#name : #HalfLoadedDie,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HalfLoadedDie class >> with: aNumberOfFaces [
	(aNumberOfFaces >= 3 ) ifFalse: [ self error: 'invalid number of faces' ].
	^ self new initializeWith: aNumberOfFaces.
]

{ #category : #initialize }
HalfLoadedDie >> initializeWith: aNumberOfFaces [
	faces := aNumberOfFaces.
]

{ #category : #actions }
HalfLoadedDie >> roll [
	^ faces // 2.
]
