!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:50'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:56:59'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:26'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:27'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:07'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stack sentenceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EP 10/14/2022 00:32:17'!
test01SFFindsAllTheSentencesWithPrefix

	self pushSomePhrases.
	
	self assert: ((sentenceFinder find: 'win') size = 2).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EP 10/14/2022 00:32:37'!
test02AfterFindingTheSentencesTheStackStaysTheSame
 
	self pushSomePhrases.
       sentenceFinder find: 'win'.
	
	self assert: stack pop equals: 'winning is everything'.
	self assert: stack pop equals: 'winter is coming'.
	self assert: stack pop equals: 'The winds of Winter'.
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EP 10/13/2022 23:47:04'!
test03ThePrefixisEmptySoItIsNotValid

	self should: [sentenceFinder find: '' ]
	      raise: Error
	      withExceptionDo: [ :anError | self assert: SentenceFinderByPrefix prefixIsNotValidDescription equals: anError messageText.].
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EP 10/13/2022 23:58:29'!
test04ThePrefixHasSpacesSoItIsNotValid

	self pushSomePhrases.
	self should: [sentenceFinder find: 'winter is' ]
	      raise: Error
	      withExceptionDo: [ :anError | self assert: SentenceFinderByPrefix prefixIsNotValidDescription equals: anError messageText.].
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EP 10/13/2022 23:58:33'!
test05NoSentencesMatchWithThePrefix

	self pushSomePhrases.
	
	self assert: (sentenceFinder find: 'wat') size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EP 10/13/2022 23:54:30'!
test06FinderIsCaseSensitive

	self pushSomePhrases.
	
	self assert: (sentenceFinder find: 'The') size equals: 1.
	self assert: (sentenceFinder find: 'the') size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EP 10/14/2022 00:04:20'!
test07FinderChangesAfterPushing

	self pushSomePhrases.
	
	self assert: ((sentenceFinder find: 'win') size = 2).
	
	self pushSomePhrases.
	
	self assert: ((sentenceFinder find: 'win') size = 4).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EP 10/14/2022 00:22:19'!
test08FinderChangesAfterPopping

	self pushSomePhrases.
	
	self assert: ((sentenceFinder find: 'win') size = 2).
	
	3 timesRepeat: [stack pop].
	
	self assert: ((sentenceFinder find: 'win') size = 0).
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'EP 10/14/2022 00:20:37'!
test09FinderOnlySearchsForPrefixesAndNotStrings

	self pushSomePhrases.
	
	self assert: ((sentenceFinder find: 'ter') size = 0).! !


!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'EP 10/13/2022 21:49:48'!
assertErrorDescriptionEqualsPrefixIsNotValid: anError
	^self assert: SentenceFinderByPrefix prefixIsNotValidDescription equals: anError messageText.! !

!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'EP 10/13/2022 23:26:46'!
pushSomePhrases
	stack push: 'The winds of Winter'.
	stack push: 'winter is coming'.
	stack push: 'winning is everything'.! !

!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'EP 10/13/2022 21:03:00'!
setUp
	stack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix ofAStack: stack.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'private' stamp: 'EP 10/10/2022 14:36:18'!
errorEmptyStack
	self error: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'private' stamp: 'EP 10/13/2022 18:17:12'!
initialize
	quantity := 0.
	topElement := NullTop new.
	
	! !


!OOStack methodsFor: 'primitives' stamp: 'EP 10/11/2022 21:24:45'!
isEmpty
	^(quantity <= 0).! !

!OOStack methodsFor: 'primitives' stamp: 'EP 10/13/2022 18:17:12'!
pop
	| poppedValue |
	
	poppedValue := topElement value.
	
	topElement :=  topElement previousTop. 

	quantity := quantity - 1.

	^poppedValue.! !

!OOStack methodsFor: 'primitives' stamp: 'EP 10/13/2022 18:17:12'!
push: anElement
	| newTop |
	
	newTop := StackTop withValue: anElement andPrevious: topElement.
	
	topElement := newTop.
	
	quantity := quantity + 1.! !

!OOStack methodsFor: 'primitives' stamp: 'EP 10/11/2022 21:22:00'!
size
	^quantity.! !

