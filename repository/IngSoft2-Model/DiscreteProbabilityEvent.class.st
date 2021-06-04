Class {
	#name : #DiscreteProbabilityEvent,
	#superclass : #Object,
	#instVars : [
		'event',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiscreteProbabilityEvent class >> of: anEvent with: aProbability [
	^self new initializeWith: anEvent andWith: aProbability.
]

{ #category : #queries }
DiscreteProbabilityEvent >> event [
	^ event
]

{ #category : #initialize }
DiscreteProbabilityEvent >> initializeWith: anEvent andWith: aProbability [  
	event := anEvent.
	probability := aProbability .
]

{ #category : #queries }
DiscreteProbabilityEvent >> probability [
	^ probability
]
