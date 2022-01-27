"
A SColorListTest is a test class for testing the behavior of SColorList
"
Class {
	#name : #SColorListTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #tests }
SColorListTest >> testScaleValueColorFromTo [
	| br c |
	br := SColorList.
	c := br scaleValue: 0 color: 35 from: 1 to: 9.
	self assert: c equals: SColorList black.
	c := br scaleValue: 10 color: 35 from: 1 to: 9.
	self assert: c equals: SColorList white.
	c := br scaleValue: 5 color: 35 from: 1 to: 9.
	self assert: c equals: 34.
	c := br scaleValue: 1 color: 35 from: 1 to: 9.
	self assert: c equals: 30.
	c := br scaleValue: 9 color: 35 from: 1 to: 9.
	self assert: c equals: 39.

	c := br scaleValue: 10 color: 35 from: 9 to: 1.
	self assert: c equals: SColorList black.
	c := br scaleValue: 0 color: 35 from: 9 to: 1.
	self assert: c equals: SColorList white.
	c := br scaleValue: 5 color: 35 from: 9 to: 1.
	self assert: c equals: 34.
	c := br scaleValue: 1 color: 35 from: 9 to: 1.
	self assert: c equals: 39.
	c := br scaleValue: 9 color: 35 from: 9 to: 1.
	self assert: c equals: 30.
]

{ #category : #'as yet unclassified' }
SColorListTest >> testScaleValueColorFromTo_amp [

	"SmallAmp has derived this test from `SColorListTest>>#testScaleValueColorFromTo` by regenerating its assertions.
	This test can cover these parts:
	*	In `SColorList class>> #white` from 8 to 10:
		Operation: RemoveCaretOperator
		Code snippet: `^ 9`
		Dynamic state: nil
		Mutant id: RemoveCaretOperator#SColorList class#white#8#10
	*	In `SColorList class>> #black` from 8 to 10:
		Operation: RemoveCaretOperator
		Code snippet: `^ 0`
		Dynamic state: nil
		Mutant id: RemoveCaretOperator#SColorList class#black#8#10
"

	<madeBySmallAmp>
	| br c |
	br := SColorList.
	c := br
		     scaleValue: 0
		     color: 35
		     from: 1
		     to: 9.
	self assert: c equals: 0.
	c := br
		     scaleValue: 10
		     color: 35
		     from: 1
		     to: 9.
	self assert: c equals: 9.
	c := br
		     scaleValue: 5
		     color: 35
		     from: 1
		     to: 9;
		     scaleValue: 1
		     color: 35
		     from: 1
		     to: 9;
		     scaleValue: 9
		     color: 35
		     from: 1
		     to: 9;
		     scaleValue: 10
		     color: 35
		     from: 9
		     to: 1;
		     scaleValue: 0
		     color: 35
		     from: 9
		     to: 1;
		     scaleValue: 5
		     color: 35
		     from: 9
		     to: 1;
		     scaleValue: 1
		     color: 35
		     from: 9
		     to: 1;
		     scaleValue: 9
		     color: 35
		     from: 9
		     to: 1
]
