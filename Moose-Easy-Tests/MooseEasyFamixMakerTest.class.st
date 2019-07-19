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

{ #category : #test }
MooseEasyFamixMakerTest >> javaSourcePathForTesting [
	| path |
	path := '/mnt/c/Users/fuhrm/Documents/GitHub/FactoryVariants' asFileReference.
	"path := 'C:/Users/fuhrm/Documents/GitHub/FactoryVariants' asFileReference."
	path exists
		ifFalse: [ self
				error:
					'The testing path to the Java sources is invalid and needs proper defining. It must be valid in a Bourne Shell. See https://fuhrmanator.github.io/2019/03/16/LibC-Pharo-experiments.html' ].
	^ path
]

{ #category : #test }
MooseEasyFamixMakerTest >> mseDestinationPathForTesting [
	| path |
	path := '/home/cfuhrman/FactoryVariants.mse' asFileReference.
	"path := 'c:/users/fuhrm/Desktop/FactoryVariants.mse' asFileReference."
	path parent exists
		ifFalse: [ self
				error:
					'The testing path to the MSE output directory is invalid and needs proper defining. It must be valid in a Bourne Shell. See https://fuhrmanator.github.io/2019/03/16/LibC-Pharo-experiments.html' ].
	^ path
]

{ #category : #running }
MooseEasyFamixMakerTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	wizard := MooseEasyFamixMaker new.
]

{ #category : #test }
MooseEasyFamixMakerTest >> testGenerateMSE [
	wizard
		verveineJScriptPath: self verveineJScriptPathForTesting;
		javaSourcePath: self javaSourcePathForTesting;
		mseDestinationPath: self mseDestinationPathForTesting.
	self mseDestinationPathForTesting ensureDelete.
	wizard generateMSE.
	self assert: wizard mseDestinationPath asFileReference exists
]

{ #category : #test }
MooseEasyFamixMakerTest >> testJavaSourcePath [
	| path |
	path := self javaSourcePathForTesting asFileReference .
	wizard javaSourcePath: path.
	self assert: wizard javaSourcePath equals: path
]

{ #category : #test }
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

{ #category : #test }
MooseEasyFamixMakerTest >> verveineJScriptPathForTesting [
	| path |
	path := '/mnt/c/Users/fuhrm/Documents/git_repos/VerveineJ/verveinej.sh' asFileReference.
"	path := 'c:/Users/fuhrm/Documents/git_repos/VerveineJ/verveinej_bourne_shell.sh' asFileReference."
	path exists
		ifFalse: [ self
				error:
					'The testing path to the VerveineJ.sh script is invalid and needs proper defining. It must be valid in a Bourne Shell. See https://fuhrmanator.github.io/2019/03/16/LibC-Pharo-experiments.html' ].
	^ path
]
