Class {
	#name : #MooseEasyUtilityTest,
	#superclass : #TestCase,
	#category : #'Moose-Easy-Tests'
}

{ #category : #tests }
MooseEasyUtilityTest >> testCloneGitHubRepo [
	self
		assert:
			(MooseEasyUtility
				cloneGitHubRepo: 'https://github.com/fuhrmanator/FactoryVariants')
		equals:
			FileSystem disk workingDirectory / 'tmp' / 'MooseEasyRepos'
				/ 'fuhrmanator__FactoryVariants'
]

{ #category : #tests }
MooseEasyUtilityTest >> testExtractProjectNameFromGitHubURL [
	self
		assert:
			(MooseEasyUtility
				extractProjectNameFromGitHubURL: 'https://github.com/fuhrmanator/FactoryVariants')
		equals: 'fuhrmanator__FactoryVariants'
]
