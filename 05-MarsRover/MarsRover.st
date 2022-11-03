!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'aMarsRoverFacingNorth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 11/3/2022 18:43:31'!
test01MarsRoverDoesNotMoveIfReceivesEmptyCommand
	aMarsRoverFacingNorth receiveInstructions: ''	.
	
	self assert: (aMarsRoverFacingNorth isAtPosition: 0@0).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 11/3/2022 18:43:46'!
test02MarsRoverMovesForwardWhenReceivesCommand
	aMarsRoverFacingNorth receiveInstructions: 'f'	.
	self assert: (aMarsRoverFacingNorth isAtPosition: 0@1).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 11/3/2022 18:44:07'!
test03MarsRoverRotatesLeftCorrectly
	aMarsRoverFacingNorth receiveInstructions: 'lf'	.
	
	self assert: (aMarsRoverFacingNorth isAtPosition: -1@0).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 11/3/2022 18:44:18'!
test04MarsRoverRotatesRightCorrectly
	aMarsRoverFacingNorth receiveInstructions: 'rf'	.
	
	self assert: (aMarsRoverFacingNorth isAtPosition: 1@0).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 11/3/2022 18:44:28'!
test05MarsRoverReturnsToItsInitialPositionAfterMovingForwardAndBackwards
	aMarsRoverFacingNorth receiveInstructions: 'ffbb'	.
	self assert: (aMarsRoverFacingNorth isAtPosition: 0@0).! !

!MarsRoverTest methodsFor: 'testing' stamp: 'EP 11/3/2022 18:44:45'!
test06MarsRoverReceivesInvalidCommandAndFails
	self should: [ aMarsRoverFacingNorth receiveInstructions: 'ffñbb'	 ]
		raise: Error 
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Instruction not valid.'].! !


!MarsRoverTest methodsFor: 'setUp' stamp: 'EP 11/3/2022 18:40:06'!
setUp
	aMarsRoverFacingNorth := MarsRover withCoordinates: 0@0 andOrientation: 'N'.! !


!classDefinition: #CardinalPoints category: 'MarsRover'!
Object subclass: #CardinalPoints
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoints methodsFor: 'public' stamp: 'MN 11/3/2022 16:59:30'!
whenRotatingLeft
	self subclassResponsibility.! !

!CardinalPoints methodsFor: 'public' stamp: 'MN 11/3/2022 16:59:53'!
whenRotatingRight
	self subclassResponsibility.! !

!CardinalPoints methodsFor: 'public' stamp: 'EP 11/2/2022 23:40:37'!
whereToMoveBackwards: marsRover
	self subclassResponsibility.! !

!CardinalPoints methodsFor: 'public' stamp: 'EP 11/2/2022 23:40:44'!
whereToMoveForward: marsRover
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoints class' category: 'MarsRover'!
CardinalPoints class
	instanceVariableNames: ''!

!CardinalPoints class methodsFor: 'identification' stamp: 'EP 10/30/2022 18:17:02'!
identifier
	self subclassResponsibility.! !


!CardinalPoints class methodsFor: 'instance creation' stamp: 'EP 10/30/2022 18:02:47'!
at: anOrientation
	self subclasses detect: [:aSubclass | aSubclass identifier = anOrientation]
	ifFound: [:aSubclass | ^aSubclass new]
        ifNone:[ self error: 'La orientación no existe'].! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoints subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'public' stamp: 'MN 11/3/2022 16:59:30'!
whenRotatingLeft
	^North new.! !

!East methodsFor: 'public' stamp: 'MN 11/3/2022 16:59:53'!
whenRotatingRight
	^South new.! !

!East methodsFor: 'public' stamp: 'EP 11/2/2022 23:37:44'!
whereToMoveBackwards: marsRover
	marsRover moveBackwardsFacingEast.	! !

!East methodsFor: 'public' stamp: 'EP 11/2/2022 23:36:07'!
whereToMoveForward: marsRover
	marsRover moveForwardFacingEast.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'identification' stamp: 'EP 10/30/2022 18:05:52'!
identifier
	^'E'.! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoints subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'public' stamp: 'MN 11/3/2022 16:59:30'!
whenRotatingLeft
	^West new.! !

!North methodsFor: 'public' stamp: 'MN 11/3/2022 16:59:53'!
whenRotatingRight
	^East new.! !

!North methodsFor: 'public' stamp: 'EP 11/2/2022 23:37:59'!
whereToMoveBackwards: marsRover
	marsRover moveBackwardsFacingNorth.	! !

!North methodsFor: 'public' stamp: 'EP 11/2/2022 23:36:35'!
whereToMoveForward: marsRover
	marsRover moveForwardFacingNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'identification' stamp: 'EP 10/30/2022 18:06:10'!
identifier
	^'N'.! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoints subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'public' stamp: 'MN 11/3/2022 16:59:30'!
whenRotatingLeft
	^East new.! !

!South methodsFor: 'public' stamp: 'MN 11/3/2022 16:59:53'!
whenRotatingRight
	^West new.! !

!South methodsFor: 'public' stamp: 'EP 11/2/2022 23:38:09'!
whereToMoveBackwards: marsRover
	marsRover moveBackwardsFacingSouth. 	! !

!South methodsFor: 'public' stamp: 'EP 11/2/2022 23:36:47'!
whereToMoveForward: marsRover
	marsRover moveForwardFacingSouth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'identification' stamp: 'EP 10/30/2022 18:06:34'!
identifier
	^'S'.! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoints subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'public' stamp: 'MN 11/3/2022 16:59:30'!
whenRotatingLeft
	^South new.! !

!West methodsFor: 'public' stamp: 'MN 11/3/2022 16:59:53'!
whenRotatingRight
	^North new.! !

