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

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'EP 10/13/2022 18:06:26'!
find: aPrefix
	
	! !


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
