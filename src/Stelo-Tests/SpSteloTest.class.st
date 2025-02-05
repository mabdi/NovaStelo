"
A SpSteloTest is a test class for testing the behavior of SpStelo
"
Class {
	#name : #SpSteloTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SpSteloTest >> newApp [
	^ SpStelo new
]

{ #category : #private }
SpSteloTest >> newProject [
	^ SteloProject new
]

{ #category : #test }
SpSteloTest >> testAddTurtles [
	| app proj ret |
	app := self newApp.
	proj := self newProject.
	app installNewProject: proj.
	self assert: proj scripts size equals: 3.
	self assert: app sworld privBreeds size equals: 3.
	ret := app addTurtles.
	self assert: ret breedNo equals: 4.
	self assert: proj scripts size equals: 4.
	self assert: app sworld privBreeds size equals: 4.
	self assert: (ret isKindOf: TurtlesScript).
	self assert: (proj scriptOf: 4) equals: ret.
	self assert: (app sworld breedOf: 4) equals: ret breed
]

{ #category : #test }
SpSteloTest >> testDeleteTurtles [
	| app proj ret t3 t4 |
	app := self newApp.
	proj := self newProject.
	app installNewProject: proj.
	self assert: proj scripts size equals: 3.
	self assert: app sworld privBreeds size equals: 3.
	ret := app addTurtles.
	self assert: ret breedNo equals: 4.
	t3 := proj scriptOf: 3.
	t4 := proj scriptOf: 4.
	self assert: ret equals: t4.
	app deleteTurtles: 4.
	self assert: proj scripts size equals: 3.
	self
		assert: (app sworld privBreeds count: [ :each | each notNil ])
		equals: 3.
	ret := app addTurtles.
	self assert: ret breedNo equals: 5.
	self assert: (proj scriptOf: 3) equals: t3.
	t4 := proj scriptOf: 5.
	self assert: ret equals: t4.
	app deleteTurtles: 3.
	self assert: (proj scriptOf: 5) equals: t4.
	self assert: proj scripts size equals: 3.
	self
		assert: (app sworld privBreeds count: [ :each | each notNil ])
		equals: 3.
]
