"
I am a collection of functions useful for dealing with LibC in the context of creating MSE files.
"
Class {
	#name : #MooseEasyUtility,
	#superclass : #Object,
	#category : #'Moose-Easy'
}

{ #category : #'as yet unclassified' }
MooseEasyUtility class >> abortWithErrorMessageFromFileReference: fileRef title: title [
	"Show abort dialog and the message from the error output file"

	| displayText |
	displayText := fileRef readStreamEncoded: 'cp-1250' do: [ :stream |
        stream upToEnd ].
	AssertionFailure signal: title , ': ' , displayText.
]

{ #category : #'as yet unclassified' }
MooseEasyUtility class >> createJavaMSEOn: revPath using: pathToJavaToFamixCommand named: mseFileName [
	"create an MSE file from the source code in revPath using VerveineJ parser"

	| command result working javaToFamixOutput javaToFamixErrors verveineJOptions |
	working := FileSystem disk workingDirectory.
	javaToFamixOutput := working / 'tmp' / 'output_java_to_famix'.
	javaToFamixErrors := working / 'tmp' / 'errors_java_to_famix'.
	verveineJOptions := '-Xms1g -Xmx15g -- -o "' , mseFileName
		, '" -anchor assoc -alllocals .'.	"-localaccesses -autocp "
	command := 'cd "' , revPath asFileReference pathString , '" && "'
		, pathToJavaToFamixCommand , '" ' , verveineJOptions , ' > "'
		, javaToFamixOutput fullName , '"' , ' 2> "'
		, javaToFamixErrors fullName , '"'.
	result := LibC runCommand: command.
	result = 0
		ifFalse: [ self
				abortWithErrorMessageFromFileReference: javaToFamixErrors
				title: 'The command ''' , command , ''' terminated with errors' ].
	^ result
]
