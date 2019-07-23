Class {
	#name : #BaselineOfMooseEasy,
	#superclass : #BaselineOf,
	#category : #BaselineOfMooseEasy
}

{ #category : #baselines }
BaselineOfMooseEasy >> baseline: spec [
	<baseline>
	spec
		for: #common
		do:
			[ "Don't load Moose finally, it's heavy. Recommend users to start with CI image."
			spec preLoadDoIt: #verifyMooseInstalled.
			"Packages"
			spec
				package: 'Moose-Easy';
				package: 'Moose-Easy-Tests'
					with: [ spec requires: #('Moose-Easy') ] ]
]

{ #category : #baselines }
BaselineOfMooseEasy >> verifyMooseInstalled [
	self class environment
		at: #MooseModel
		ifAbsent: [ UIManager default
				abort:
					'Moose must be installed prior to loading GitMiner. The baseline doesn''t load it because it''s big. We recommend loading it from the GitHub repo, or starting with a Moose image from Pharo Launcher.' ]
]
