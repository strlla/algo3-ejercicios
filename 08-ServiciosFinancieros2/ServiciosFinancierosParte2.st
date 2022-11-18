!classDefinition: #AccountSummaryTest category: 'ServiciosFinancierosParte2'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!AccountSummaryTest methodsFor: 'test' stamp: 'MN 11/18/2022 02:35:46'!
test01AccountWithNoTransactionsKnowsItsSummary

	account := ReceptiveAccount new.
	summary := AccountSummaryReport for: account. 
	
    self assert: summary reportText equals:
 ('Balance = ', account balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'MN 11/18/2022 02:35:42'!
test02AccountWithADepositKnowsItsSummary
    | aDeposit|

	account := ReceptiveAccount new.
	aDeposit := Deposit register: 100 * peso on: account.
	summary := AccountSummaryReport for: account. 

    self assert: summary reportText equals: 
('Depósito por ', aDeposit value asString, '
Balance = ', account balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'MN 11/18/2022 02:35:38'!
test03AccountWithAWithdrawKnowsItsSummary
    |aWithdraw|

	account := ReceptiveAccount new.
	aWithdraw := Withdraw register: 50 * peso on: account.
	summary := AccountSummaryReport for: account. 

    self assert: summary reportText equals:
 ('Extracción por ', aWithdraw value asString,'
Balance = ', account balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'MN 11/18/2022 02:34:38'!
test04AccountWithAWithdrawFromTransferKnowsItsSummary
    | senderAccount receiverAccount transfer aDeposit |
 
	senderAccount := ReceptiveAccount new.	
	receiverAccount := ReceptiveAccount new.
	
	aDeposit := Deposit register: 100 * peso on: senderAccount.
	
	transfer := Transfer amount: 20 * peso from: senderAccount to: receiverAccount.

	summary := AccountSummaryReport for: senderAccount. 

    self assert: summary reportText equals: 
('Depósito por ', aDeposit value asString, '
Salida por transferencia de ', transfer value asString,'
Balance = ', senderAccount balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'MN 11/18/2022 02:35:22'!
test05AccountWIthADepositFromTransferKnowsItsSummary
    | senderAccount receiverAccount transfer |
 
	senderAccount := ReceptiveAccount new.	
	receiverAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: senderAccount.
	
	transfer := Transfer amount: 20 * peso from: senderAccount to: receiverAccount.

	summary := AccountSummaryReport for: receiverAccount . 

    self assert: summary reportText equals: 
('Entrada por transferencia de ', transfer value asString,'
Balance = ', receiverAccount balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'MN 11/18/2022 02:34:38'!
test06AccountWIthSeveralTransactionsKnowsItsSummary
    | anAccount anotherAccount transfer anotherTransfer aDeposit aWithdraw |
 
	anAccount := ReceptiveAccount new.	
	anotherAccount := ReceptiveAccount new.
	
	aDeposit := Deposit register: 100 * peso on: anAccount.

	aWithdraw := Withdraw register: 10 * peso on: anAccount.

	transfer := Transfer amount: 20 * peso from: anAccount to: anotherAccount.
		
	anotherTransfer := Transfer amount: 20 * peso from: anotherAccount to: anAccount.

	summary := AccountSummaryReport for: anAccount.


    self assert: summary reportText equals: 
    ('Depósito por ', aDeposit value asString, '
Extracción por ', aWithdraw value asString, '
Salida por transferencia de ', transfer value asString, '
Entrada por transferencia de ', anotherTransfer value asString,'
Balance = ', anAccount balance asString).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'MN 11/18/2022 02:34:38'!
test07PortfolioWithSeveralTransactionsKnowsItsSummary
    | anAccount anotherAccount transfer anotherTransfer aDeposit aWithdraw portfolio|
 
	anAccount := ReceptiveAccount new.	
	anotherAccount := ReceptiveAccount new.
	
	aDeposit := Deposit register: 100 * peso on: anAccount.

	aWithdraw := Withdraw register: 10 * peso on: anAccount.

	transfer := Transfer amount: 20 * peso from: anAccount to: anotherAccount.
		
	anotherTransfer := Transfer amount: 20 * peso from: anotherAccount to: anAccount.
	
	portfolio := Portfolio with: anAccount with: anotherAccount. 

	summary := AccountSummaryReport for: portfolio.


    self assert: summary reportText equals: 
    ('Depósito por ', aDeposit value asString, '
Extracción por ', aWithdraw value asString, '
Salida por transferencia de ', transfer value asString, '
Entrada por transferencia de ', anotherTransfer value asString,'
Entrada por transferencia de ', transfer value asString , '
Salida por transferencia de ', anotherTransfer value asString ,'
Balance = ', anAccount balance asString).! !


!classDefinition: #PortfolioDetailedTreePrinterTest category: 'ServiciosFinancierosParte2'!
TestCase subclass: #PortfolioDetailedTreePrinterTest
	instanceVariableNames: 'tree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MN 11/18/2022 03:17:33'!
setUpOftreeOfPortfolioWithTransactions
	| portfolio johnsAccount |
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	Deposit register: 100 * peso on: johnsAccount.
	portfolio := Portfolio named: 'Portfolio con hijo' with: johnsAccount.
	tree := PortfolioDetailedTreePrinter for: portfolio. 
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MN 11/18/2022 03:18:37'!
setUpPortfolioWithManyAccounts
	| portfolio johnsAccount angiesAccount |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	
	portfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 	
	Deposit register: 100 * peso on: johnsAccount.
	Deposit register: 100 * peso on: angiesAccount.

	tree := PortfolioDetailedTreePrinter for: portfolio. 
! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MN 11/18/2022 03:00:53'!
setUpTreeOfFamilyPortfolio

| familyPortfolio childrenPortfolio  johnsAccount angiesAccount myAccount aDeposit anotherDeposit |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	aDeposit := Deposit register: 100 * peso on: johnsAccount.
	anotherDeposit := Deposit register: 100 * peso on: angiesAccount.

	tree := PortfolioDetailedTreePrinter for: familyPortfolio. ! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MN 11/18/2022 03:20:04'!
test01PortfolioWithoutAccountsPrintsItself
	| portfolio |
	
	portfolio := Portfolio named: 'Portfolio aislado'.
	tree := PortfolioDetailedTreePrinter for: portfolio. 
	
	self assert: tree reportText equals: 
	'Portfolio aislado
	Balance = ', (portfolio balance) asString. 
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MN 11/18/2022 03:17:52'!
test02PortfolioWithTransactionsPrintsCorrectly
	self setUpOftreeOfPortfolioWithTransactions.

	self assert: tree reportText equals: 
'Portfolio con hijo
	Cuenta de Juan
		Depósito por 100 * pesos
		Balance = 100 * pesos
	Balance = 100 * pesos'. 
	
	! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MN 11/18/2022 03:19:53'!
test03PortfolioWithManyAccountsPrintsCorrectly
	self setUpPortfolioWithManyAccounts. 

	self assert: tree reportText equals: 
	'Portfolio de hijos
	Cuenta de Juan
		Depósito por 100 * pesos
		Balance = 100 * pesos
	Cuenta de Angeles
		Depósito por 100 * pesos
		Balance = 100 * pesos
	Balance = 200 * pesos'! !

!PortfolioDetailedTreePrinterTest methodsFor: 'tests' stamp: 'MN 11/18/2022 03:07:53'!
test04PortfolioWithManyPortfoliosPrintsCorrectly
	self setUpTreeOfFamilyPortfolio.

	self assert: tree reportText equals: 
'Portfolio de la familia
	Cuenta mia
		Balance = 0 * pesos
	Portfolio de hijos
		Cuenta de Juan
			Depósito por 100 * pesos
			Balance = 100 * pesos
		Cuenta de Angeles
			Depósito por 100 * pesos
			Balance = 100 * pesos
		Balance = 200 * pesos
	Balance = 200 * pesos'. 
	
	
	! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancierosParte2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #PortfolioTreePrinterTest category: 'ServiciosFinancierosParte2'!
TestCase subclass: #PortfolioTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 17:37:50'!
test01PortfolioWithNoMembersIsAloneInTree
	| portfolio tree |
	
	portfolio := Portfolio named: 'Portfolio aislado'.
	tree := PortfolioTreePrinter for: portfolio. 
	
	
	self assert: tree reportText equals: 'Portfolio aislado'. ! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 17:57:31'!
test02PortfolioWithAnAccountPrintsCorrectly
	| portfolio tree account |
	
	account := ReceptiveAccount named: 'Cuenta de Alan'. 
	portfolio := Portfolio named: 'Portfolio con hijos' with: account. 
	tree := PortfolioTreePrinter for: portfolio. 

	self assert: tree reportText equals: 'Portfolio con hijos
	Cuenta de Alan'. ! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 20:08:39'!
test03FamilyPortfolioPrintsCorrectly
	| tree johnsAccount angiesAccount  childrenPortfolio myAccount familyPortfolio |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
		
	tree := PortfolioTreePrinter for: familyPortfolio. 
	
	self assert: tree reportText equals: 'Portfolio de la familia
	Cuenta mia
	Portfolio de hijos
		Cuenta de Juan
		Cuenta de Angeles'. ! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 20:09:40'!
test04FamilyPortfolioWithManyGenerationsPrintsCorrectly
	| tree johnsAccount angiesAccount  childrenPortfolio myAccount familyPortfolio anotherPortfolio |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	anotherPortfolio := Portfolio named: 'Otro portfolio' with: familyPortfolio.
	
	tree := PortfolioTreePrinter for: anotherPortfolio. 
	
	self assert: tree reportText equals: 'Otro portfolio
	Portfolio de la familia
		Cuenta mia
		Portfolio de hijos
			Cuenta de Juan
			Cuenta de Angeles'. ! !

!PortfolioTreePrinterTest methodsFor: 'tests' stamp: 'EP 11/17/2022 20:20:10'!
test05FamilyPortfolioPrintsCorrectly
	| tree johnsAccount angiesAccount  childrenPortfolio myAccount familyPortfolio secondChildrenPortfolio |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	secondChildrenPortfolio := Portfolio named: 'Segundo portfolio de hijos' with: angiesAccount . 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	familyPortfolio add: secondChildrenPortfolio.
	tree := PortfolioTreePrinter for: familyPortfolio. 
	
	self assert: tree reportText equals: 'Portfolio de la familia
	Cuenta mia
	Portfolio de hijos
		Cuenta de Juan
	Segundo portfolio de hijos
		Cuenta de Angeles'. ! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancierosParte2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

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


!classDefinition: #TransferNetTest category: 'ServiciosFinancierosParte2'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!TransferNetTest methodsFor: 'tests' stamp: 'MN 11/18/2022 02:28:45'!
setUpAccountWithDifferentTransactions
	| senderAccount receiverAccount |
 
    senderAccount := ReceptiveAccount new.	
    receiverAccount := ReceptiveAccount new.
	
    Deposit register: 100 * peso on: senderAccount.

    Transfer amount: 20 * peso from: senderAccount to: receiverAccount.

    transferNet := TransferNetReport for: senderAccount. ! !

!TransferNetTest methodsFor: 'tests' stamp: 'MN 11/18/2022 02:30:16'!
setUpAccountWithTransfers
	| senderAccount receiverAccount |
 
    senderAccount := ReceptiveAccount new.	
    receiverAccount := ReceptiveAccount new.
	
    Deposit register: 100 * peso on: senderAccount.

    Transfer amount: 20 * peso from: senderAccount to: receiverAccount.

    transferNet := TransferNetReport for: receiverAccount. ! !

!TransferNetTest methodsFor: 'tests' stamp: 'MN 11/18/2022 02:55:16'!
setUpTransferNetOfAccountWithSeveralTransfers
	| anotherAccount |
 
    account := ReceptiveAccount new.	
    anotherAccount := ReceptiveAccount new.
	
    Deposit register: 100 * peso on: account.
    Deposit register: 100 * peso on: anotherAccount.

    Transfer amount: 20 * peso from: account to: anotherAccount.
    Transfer amount: 30 * peso from: anotherAccount to: account.

    transferNet := TransferNetReport for: account. ! !

!TransferNetTest methodsFor: 'tests' stamp: 'MN 11/18/2022 02:10:43'!
test01TheNetIsZeroWhenTheAccountHasNoTransfers
 
    account := ReceptiveAccount new.
    transferNet := TransferNetReport for: account.
 
    self assert: transferNet result equals: 0 * peso.! !

!TransferNetTest methodsFor: 'tests' stamp: 'MN 11/18/2022 02:31:28'!
test02TransfersAffectTheTransferNet
    self setUpAccountWithTransfers.

    self assert: transferNet result equals: 20 * peso.

! !

!TransferNetTest methodsFor: 'tests' stamp: 'MN 11/18/2022 02:28:34'!
test03OnlyTransfersAffectTheTransferNet
    self setUpAccountWithDifferentTransactions.

    self assert: transferNet result equals: -20 * peso.

! !

!TransferNetTest methodsFor: 'tests' stamp: 'MN 11/18/2022 02:14:16'!
test04SeveralTransfersAffectTheTransferNet
    self setUpTransferNetOfAccountWithSeveralTransfers.

    self assert: transferNet result equals: 10 * peso.

! !


!classDefinition: #TransferTest category: 'ServiciosFinancierosParte2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancierosParte2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancierosParte2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'EP 11/17/2022 18:22:10'!
initializeWithName: aName
	parents := OrderedCollection new.	
	name := aName.
! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'EP 11/17/2022 17:44:05'!
name
	^name.! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'EP 11/17/2022 18:08:04'!
accounts
	^accounts copy.! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancierosParte2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 17:40:32'!
named: aString 
	^self new initializeWithName: aString ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 18:21:11'!
named: aName with: anAccount
         ^self new
	  add: anAccount;
	  initializeWithName: aName;
	  yourself.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 17:55:03'!
named: aName with: anAccount  with: anotherAccount
	^self new 
		add: anAccount;
		add: anotherAccount;
		initializeWithName: aName;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancierosParte2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'EP 11/17/2022 17:32:31'!
initializeName: aName
	super initialize.
	name := aName.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MN 11/18/2022 03:06:31'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'EP 11/17/2022 18:24:03'!
name
	^name.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancierosParte2'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 17:56:38'!
named: aName
	^self new initializeName: aName. ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancierosParte2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'dd' stamp: 'EP 11/15/2022 22:11:53'!
beAddedToAReport: aReport
	self subclassResponsibility. ! !


!classDefinition: #Deposit category: 'ServiciosFinancierosParte2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'dd' stamp: 'EP 11/17/2022 21:22:38'!
beAddedToAReport: aReport
	^ aReport addADeposit: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancierosParte2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancierosParte2'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'dd' stamp: 'EP 11/15/2022 22:12:03'!
beAddedToAReport: aReport
	self subclassResponsibility. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancierosParte2'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancierosParte2'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'value' stamp: 'EP 11/17/2022 21:23:14'!
beAddedToAReport: aReport
	^aReport addATransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancierosParte2'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !

!TransferWithdrawLeg methodsFor: 'balance' stamp: 'EP 11/17/2022 21:23:19'!
beAddedToAReport: aReport
	^aReport addATransferWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancierosParte2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'dd' stamp: 'EP 11/17/2022 21:23:25'!
beAddedToAReport: aReport
	^aReport addAWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancierosParte2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancierosParte2'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!Report methodsFor: 'initialization' stamp: 'EP 11/14/2022 21:43:25'!
initializeWith: anAccount
	self subclassResponsibility.! !


!Report methodsFor: 'public' stamp: 'EP 11/14/2022 21:47:49'!
reportText
	^self subclassResponsibility.! !

!Report methodsFor: 'public' stamp: 'MN 11/18/2022 02:37:53'!
result
	^self subclassResponsibility.! !


!classDefinition: #AccountSummaryReport category: 'ServiciosFinancierosParte2'!
Report subclass: #AccountSummaryReport
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!AccountSummaryReport methodsFor: 'initialization' stamp: 'EP 11/14/2022 21:09:01'!
initializeWith: anAccount
	account := anAccount.
	summary := ''.
	 
	self createSummary.! !


!AccountSummaryReport methodsFor: 'private' stamp: 'EP 11/14/2022 21:36:17'!
addATransaction: aTransaction
	aTransaction beAddedToAReport: self.! !

!AccountSummaryReport methodsFor: 'private' stamp: 'EP 11/14/2022 21:06:55'!
createSummary
	account transactions do: [:aTransaction |		 self addATransaction: aTransaction.		].
	
	summary := summary, 'Balance = ', account balance asString. 	
! !


!AccountSummaryReport methodsFor: 'public' stamp: 'EP 11/14/2022 21:47:49'!
reportText
	^summary.! !


!AccountSummaryReport methodsFor: 'dd' stamp: 'EP 11/17/2022 21:19:43'!
addADeposit: aDeposit
	summary := summary, 'Depósito por ', aDeposit value asString, Character newLineCharacter asString.! !

!AccountSummaryReport methodsFor: 'dd' stamp: 'MN 11/17/2022 11:40:07'!
addATransferDepositLeg: aTransferLeg
	summary := summary, 'Entrada por transferencia de ', aTransferLeg value asString, Character newLineCharacter asString.! !

!AccountSummaryReport methodsFor: 'dd' stamp: 'MN 11/17/2022 11:40:13'!
addATransferWithdrawLeg: aTransferLeg
	summary := summary, 'Salida por transferencia de ', aTransferLeg value asString, Character newLineCharacter asString.! !

!AccountSummaryReport methodsFor: 'dd' stamp: 'EP 11/17/2022 21:19:53'!
addAWithdraw: aWithdraw
	summary := summary, 'Extracción por ', aWithdraw value asString, Character newLineCharacter asString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: 'ServiciosFinancierosParte2'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'instance creation' stamp: 'EP 11/14/2022 21:12:26'!
for: anAccount
	^self new initializeWith: anAccount. ! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancierosParte2'!
Report subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!PortfolioDetailedTreePrinter methodsFor: 'dd' stamp: 'EP 11/17/2022 21:13:32'!
addADeposit: aDeposit
	^'Depósito por ', (aDeposit value) asString, Character newLineCharacter asString.! !

!PortfolioDetailedTreePrinter methodsFor: 'dd' stamp: 'EP 11/17/2022 21:12:32'!
addATransferDepositLeg: aTransferLeg
	^'Entrada por transferencia de ', (aTransferLeg value) asString, Character newLineCharacter asString.! !

!PortfolioDetailedTreePrinter methodsFor: 'dd' stamp: 'EP 11/17/2022 21:12:39'!
addATransferWithdrawLeg: aTransferLeg
	^'Salida por transferencia de ', (aTransferLeg value) asString, Character newLineCharacter asString.! !

!PortfolioDetailedTreePrinter methodsFor: 'dd' stamp: 'EP 11/17/2022 21:12:45'!
addAWithdraw: aWithdraw
	^'Extracción por ', (aWithdraw value) asString, Character newLineCharacter asString.! !


!PortfolioDetailedTreePrinter methodsFor: 'initialization' stamp: 'EP 11/17/2022 20:23:09'!
initializeWith: aPortfolio
	portfolio := aPortfolio. ! !


!PortfolioDetailedTreePrinter methodsFor: 'main protocol' stamp: 'MN 11/18/2022 00:56:30'!
reportText
	| text |
	
	text :=self printChildrenOfPortfolio: portfolio withIndentations: 0.
	
	^text.! !


!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'MN 11/18/2022 01:12:09'!
accountSummaryOf: anAccount withIndentations: aQuantity
	| text |
	
	text := ''.
	text := text, '	', anAccount name.
	text := text, Character newLineCharacter asString, '	'.
	aQuantity timesRepeat: [text := text, '	'].
		
				
	anAccount transactions do: [:aTransaction | 
		
		text := text, (aTransaction beAddedToAReport: self) .
		aQuantity+1 timesRepeat: [text := text, '	'].
	]. 
	text := text, 'Balance = ', anAccount balance asString.
	^text.! !

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'MN 11/18/2022 01:18:09'!
printChildrenOfPortfolio: aPortfolio withIndentations: aQuantity
	| text |
	text := ''.
	aQuantity timesRepeat: [text := text, '	'.].
	text := text, aPortfolio name, Character newLineCharacter asString. 

	aPortfolio accounts do: [:anAccount | 
		aQuantity timesRepeat: [text := text, '	'.].
		(anAccount isKindOf: ReceptiveAccount) ifTrue: [text := text, (self accountSummaryOf: anAccount withIndentations: aQuantity + 1)].
	 
		(anAccount isKindOf: Portfolio) ifTrue: [text := text, (self printChildrenOfPortfolio: anAccount withIndentations: aQuantity + 1)].
		
		text := text, Character newLineCharacter asString.
		].
	aQuantity timesRepeat: [text := text, '	'.].
	text := text, '	Balance = ', (aPortfolio balance) asString.
	
	^text.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioDetailedTreePrinter class' category: 'ServiciosFinancierosParte2'!
PortfolioDetailedTreePrinter class
	instanceVariableNames: ''!

!PortfolioDetailedTreePrinter class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 20:22:34'!
for: aPortfolio 
	^self new initializeWith: aPortfolio.! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancierosParte2'!
Report subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio treeText'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!PortfolioTreePrinter methodsFor: 'private' stamp: 'MN 11/18/2022 02:50:21'!
addChildrenOfPortfolio: aPortfolio WithIndentations: aQuantity

	aPortfolio accounts do: [:anAccount | 
		self addToTheReportTheAccount: anAccount withTheIndentation: aQuantity.
		
		(anAccount isKindOf: Portfolio) ifTrue: [self addChildrenOfPortfolio: anAccount WithIndentations: aQuantity + 1].

	].
	! !

!PortfolioTreePrinter methodsFor: 'private' stamp: 'MN 11/18/2022 02:43:59'!
addToTheReportTheAccount: anAccount withTheIndentation: aQuantity

	treeText := treeText, Character newLineCharacter asString.
	aQuantity timesRepeat: [treeText := treeText, '	'].
	treeText := treeText, anAccount name.
! !


!PortfolioTreePrinter methodsFor: 'public' stamp: 'MN 11/18/2022 02:50:21'!
reportText
	treeText := portfolio name.

	self addChildrenOfPortfolio: portfolio WithIndentations: 1.
	
	^treeText.! !


!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'MN 11/18/2022 02:41:26'!
initializeWith: aPortfolio
	portfolio := aPortfolio. 
	treeText := ''.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancierosParte2'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'EP 11/17/2022 17:41:48'!
for: aPortfolio 
	^self new initializeWith: aPortfolio ! !


!classDefinition: #TransferNetReport category: 'ServiciosFinancierosParte2'!
Report subclass: #TransferNetReport
	instanceVariableNames: 'netBalance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!TransferNetReport methodsFor: 'as yet unclassified' stamp: 'EP 11/15/2022 21:58:20'!
initializeWith: anAccount
	account := anAccount.
	netBalance := 0 * peso.! !


!TransferNetReport methodsFor: 'dd' stamp: 'EP 11/15/2022 22:07:02'!
addADeposit: aDeposit
	^netBalance.! !

!TransferNetReport methodsFor: 'dd' stamp: 'EP 11/15/2022 22:09:45'!
addATransferDepositLeg: aTransferDepositLeg
	netBalance := aTransferDepositLeg affectBalance: netBalance.! !

!TransferNetReport methodsFor: 'dd' stamp: 'EP 11/15/2022 22:09:49'!
addATransferWithdrawLeg: aTransferWithdrawLeg
	netBalance := aTransferWithdrawLeg affectBalance: netBalance.! !

!TransferNetReport methodsFor: 'dd' stamp: 'EP 11/15/2022 22:07:07'!
addAWithdraw: aWithdraw
	^netBalance.! !


!TransferNetReport methodsFor: 'public' stamp: 'EP 11/15/2022 22:10:07'!
result

	account transactions do: [:aTransaction | aTransaction  beAddedToAReport: self ].
	
	^netBalance. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetReport class' category: 'ServiciosFinancierosParte2'!
TransferNetReport class
	instanceVariableNames: ''!

!TransferNetReport class methodsFor: 'instance creation' stamp: 'EP 11/15/2022 21:14:40'!
for: anAccount
	^self new initializeWith: anAccount. ! !


!classDefinition: #Transfer category: 'ServiciosFinancierosParte2'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancierosParte2'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancierosParte2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
