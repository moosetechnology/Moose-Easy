"
I am a Spec2 presenter representing the GUI for creating MSE files using VerveineJ.

I rely on MooseEasyFamixMaker.
"
Class {
	#name : #MooseEasyFamixMakerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'javaSourcePresenter',
		'parserPresenter',
		'destinationPresenter',
		'generateMSEButton',
		'selectSourceButton',
		'selectParserButton',
		'selectDestinationButton',
		'fileName',
		'wizard',
		'feedbackMessage',
		'indeterminated'
	],
	#category : #'Moose-Easy'
}

{ #category : #specs }
MooseEasyFamixMakerPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: '' withConstraints: [ :constraints | constraints height: 10 ];
		add:
			(SpBoxLayout newHorizontal
				add: #javaSourcePresenter;
				add:
					(SpBoxLayout newVertical
						add: #selectSourceButton
						withConstraints: [ :constraints | constraints height: 25 ])
					withConstraints: [ :constraints | constraints width: 25 ])
			withConstraints: [ :constraints | constraints height: 40 ];
		add:
			(SpBoxLayout newHorizontal
				add: #parserPresenter;
				add:
					(SpBoxLayout newVertical
						add: #selectParserButton
						withConstraints: [ :constraints | constraints height: 25 ])
					withConstraints: [ :constraints | constraints width: 25 ])
			withConstraints: [ :constraints | constraints height: 40 ];
		add:
			(SpBoxLayout newHorizontal
				add: #destinationPresenter;
				add:
					(SpBoxLayout newVertical
						add: #selectDestinationButton
						withConstraints: [ :constraints | constraints height: 25 ])
					withConstraints: [ :constraints | constraints width: 25 ])
			withConstraints: [ :constraints | constraints height: 40 ];
		add:
			(SpBoxLayout newHorizontal
				add: #fileName;
				add:
					(SpBoxLayout newVertical
						add: '.mse'
						withConstraints: [ :constraints | constraints height: 25 ])
					withConstraints: [ :constraints | constraints width: 30 ])
			withConstraints: [ :constraints | constraints height: 40 ];
				add: #generateMSEButton
				withConstraints: [ :constraints | 
					constraints
						height: 40; width: 150 ];
		add: #indeterminated withConstraints: [ :constraints | constraints height: 10 ];
		add: #feedbackMessage
			withConstraints: [ :constraints | constraints height: 170 ];
		yourself
]

