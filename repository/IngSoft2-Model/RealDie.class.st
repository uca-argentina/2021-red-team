Class {
	#name : #RealDie,
	#superclass : #Die,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RealDie >> roll [
	^ (1 to: faces) atRandom.
]
