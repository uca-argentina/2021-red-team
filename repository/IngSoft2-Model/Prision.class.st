Class {
	#name : #Prision,
	#superclass : #Object,
	#instVars : [
		'prisioners'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Prision class >> with: anOrderedCollection [
	^self new initializeWith: anOrderedCollection .
]

{ #category : #action }
Prision >> addPrisioner: playerName [.
	(self isArrested: playerName)
		ifFalse: [ prisioners add: playerName ].
	
	
]

{ #category : #actions }
Prision >> assertFreedom: playerName with: aDieHandle and: rollValue [   
	(aDieHandle hasRolledMax: rollValue)
		ifTrue: [ self breakFree: playerName ].
]

{ #category : #actions }
Prision >> breakFree: playerName [ 
	prisioners remove: playerName .
]

{ #category : #initialize }
Prision >> initializeWith: anOrderedCollection [ 
	prisioners := anOrderedCollection .
]

{ #category : #queries }
Prision >> isArrested: playerName [
	^ prisioners anySatisfy: [ :prisioner | prisioner = playerName  ].
]
