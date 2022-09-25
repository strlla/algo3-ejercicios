!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customer_Book'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 19:57:16'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self should: [customer_Book addCustomerNamed: 'John Lennon'] notTakeMoreThan: 50 milliSeconds .! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 19:57:56'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	customer_Book addCustomerNamed: 'Paul McCartney'.
	
	self should: [customer_Book removeCustomerNamed: 'Paul McCartney'.] notTakeMoreThan: 100 milliSeconds.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 19:56:05'!
test03CanNotAddACustomerWithEmptyName 

	self should:[ customer_Book addCustomerNamed: ''.]raise: Error withExceptionDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customer_Book isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:00:13'!
test04CanNotRemoveAnInvalidCustomer
	
	| johnLennon |
	
	johnLennon := 'John Lennon'.
	customer_Book := customer_Book addCustomerNamed:johnLennon .

	[ customer_Book removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customer_Book numberOfCustomers = 1.
			self assert: (customer_Book includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:01:02'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	|paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	customer_Book addCustomerNamed: paulMcCartney.
	customer_Book suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customer_Book numberOfActiveCustomers.
	self assert: 1 equals: customer_Book numberOfSuspendedCustomers.
	self assert: 1 equals: customer_Book numberOfCustomers.
	self assert: (customer_Book includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:03:20'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customer_Book addCustomerNamed: paulMcCartney.
	
	customer_Book suspendCustomerNamed: paulMcCartney.
	customer_Book removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customer_Book numberOfActiveCustomers.
	self assert: 0 equals: customer_Book numberOfSuspendedCustomers.
	self assert: 0 equals: customer_Book numberOfCustomers.
	self deny: (customer_Book includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:02:14'!
test07CanNotSuspendAnInvalidCustomer
	
	|johnLennon |
	johnLennon := 'John Lennon'.	
	customer_Book addCustomerNamed: johnLennon.
	
	[ customer_Book suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customer_Book numberOfCustomers = 1.
			self assert: (customer_Book includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 9/25/2022 20:03:06'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| johnLennon |
			
	johnLennon := 'John Lennon'.
	customer_Book addCustomerNamed: johnLennon.
	 
	customer_Book suspendCustomerNamed: johnLennon.
	
	[ customer_Book suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customer_Book numberOfCustomers = 1.
			self assert: (customer_Book includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'setupDeTests' stamp: 'MN 9/25/2022 19:53:25'!
setUp
	customer_Book := CustomerBook new.! !

!CustomerBookTest methodsFor: 'setupDeTests' stamp: 'MN 9/25/2022 19:59:29'!
setUpBorrarClienteSuspendido! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MN 9/25/2022 17:35:53'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ] ifFalse: [active add: aName ].
	
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MN 9/25/2022 17:28:27'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers. ! !

!CustomerBook methodsFor: 'customer management' stamp: 'MN 9/25/2022 17:29:21'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MN 9/25/2022 17:35:49'!
removeCustomerNamed: aName 

 	active remove: aName  ifAbsent: [ suspended remove: aName ifAbsent: [ ^NotFound signal ]. ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !

