"
A GMMSEGeneratorWizardTest is a test class for testing the behavior of GMMSEGeneratorWizard
"
Class {
	#name : #MooseEasyFamixMakerTest,
	#superclass : #TestCase,
	#instVars : [
		'wizard'
	],
	#category : #'Moose-Easy-Tests'
}

{ #category : #utilities }
MooseEasyFamixMakerTest >> javaSourcePathForTesting [
	| path |
	path := self resourcesFileReference / 'sampleJavaProject'
		/ 'FactoryVariants'.
	path exists
		ifFalse: [ self
				error:
					'The testing path to the Java sources is invalid and needs proper defining. It must be valid in a Bourne Shell. See https://fuhrmanator.github.io/2019/03/16/LibC-Pharo-experiments.html' ].
	^ path
]

{ #category : #utilities }
MooseEasyFamixMakerTest >> mseDestinationPathForTesting [
	| path |
	path := 'FactoryVariants.mse' asFileReference.
	path parent exists
		ifFalse: [ self
				error:
					'The testing path to the MSE output directory is invalid and needs proper defining. It must be valid in a Bourne Shell. See https://fuhrmanator.github.io/2019/03/16/LibC-Pharo-experiments.html' ].
	^ path
]

{ #category : #running }
MooseEasyFamixMakerTest >> resourcesFileReference [
	| repo |
	repo := (IceRepository registry
		detect: [ :each | each includesPackageNamed: 'Moose-Easy-Tests' ]
		ifNone: [ self
				error:
					'Please add a clone of this project to Iceberg to access to the resources' ])
		location.
	^ repo / 'resources'
]

{ #category : #running }
MooseEasyFamixMakerTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	wizard := MooseEasyFamixMaker new.
]

{ #category : #tests }
MooseEasyFamixMakerTest >> testGenerateMSE [
	wizard := MooseEasyFamixMaker
		generateMSETo: self mseDestinationPathForTesting
		parsing: self javaSourcePathForTesting
		with: self verveineJScriptPathForTesting.
	self mseDestinationPathForTesting ensureDelete.
	wizard generateMSE.
	self assert: wizard mseDestinationPath asFileReference exists
]

{ #category : #tests }
MooseEasyFamixMakerTest >> testJavaSourcePath [
	| path |
	path := self javaSourcePathForTesting asFileReference .
	wizard javaSourcePath: path.
	self assert: wizard javaSourcePath equals: path
]

{ #category : #tests }
MooseEasyFamixMakerTest >> testMseDestinationPath [
	| path |
	path := self mseDestinationPathForTesting asFileReference .
	wizard mseDestinationPath: path.
	self assert: wizard mseDestinationPath equals: path
]

{ #category : #tests }
MooseEasyFamixMakerTest >> testVerveineJScriptPath [
	"should return a file path that ends with verveinej.sh"
	| expectedPath path |
	expectedPath := self verveineJScriptPathForTesting.
	wizard verveineJScriptPath: expectedPath.
	path := wizard verveineJScriptPath.
	self assert: expectedPath equals: path.
]

{ #category : #utilities }
MooseEasyFamixMakerTest >> verveineJScriptPathForTesting [
	| path |
	Smalltalk os current isWindows
		ifTrue:
			[ path := self resourcesFileReference / 'VerveineJ' / 'verveinej.bat' ]
		ifFalse: [ path := self resourcesFileReference / 'VerveineJ' / 'verveinej.sh' ].
	path exists
		ifFalse: [ self
				error:
					'The testing path to the VerveineJ.sh script is invalid and needs proper defining. It must be valid in a Bourne Shell. See https://fuhrmanator.github.io/2019/03/16/LibC-Pharo-experiments.html' ].
	^ path
]