!OOStack methodsFor: 'primitives' stamp: 'EP 10/13/2022 18:17:12'!
top	
	^topElement value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'setters' stamp: 'EP 10/13/2022 18:22:05'!
stack: aStack
	stack := aStack.! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'EP 10/14/2022 00:25:13'!
find: aPrefix
	(self prefixIsNotValid: aPrefix) ifTrue: [^self error: self class prefixIsNotValidDescription]. 
	
	^self findAllSentencesFromStackWithPrefix: aPrefix.! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'EP 10/14/2022 00:37:27'!
findAllSentencesFromStackWithPrefix: aPrefix
	| sentencesFound auxStack |  
		
	sentencesFound := OrderedCollection new.
	auxStack := OOStack new.
	
	self moveAllElementsFrom: stack into: auxStack 
	      andForEachApply: [:poppedElement | (poppedElement beginsWith: aPrefix) ifTrue: [sentencesFound add: poppedElement]].
	
	self moveAllElementsFrom: auxStack into: stack andForEachApply: [:nothing | ].
	
	^sentencesFound.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'EP 10/13/2022 21:01:04'!
moveAllElementsFrom: aStack into: anotherStack andForEachApply: aBlock
     | poppedElement |

     [aStack isEmpty] whileFalse: [
    		poppedElement := aStack pop.
		aBlock value: poppedElement.
		anotherStack push: poppedElement.
      ].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'EP 10/13/2022 21:56:46'!
prefixHasSpaces: aPrefix 
	^((aPrefix findBetweenSubStrs: {' '}) size ~= 1).! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'EP 10/13/2022 21:57:53'!
prefixIsNotValid: aPrefix
	^(aPrefix isEmpty) or: [self prefixHasSpaces: aPrefix]. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instatiation' stamp: 'EP 10/13/2022 18:22:34'!
ofAStack: aStack
	| newFinder |
	
	newFinder := SentenceFinderByPrefix  new.
	newFinder stack: aStack.
	
	^newFinder! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'EP 10/13/2022 21:26:55'!
prefixIsNotValidDescription
	^'This Prefix is not valid'.! !


!classDefinition: #StackTop category: 'Stack-Exercise'!
Object subclass: #StackTop
	instanceVariableNames: 'value previousTop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackTop methodsFor: 'setters' stamp: 'EP 10/13/2022 18:13:25'!
previousTop: aTop
	self subclassResponsibility.! !

!StackTop methodsFor: 'setters' stamp: 'EP 10/11/2022 21:49:18'!
value: aValue
	self subclassResponsibility.! !


!StackTop methodsFor: 'getters' stamp: 'EP 10/13/2022 18:11:39'!
previousTop
	self subclassResponsibility.! !

!StackTop methodsFor: 'getters' stamp: 'EP 10/11/2022 21:49:15'!
value
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackTop class' category: 'Stack-Exercise'!
StackTop class
	instanceVariableNames: ''!

!StackTop class methodsFor: 'instatiaton' stamp: 'EP 10/13/2022 18:15:26'!
withValue: aValue andPrevious: aTop
	| newNode |
	newNode := RealTop new.
	newNode value: aValue.
	newNode previousTop: aTop.
	
	^newNode.
	
	! !


!classDefinition: #NullTop category: 'Stack-Exercise'!
StackTop subclass: #NullTop
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullTop methodsFor: 'getters' stamp: 'EP 10/13/2022 18:14:34'!
previousTop
	^self.! !

!NullTop methodsFor: 'getters' stamp: 'EP 10/11/2022 21:41:44'!
value
	^OOStack error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #RealTop category: 'Stack-Exercise'!
StackTop subclass: #RealTop
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RealTop methodsFor: 'getters' stamp: 'EP 10/13/2022 18:13:09'!
previousTop
	^previousTop.! !

!RealTop methodsFor: 'getters' stamp: 'EP 10/11/2022 21:48:35'!
value
	^value.! !


!RealTop methodsFor: 'setters' stamp: 'EP 10/13/2022 18:14:57'!
previousTop: aTop
	previousTop := aTop.! !

!RealTop methodsFor: 'setters' stamp: 'EP 10/11/2022 21:48:42'!
value: aValue
	value := aValue.! !
