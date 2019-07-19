"
I am a facade to create FAMIX MSE files easily in Pharo Moose.

I rely on LibC, which allows me to work on all platforms. 
"
Class {
	#name : #MooseEasyFamixMaker,
	#superclass : #Object,
	#instVars : [
		'verveineJScriptPath',
		'mseDestinationPath',
		'javaSourcePath'
	],
	#category : #'Moose-Easy'
}

{ #category : #'as yet unclassified' }
MooseEasyFamixMaker >> generateMSE [
	"Launch the parser"
	MooseEasyUtility createJavaMSEOn: (javaSourcePath asPath) using: (verveineJScriptPath pathString) named: (mseDestinationPath pathString). 
]

{ #category : #accessing }
MooseEasyFamixMaker >> javaSourcePath [
	^ javaSourcePath
]

{ #category : #accessing }
MooseEasyFamixMaker >> javaSourcePath: aString [
	javaSourcePath := aString
]

{ #category : #accessing }
MooseEasyFamixMaker >> mseDestinationPath [
	^ mseDestinationPath
]

{ #category : #accessing }
MooseEasyFamixMaker >> mseDestinationPath: anObject [
	mseDestinationPath := anObject
]

{ #category : #acccessing }
MooseEasyFamixMaker >> verveineJScriptPath [
	verveineJScriptPath isNil
		ifTrue: [ verveineJScriptPath := GMUtility queryJavaToFamixCommand ].
	^ verveineJScriptPath
]

{ #category : #acccessing }
MooseEasyFamixMaker >> verveineJScriptPath: pathString [
	verveineJScriptPath := pathString.
]
