"
I am a collection of functions useful for dealing with LibC in the context of creating MSE files.
"
Class {
	#name : #MooseEasyUtility,
	#superclass : #Object,
	#category : #'Moose-Easy'
}

{ #category : #utility }
MooseEasyUtility class >> abortWithErrorMessageFromFileReference: fileRef title: title [
	"Show abort dialog and the message from the error output file"

	| displayText |
	displayText := fileRef readStreamEncoded: 'cp-1250' do: [ :stream |
        stream upToEnd ].
	AssertionFailure signal: title , ': ' , displayText.
]

{ #category : #utility }
MooseEasyUtility class >> cloneGitHubRepo: url [
	"clone a repo of a project (if it doesn't already exist) and return its location "

	| projectName location reposDir |
	reposDir := FileSystem disk workingDirectory / 'tmp'
		/ 'MooseEasyRepos'.
	reposDir ensureCreateDirectory.
	projectName := self extractProjectNameFromGitHubURL: url.
	location := reposDir / projectName.
	location exists
		ifFalse: [ | cloneCommand working gitErrors result |
			working := FileSystem disk workingDirectory.
			gitErrors := working / 'tmp' / 'errors_gitClone'.
			"Command to extract the revision from git into a temp dir so we can generate an MSE file for it"
			cloneCommand := 'cd "' , reposDir fullName , '" && git clone '
				, url , ' ' , projectName , ' 2>"' , gitErrors fullName , '"'.
			"'LibC: About to run command: ' crLog.
			(' > ', cloneCommand) crLog."
			result := LibC runCommand: cloneCommand.
			result = 0
				ifFalse: [ self
						abortWithErrorMessageFromFileReference: gitErrors asFileReference
						title: 'Failed to execute: ' , cloneCommand ] ].
	self assert: location exists.
	^ location
]

{ #category : #utility }
MooseEasyUtility class >> createJavaMSEOn: revPath using: pathToJavaToFamixCommand named: mseFileName [
	"create an MSE file from the source code in revPath using VerveineJ parser"

	| command result working javaToFamixOutput javaToFamixErrors verveineJOptions |
	working := FileSystem disk workingDirectory.
	(working / 'tmp') ensureCreateDirectory.
	javaToFamixOutput := working / 'tmp' / 'output_java_to_famix'.
	javaToFamixErrors := working / 'tmp' / 'errors_java_to_famix'.
	verveineJOptions := '-o "' , mseFileName
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

{ #category : #utility }
MooseEasyUtility class >> extractProjectNameFromGitHubURL: url [
	"Get project name from URL, accounting for cases where it ends in .git"
	| splitted githubUserName projectName |
	splitted := url splitOn: '/'.
	githubUserName := splitted fourth.
	projectName := splitted fifth.
	(projectName endsWith: '.git')
		ifTrue: [ projectName := projectName allButLast: '.git' size ].
	"Make sure name is unique by putting username before it with '__' as separator" 
	" underscore is not a valid character in GitHub usernames according to https://www.npmjs.com/package/github-username-regex"
	^  githubUserName , '__' , projectName  
]
