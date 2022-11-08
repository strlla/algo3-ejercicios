!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'test' stamp: 'EP 11/7/2022 22:02:57'!
test01AccountsBalanceUpdatesWhenATransferOccurs
	| transfer depositAccount  withdrawalAccount |
	
	depositAccount := ReceptiveAccount new.
	withdrawalAccount := ReceptiveAccount new.
	
	transfer := Transfer forValue: 100 * peso from: withdrawalAccount to: depositAccount.
	
	
	
	self assert: -100 * peso equals: (withdrawalAccount balance).
	self assert: 100 * peso equals: (depositAccount balance).

	
	! !

!TransferTest methodsFor: 'test' stamp: 'EP 11/8/2022 00:18:21'!
test02ATransferLegCanAccessItsOppositeLeg

	| depositAccount  withdrawalAccount |
	
	depositAccount := ReceptiveAccount new.
	withdrawalAccount := ReceptiveAccount new.
	
	Transfer forValue: 100 * peso from: withdrawalAccount to: depositAccount.
	self assert: (withdrawalAccount transactions at: 1) oppositeLeg equals: (depositAccount transactions at: 1).

	! !

!TransferTest methodsFor: 'test' stamp: 'EP 11/8/2022 00:21:42'!
test03CannotTransfer0Pesos
	| depositAccount  withdrawalAccount |
	
	depositAccount := ReceptiveAccount new.
	withdrawalAccount := ReceptiveAccount new.

	self should: [Transfer forValue: 0 * peso from: withdrawalAccount to: depositAccount.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: 'Cannot transfer an empty amount.']! !

!TransferTest methodsFor: 'test' stamp: 'EP 11/8/2022 00:24:00'!
test04CannotTransferNegativePesos
	| depositAccount  withdrawalAccount |
	
	depositAccount := ReceptiveAccount new.
	withdrawalAccount := ReceptiveAccount new.

	self should: [Transfer forValue: -100 * peso from: withdrawalAccount to: depositAccount.]
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals: 'Cannot transfer a negative amount.']! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'EP 11/7/2022 21:37:18'!
valueForBalance
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'EP 11/7/2022 21:37:33'!
valueForBalance
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'EP 11/7/2022 21:39:27'!
valueForBalance
	^value * -1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'EP 11/7/2022 21:34:55'!
balance

	^transactions sum: [ :aTransaction | aTransaction valueForBalance  ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'EP 11/8/2022 00:28:16'!
initializeFor: aValue from: aWithdrawalAccount to: aDepositAccount
	| depositLeg withdrawLeg |
	 	
	depositLeg := TransferLeg withTransaction: (Deposit for: aValue)		.
	withdrawLeg := TransferLeg withTransaction: (Withdraw for: aValue).
	
	withdrawLeg setOppositeLeg: depositLeg.
	depositLeg setOppositeLeg: withdrawLeg.	
	
	aWithdrawalAccount register: withdrawLeg.
	aDepositAccount register: depositLeg.
	
		
	! !


!Transfer methodsFor: 'value' stamp: 'EP 11/7/2022 21:30:05'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'EP 11/8/2022 00:25:12'!
forValue: aValue from: aWithdrawalAccount to: aDepositAccount
	
	aValue = 0 ifTrue: [self error:  'Cannot transfer an empty amount.'].
	aValue < 0 ifTrue: [self error:  'Cannot transfer a negative amount.'].
	
	^self new initializeFor: aValue  from: aWithdrawalAccount to: aDepositAccount.! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferLeg
	instanceVariableNames: 'transaction oppositeLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferLeg methodsFor: 'initialization' stamp: 'EP 11/8/2022 00:08:09'!
initializeWithTransaction: aTransaction
	transaction := aTransaction.! !


!TransferLeg methodsFor: 'getters' stamp: 'EP 11/8/2022 00:02:46'!
oppositeLeg
	^oppositeLeg! !


!TransferLeg methodsFor: 'value' stamp: 'EP 11/8/2022 00:11:13'!
valueForBalance
	^transaction valueForBalance. ! !


!TransferLeg methodsFor: 'setters' stamp: 'EP 11/8/2022 00:02:57'!
setOppositeLeg: aTransferLeg
	oppositeLeg := aTransferLeg.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'EP 11/8/2022 00:08:09'!
withTransaction: aTransaction
	^self new initializeWithTransaction: aTransaction.! !
