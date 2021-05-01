Class {
	#name : #RandomDie,
	#superclass : #Die,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RandomDie >> roll [
	^ (1 to: faces) atRandom.
]
