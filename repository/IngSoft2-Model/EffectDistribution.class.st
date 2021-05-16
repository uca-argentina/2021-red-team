Class {
	#name : #EffectDistribution,
	#superclass : #Object,
	#instVars : [
		'cellType',
		'proportion'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
EffectDistribution class >> of: aCell with: aProportion [
	(aProportion>0 & aProportion<=1 ) ifFalse: [ self error: 'invalid proportion' ].
	^self new intializeWith: aCell and: aProportion .
]

{ #category : #queries }
EffectDistribution >> elementType [
	^ cellType .
]

{ #category : #initialize }
EffectDistribution >> intializeWith: aCell and: aProportion [
	cellType := aCell.
	proportion := aProportion .
]

{ #category : #queries }
EffectDistribution >> proportion [
	^ proportion
]