!West methodsFor: 'public' stamp: 'EP 11/2/2022 23:38:16'!
whereToMoveBackwards: marsRover
	marsRover moveBackwardsFacingWest.	! !

!West methodsFor: 'public' stamp: 'EP 11/2/2022 23:37:03'!
whereToMoveForward: marsRover
	marsRover moveForwardFacingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'identification' stamp: 'EP 10/30/2022 18:06:52'!
identifier
	^'W'.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinates orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'private' stamp: 'MN 11/3/2022 17:17:56'!
executeCommand: aCommandCode
	|command|
	
	command := MarsRoverCommand ofCode: (aCommandCode asString).
	
	command executeIn: self.! !

!MarsRover methodsFor: 'private' stamp: 'EP 11/2/2022 23:38:41'!
moveBackwards
	orientation whereToMoveBackwards: self.! !

!MarsRover methodsFor: 'private' stamp: 'EP 11/2/2022 23:35:53'!
moveForward
	orientation whereToMoveForward: self.	! !

!MarsRover methodsFor: 'private' stamp: 'MN 11/3/2022 17:18:52'!
rotateLeft
	orientation := orientation whenRotatingLeft.! !

!MarsRover methodsFor: 'private' stamp: 'MN 11/3/2022 17:19:01'!
rotateRight
	orientation := orientation whenRotatingRight.! !


!MarsRover methodsFor: 'public' stamp: 'EP 10/30/2022 16:18:35'!
isAtPosition: aCoordinate
	^coordinates = aCoordinate.! !

!MarsRover methodsFor: 'public' stamp: 'MN 11/3/2022 17:16:38'!
receiveInstructions: aSetOfInstructions
     
     aSetOfInstructions isEmpty ifTrue: [ ^self ].
     aSetOfInstructions do: [:aCommandCode | self executeCommand: aCommandCode].! !


!MarsRover methodsFor: 'dd' stamp: 'MN 11/3/2022 17:29:55'!
moveBackwardsFacingEast
	coordinates := coordinates  - (1@0).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:31:50'!
moveBackwardsFacingNorth
	coordinates := coordinates + (0@-1).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:31:55'!
moveBackwardsFacingSouth
	coordinates := coordinates + (0@1).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:31:36'!
moveBackwardsFacingWest
	coordinates := coordinates + (1@0).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:31:15'!
moveForwardFacingEast
	coordinates := coordinates + (1@0).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:30:15'!
moveForwardFacingNorth
	coordinates := coordinates + (0@1).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:30:27'!
moveForwardFacingSouth
	coordinates := coordinates + (0@-1).
	! !

!MarsRover methodsFor: 'dd' stamp: 'EP 11/2/2022 23:30:49'!
moveForwardFacingWest
	coordinates := coordinates + (-1@0).
	! !


!MarsRover methodsFor: 'initialization' stamp: 'EP 10/30/2022 17:57:59'!
initializeWithCoordinates: someCoordinates andOrientation: anOrientation
	coordinates := someCoordinates.
	orientation := CardinalPoints at: anOrientation.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'EP 10/30/2022 16:25:57'!
withCoordinates: someCoordinates andOrientation: anOrientation
	^self new initializeWithCoordinates: someCoordinates andOrientation: anOrientation.! !


!classDefinition: #MarsRoverCommand category: 'MarsRover'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommand methodsFor: 'execution' stamp: 'MN 11/3/2022 17:05:20'!
executeIn: aMarsRover
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'MarsRover'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'MN 11/3/2022 17:12:24'!
ofCode: anIdentifiyingCode

	self subclasses detect:[:aCommandSubclass | aCommandSubclass code = anIdentifiyingCode ]
	ifFound:[:aCommandSubclass | ^aCommandSubclass new.] 
	ifNone:[MarsRover error: 'Instruction not valid.'].! !


!classDefinition: #MoveBackwards category: 'MarsRover'!
MarsRoverCommand subclass: #MoveBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwards methodsFor: 'execution' stamp: 'MN 11/3/2022 17:04:36'!
executeIn: aMarsRover
	aMarsRover moveBackwards ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwards class' category: 'MarsRover'!
MoveBackwards class
	instanceVariableNames: ''!

!MoveBackwards class methodsFor: 'identification' stamp: 'MN 11/3/2022 17:10:19'!
code
	^'b'! !


!classDefinition: #MoveForward category: 'MarsRover'!
MarsRoverCommand subclass: #MoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForward methodsFor: 'execution' stamp: 'MN 11/3/2022 17:04:13'!
executeIn: aMarsRover
	aMarsRover moveForward! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForward class' category: 'MarsRover'!
MoveForward class
	instanceVariableNames: ''!

!MoveForward class methodsFor: 'identification' stamp: 'MN 11/3/2022 17:10:26'!
code
	^'f'! !


!classDefinition: #RotateLeft category: 'MarsRover'!
MarsRoverCommand subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'execution' stamp: 'MN 11/3/2022 17:31:01'!
executeIn: aMarsRover
	aMarsRover rotateLeft. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeft class' category: 'MarsRover'!
RotateLeft class
	instanceVariableNames: ''!

!RotateLeft class methodsFor: 'identification' stamp: 'MN 11/3/2022 17:10:38'!
code
	^'l'! !


!classDefinition: #RotateRight category: 'MarsRover'!
MarsRoverCommand subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'execution' stamp: 'MN 11/3/2022 17:30:55'!
executeIn: aMarsRover
	aMarsRover rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRight class' category: 'MarsRover'!
RotateRight class
	instanceVariableNames: ''!

!RotateRight class methodsFor: 'identification' stamp: 'MN 11/3/2022 17:10:44'!
code
	^'r'! !
