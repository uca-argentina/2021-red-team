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
	(aProbability < 0 or: [aProbability > 1]) ifTrue: [ self error: 'Cant create a DiscreteProbabilityEvent with an invalid probabilty' ].
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