{ #category : #examples }
MooseEasyFamixMakerPresenter class >> open [
	<example>
	^ self new openWithSpec
]

{ #category : #action }
MooseEasyFamixMakerPresenter >> generateMSEAction [
	| destinationPath |
	destinationPath := destinationPresenter input text asFileReference
		/ fileName input text , 'mse'.
	indeterminated := self newProgressBar.
	indeterminated indeterminate.
	wizard := MooseEasyFamixMaker new.
	[ :job | 
	feedbackMessage
		text:
			'Generating MSE file: ' , destinationPath pathString
				, ' -- Please wait...'.
	job title: feedbackMessage text.
	wizard
		javaSourcePath: javaSourcePresenter input text asFileReference;
		verveineJScriptPath: parserPresenter input text asFileReference;
		mseDestinationPath: destinationPath.
	wizard generateMSE.
	indeterminated := self newNullPresenter.
	wizard mseDestinationPath asFileReference exists
		ifTrue: [ feedbackMessage
				text:
					'MSE file successfully generated at: ' , destinationPath pathString
						, String cr
						, 'Open it in Moose with the following command in a Playground: '
						, String cr , self loadMooseCodePart1
						, destinationPath pathString , self loadMooseCodePart2 ]
		ifFalse: [ feedbackMessage text: 'MSE file NOT generated.' ] ] asJob
		run
]

{ #category : #accessing }
MooseEasyFamixMakerPresenter >> indeterminated [
	^ indeterminated
]

{ #category : #accessing }
MooseEasyFamixMakerPresenter >> indeterminated: anObject [
	indeterminated := anObject
]

{ #category : #initialization }
MooseEasyFamixMakerPresenter >> initialExtent [
	^ 600 @ 250 + 190
]

{ #category : #initialization }
MooseEasyFamixMakerPresenter >> initializePresenter [
	javaSourcePresenter input whenTextChangedDo: [ self verifyPaths ].
	parserPresenter input whenTextChangedDo: [ self verifyPaths ].
	destinationPresenter input whenTextChangedDo: [ self verifyPaths ].
	fileName input whenTextChangedDo: [ self verifyPaths ].
	selectSourceButton action: [ self selectSource ].
	selectParserButton action: [ self selectParser ].
	selectDestinationButton action: [ self selectDestination ].
	generateMSEButton
		action: [ 
			self generateMSEAction ]
]

{ #category : #initialization }
MooseEasyFamixMakerPresenter >> initializeWidgets [
	javaSourcePresenter := self
		instantiate:
			(SpLabelledPresenter
				label: 'Java source path: '
				input:
					(self newTextInput
						autoAccept: true;
						placeholder: 'The path to a Java project for which to generate the MSE file')).
	selectSourceButton := self newButton
		icon: (self iconNamed: 'glamorousOpen').
	parserPresenter := self
		instantiate:
			(SpLabelledPresenter
				label: 'Parser path: '
				input:
					(self newTextInput
						autoAccept: true;
						placeholder: 'The path to a Java-to-MSE parser such as VerveineJ')).
	parserPresenter
		description:
			'See https://github.com/NicolasAnquetil/VerveineJ (verveinej.sh) for a parser.'.
	selectParserButton := self newButton
		icon: (self iconNamed: 'glamorousOpen').
	destinationPresenter := self
		instantiate:
			(SpLabelledPresenter
				label: 'Destination path: '
				input: (self newTextInput autoAccept: true;
						placeholder: 'The path where the MSE file will be created')).
	selectDestinationButton := self newButton
		icon: (self iconNamed: 'glamorousOpen').
	fileName := self
		instantiate:
			(SpLabelledPresenter
				label: 'File name: '
				input: (self newTextInput autoAccept: true;
						placeholder: 'The name of the MSE file (without the .mse extension)')).
	generateMSEButton := self newButton
		label: 'Generate MSE file';
		disable.
	indeterminated := self newNullPresenter.
	feedbackMessage := self
		instantiate:
			(SpTextPresenter new
				text: '';
				disable).
	self focusOrder
		add: javaSourcePresenter;
		add: parserPresenter;
		add: destinationPresenter;
		add: fileName
]

{ #category : #initialization }
MooseEasyFamixMakerPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: self title;
		initialExtent: self initialExtent
]

{ #category : #'as yet unclassified' }
MooseEasyFamixMakerPresenter >> loadMooseCodePart1 [
	^ '"Load the moose Model with some error checking"
	| mseFileRef mseStream mooseModel |
	mseFileRef := '''

]

{ #category : #'as yet unclassified' }
MooseEasyFamixMakerPresenter >> loadMooseCodePart2 [
	^''' asFileReference. "Generated by FamixMaker"
	mseStream := mseFileRef readStream.
	mseStream
		ifNotNil: [ 
			mooseModel := MooseModel importFromMSEStream: mseStream. 
			mooseModel install. "So it appears in the Panel"
			mseStream close. ]
		ifNil: [ self error: ''Could not load MSE file into Moose: '' , mseFileRef asString ].
'

]

{ #category : #action }
MooseEasyFamixMakerPresenter >> manageButton [
	javaSourcePresenter input text ifEmpty: [ ^ false ].
	parserPresenter input text ifEmpty: [ ^ false ].
	destinationPresenter input text ifEmpty: [ ^ false ].
	fileName input text ifEmpty: [ ^ false ].
	^ javaSourcePresenter input text asFileReference exists
		& parserPresenter input text asFileReference exists
		& destinationPresenter input text asFileReference exists
]

{ #category : #action }
MooseEasyFamixMakerPresenter >> selectDestination [
	| reference lastPath |
	lastPath := destinationPresenter input text asFileReference.
	lastPath exists
		ifFalse: [ lastPath := FileLocator home ].
	reference := UIManager default
		chooseExistingFileReference: 'Select a destination'
		extensions: ''
		path: lastPath.
	reference
		ifNotNil: [ destinationPresenter input text: reference pathString ]
]

{ #category : #action }
MooseEasyFamixMakerPresenter >> selectParser [
	| reference lastPath |
	lastPath := parserPresenter input text asFileReference.
	lastPath exists
		ifFalse: [ lastPath := FileLocator home ].
	reference := UIManager default
		chooseExistingFileReference: 'Select a parser'
		extensions: #('bat' 'sh')
		path: lastPath.
(	reference isNotNil and:[reference extension = 'bat' or:[reference extension = 'sh'] ])
		ifTrue: [ parserPresenter input text: reference pathString ]
]

{ #category : #action }
MooseEasyFamixMakerPresenter >> selectSource [
	| reference lastPath |
	lastPath := javaSourcePresenter input text asFileReference.
	lastPath exists
		ifFalse: [ lastPath := FileLocator home ].
	reference := UIManager default
		chooseExistingFileReference: 'Select a Java source'
		extensions: ''
		path: lastPath.
	reference
		ifNotNil: [ javaSourcePresenter  input text: reference pathString ]
]

{ #category : #api }
MooseEasyFamixMakerPresenter >> title [
^'Moose Easy Famix Maker'
]

{ #category : #'as yet unclassified' }
MooseEasyFamixMakerPresenter >> verifyPaths [
	| green red newFeedbackMsgText |
	green := Color red: 240 green: 255 blue: 240.
	red := Color red: 255 green: 240 blue: 240.
	generateMSEButton enabled: self manageButton.
	newFeedbackMsgText := ''.
	javaSourcePresenter input
		color:
			(javaSourcePresenter input text asFileReference exists
				& javaSourcePresenter input text isNotEmpty
				ifTrue: [ green ]
				ifFalse: [ newFeedbackMsgText := newFeedbackMsgText , 'Java source path is invalid. '. red ]).
	parserPresenter input
		color:
			(parserPresenter input text asFileReference isFile
				ifTrue: [ green ]
				ifFalse: [ newFeedbackMsgText := newFeedbackMsgText , 'Parser path is invalid. '. red ]).
	destinationPresenter input
		color:
			(destinationPresenter input text asFileReference exists
				& destinationPresenter input text isNotEmpty
				ifTrue: [ green ]
				ifFalse: [ newFeedbackMsgText := newFeedbackMsgText , 'Destination path is invalid. '. red ]).
	feedbackMessage text: newFeedbackMsgText; color: (newFeedbackMsgText isEmpty ifTrue:[ Color white ] ifFalse:[ red]).

]