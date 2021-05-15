Class {
	#name : #RandomGenerator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
RandomGenerator >> randomize: aCollection [ 
	| newCollection |
	newCollection := aCollection copy.
	^ newCollection shuffle.
]
