Class {
	#name : #LoadedDie,
	#superclass : #Die,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
LoadedDie >> roll [
	^ ((faces//2)+1)
]
