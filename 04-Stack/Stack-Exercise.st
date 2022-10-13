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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topNode quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'private' stamp: 'EP 10/10/2022 14:36:18'!
errorEmptyStack
	self error: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'private' stamp: 'EP 10/11/2022 21:49:39'!
initialize
	quantity := 0.
	topNode := NullNode new.
	
	! !


!OOStack methodsFor: 'primitives' stamp: 'EP 10/11/2022 21:24:45'!
isEmpty
	^(quantity <= 0).! !

!OOStack methodsFor: 'primitives' stamp: 'EP 10/11/2022 21:41:31'!
pop
	| poppedValue |
	
	poppedValue := topNode value.
	
	topNode :=  topNode previousNode. 

	quantity := quantity - 1.

	^poppedValue.! !

!OOStack methodsFor: 'primitives' stamp: 'EP 10/11/2022 21:50:24'!
push: anElement
	| newTop |
	
	newTop := StackNode withValue: anElement andPrevious: topNode.
	
	topNode := newTop.
	
	quantity := quantity + 1.! !

!OOStack methodsFor: 'primitives' stamp: 'EP 10/11/2022 21:22:00'!
size
	^quantity.! !

!OOStack methodsFor: 'primitives' stamp: 'EP 10/11/2022 21:23:31'!
top	
	^topNode value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #StackNode category: 'Stack-Exercise'!
Object subclass: #StackNode
	instanceVariableNames: 'value previousNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNode methodsFor: 'as yet unclassified' stamp: 'EP 10/11/2022 21:49:01'!
previousNode
	self subclassResponsibility.! !

!StackNode methodsFor: 'as yet unclassified' stamp: 'EP 10/11/2022 21:49:08'!
previousNode: aNode
	self subclassResponsibility.! !

!StackNode methodsFor: 'as yet unclassified' stamp: 'EP 10/11/2022 21:49:15'!
value
	self subclassResponsibility.! !

!StackNode methodsFor: 'as yet unclassified' stamp: 'EP 10/11/2022 21:49:18'!
value: aValue
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackNode class' category: 'Stack-Exercise'!
StackNode class
	instanceVariableNames: ''!

!StackNode class methodsFor: 'as yet unclassified' stamp: 'EP 10/11/2022 21:47:58'!
withValue: aValue andPrevious: aNode
	| newNode |
	newNode := RealNode new.
	newNode value: aValue.
	newNode previousNode: aNode.
	
	^newNode.
	
	! !


!classDefinition: #NullNode category: 'Stack-Exercise'!
StackNode subclass: #NullNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullNode methodsFor: 'as yet unclassified' stamp: 'EP 10/11/2022 21:44:57'!
previousNode
	^self.! !

!NullNode methodsFor: 'as yet unclassified' stamp: 'EP 10/11/2022 21:41:44'!
value
	^OOStack error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #RealNode category: 'Stack-Exercise'!
StackNode subclass: #RealNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RealNode methodsFor: 'getters' stamp: 'EP 10/11/2022 21:48:18'!
previousNode
	^previousNode.! !

!RealNode methodsFor: 'getters' stamp: 'EP 10/11/2022 21:48:35'!
value
	^value.! !


!RealNode methodsFor: 'setters' stamp: 'EP 10/11/2022 21:48:24'!
previousNode: aNode
	previousNode := aNode.! !

!RealNode methodsFor: 'setters' stamp: 'EP 10/11/2022 21:48:42'!
value: aValue
	value := aValue.! !
