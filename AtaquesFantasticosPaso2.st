!classDefinition: #Bando1 category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #Bando1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bando1 class' category: 'AtaquesFantasticosPaso2'!
Bando1 class
	instanceVariableNames: 'combatientes'!

!Bando1 class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 19:27:50'!
asignarCombatientes: unosCombatientes
	combatientes := unosCombatientes.! !

!Bando1 class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 21:09:46'!
asignarEnemigos: unosEnemigos
	combatientes do: [:combatiente | combatiente enemigos: unosEnemigos].! !

!Bando1 class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 21:06:02'!
atacar
	combatientes do: [:combatiente | combatiente atacar].! !

!Bando1 class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 19:53:08'!
todosNoqueados
	| combatientesConscientes | 
	combatientesConscientes := combatientes reject: [:combatiente | combatiente estaFueraDeCombate].
	^(combatientesConscientes isEmpty).! !


!Bando1 class methodsFor: '--** private fileout/in **--' stamp: 'EP 9/18/2022 22:47:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	combatientes := ((Array new: 1) at: 1 put: CombatienteHumanoArthas; yourself).! !


!classDefinition: #Bando2 category: 'AtaquesFantasticosPaso2'!
Bando1 subclass: #Bando2
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bando2 class' category: 'AtaquesFantasticosPaso2'!
Bando2 class
	instanceVariableNames: ''!

!Bando2 class methodsFor: '--** private fileout/in **--' stamp: 'EP 9/18/2022 22:47:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	combatientes := ((Array new: 1) at: 1 put: CombatienteOrcoOlgra; yourself).! !


!classDefinition: #Combate category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #Combate
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!


!classDefinition: #CombatienteOrcoMankrik category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #CombatienteOrcoMankrik
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatienteOrcoMankrik class' category: 'AtaquesFantasticosPaso2'!
CombatienteOrcoMankrik class
	instanceVariableNames: 'fuerza enemigos puntosDeVida dañoAInfligir dañoAAbsorber estrategia agilidad consciente distraido'!

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:28:54'!
atacar
	| enemigoElegido |
	enemigos isEmpty ifTrue: [^self].
	enemigos := (enemigos  reject:[:enemigo | enemigo estaFueraDeCombate]).
	enemigoElegido := estrategia value.
	self atacarA: enemigoElegido.! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'EP 9/18/2022 18:58:44'!
atacarA: unCombatiente 
	|danio|
	danio := (dañoAInfligir+fuerza).
	(consciente = True) ifTrue:[unCombatiente recibirDaño: danio].! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:29:00'!
enemigos: unConjuntoDeEnemigos
	enemigos := unConjuntoDeEnemigos! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:29:04'!
focalizarEnElMasHerido
	estrategia := [enemigos detectMin: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:29:08'!
focalizarEnElMasSano
	estrategia := [enemigos detectMax: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:29:17'!
prepararseParaElCombate
	puntosDeVida := 20.
	dañoAInfligir := 2.
	dañoAAbsorber := 0.
	enemigos := #().
	fuerza := 2.
	agilidad := 0.
	consciente := True.
	distraido := False.
	estrategia := [enemigos anyOne ].! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:29:20'!
puntosDeVida
	^ puntosDeVida * pv.! !

!CombatienteOrcoMankrik class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:29:26'!
recibirDaño:  unaCantidadDeDaño
	| dañoADescontar |
	dañoADescontar := (unaCantidadDeDaño - dañoAAbsorber-agilidad) max: 0.
	(dañoADescontar = 0) ifTrue:[distraido := True] ifFalse:[(distraido = True)ifTrue:[dañoADescontar := dañoADescontar + 2]].
	puntosDeVida := puntosDeVida - dañoADescontar.
	(puntosDeVida > 0) ifFalse:[consciente := False].! !


!CombatienteOrcoMankrik class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:29:36'!
usarArmaduraDeCuero
	dañoAAbsorber := 2.! !

!CombatienteOrcoMankrik class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:29:38'!
usarArmaduraDeMetal
	dañoAAbsorber := 6.! !

!CombatienteOrcoMankrik class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:29:41'!
usarEspada
	dañoAInfligir := 8.! !

!CombatienteOrcoMankrik class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:29:44'!
usarHacha
	dañoAInfligir := 10.! !


!CombatienteOrcoMankrik class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 22:33:25'!
estaFueraDeCombate
	^(consciente = False).! !

!CombatienteOrcoMankrik class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 22:33:29'!
estaHerido
	^(puntosDeVida ~= 20).! !

!CombatienteOrcoMankrik class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 22:33:31'!
noEstaHerido
	^(puntosDeVida = 20).! !

!CombatienteOrcoMankrik class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 22:33:33'!
tienePuntosDeVida: unosPuntos
	^(unosPuntos = self puntosDeVida).! !


!CombatienteOrcoMankrik class methodsFor: '--** private fileout/in **--' stamp: 'EP 9/18/2022 22:47:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	fuerza := 2.
	enemigos := #().
	puntosDeVida := 20.
	dañoAInfligir := 2.
	dañoAAbsorber := 0.
	estrategia := ((SerializableBlockClosure basicNew instVarAt: 1 put: CombatienteOrcoMankrik; instVarAt: 2 put: '[ (theSelf instVarNamed: ''enemigos'') anyOne. ]'; instVarAt: 3 put: #(); yourself) asEvaluable).
	agilidad := 0.
	consciente := True.
	distraido := False.! !


!classDefinition: #CombatienteHumanoArthas category: 'AtaquesFantasticosPaso2'!
CombatienteOrcoMankrik subclass: #CombatienteHumanoArthas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatienteHumanoArthas class' category: 'AtaquesFantasticosPaso2'!
CombatienteHumanoArthas class
	instanceVariableNames: ''!

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:31:18'!
atacar
	| enemigoElegido |
	enemigos isEmpty ifTrue: [^self].
	enemigos := (enemigos  reject:[:enemigo | enemigo estaFueraDeCombate]).
	enemigoElegido := estrategia value.
	self atacarA: enemigoElegido.! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:31:23'!
atacarA: unCombatiente 
	|danio|
	danio := (dañoAInfligir+fuerza).
	(consciente = True) ifTrue:[unCombatiente recibirDaño: danio].! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:31:27'!
enemigos: unConjuntoDeEnemigos
	enemigos := unConjuntoDeEnemigos! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:31:30'!
focalizarEnElMasHerido
	estrategia := [enemigos detectMin: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:31:33'!
focalizarEnElMasSano
	estrategia := [enemigos detectMax: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:31:42'!
prepararseParaElCombate
	puntosDeVida := 20.
	dañoAInfligir := 2.
	dañoAAbsorber := 0.
	enemigos := #().
	estrategia := [enemigos anyOne ].
	consciente := True.
	distraido := False.
	fuerza := 0.
	agilidad := 1.! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:31:52'!
puntosDeVida
	^ puntosDeVida * pv.! !

!CombatienteHumanoArthas class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:31:58'!
recibirDaño:  unaCantidadDeDaño
	| dañoADescontar |
	dañoADescontar := (unaCantidadDeDaño - dañoAAbsorber-agilidad) max: 0.
	(dañoADescontar = 0) ifTrue:[distraido := True] ifFalse:[(distraido = True)ifTrue:[dañoADescontar := dañoADescontar + 2]].
	puntosDeVida := puntosDeVida - dañoADescontar.
	(puntosDeVida > 0) ifFalse:[consciente := False].! !


!CombatienteHumanoArthas class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:31:10'!
usarArmaduraDeCuero
	dañoAAbsorber := 2.! !

!CombatienteHumanoArthas class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:31:07'!
usarArmaduraDeMetal
	dañoAAbsorber := 6.! !

!CombatienteHumanoArthas class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:31:05'!
usarEspada
	dañoAInfligir := 8.! !

!CombatienteHumanoArthas class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:31:02'!
usarHacha
	dañoAInfligir := 10.! !


!CombatienteHumanoArthas class methodsFor: 'as yet unclassified' stamp: 'MN 9/18/2022 17:05:49'!
estaFueraDeCombate
	^(consciente = False).! !

!CombatienteHumanoArthas class methodsFor: 'as yet unclassified' stamp: 'EP 9/16/2022 18:45:06'!
estaHerido
	^(puntosDeVida ~= 20).! !

!CombatienteHumanoArthas class methodsFor: 'as yet unclassified' stamp: 'EP 9/16/2022 18:50:33'!
noEstaHerido
	^(puntosDeVida = 20).! !

!CombatienteHumanoArthas class methodsFor: 'as yet unclassified' stamp: 'EP 9/16/2022 18:18:57'!
tienePuntosDeVida: unosPuntos
	^(unosPuntos = self puntosDeVida).! !


!CombatienteHumanoArthas class methodsFor: '--** private fileout/in **--' stamp: 'EP 9/18/2022 22:47:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	fuerza := 0.
	enemigos := ((Array new: 1) at: 1 put: CombatienteOrcoOlgra; yourself).
	puntosDeVida := 20.
	dañoAInfligir := 2.
	dañoAAbsorber := 0.
	estrategia := ((SerializableBlockClosure basicNew instVarAt: 1 put: CombatienteHumanoArthas; instVarAt: 2 put: '[ (theSelf instVarNamed: ''enemigos'') anyOne. ]'; instVarAt: 3 put: #(); yourself) asEvaluable).
	agilidad := 1.
	consciente := True.
	distraido := False.! !


!classDefinition: #CombatienteOrcoOlgra category: 'AtaquesFantasticosPaso2'!
CombatienteOrcoMankrik subclass: #CombatienteOrcoOlgra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatienteOrcoOlgra class' category: 'AtaquesFantasticosPaso2'!
CombatienteOrcoOlgra class
	instanceVariableNames: ''!

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:32:25'!
atacar
	| enemigoElegido |
	enemigos isEmpty ifTrue: [^self].
	enemigos := (enemigos  reject:[:enemigo | enemigo estaFueraDeCombate]).
	enemigoElegido := estrategia value.
	self atacarA: enemigoElegido.! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:32:30'!
atacarA: unCombatiente 
	|danio|
	danio := (dañoAInfligir+fuerza).
	(consciente = True) ifTrue:[unCombatiente recibirDaño: danio].! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:32:33'!
enemigos: unConjuntoDeEnemigos
	enemigos := unConjuntoDeEnemigos! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:32:35'!
focalizarEnElMasHerido
	estrategia := [enemigos detectMin: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:32:38'!
focalizarEnElMasSano
	estrategia := [enemigos detectMax: [:enemigo | enemigo puntosDeVida]].! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:32:46'!
prepararseParaElCombate
	puntosDeVida := 20.
	dañoAInfligir := 2.
	dañoAAbsorber := 0.
	enemigos := #().
	estrategia := [enemigos anyOne ].
	consciente := True.
	distraido := False.
	fuerza := 1.
	agilidad := 0.! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:32:49'!
puntosDeVida
	^ puntosDeVida * pv.! !

!CombatienteOrcoOlgra class methodsFor: 'combate' stamp: 'EP 9/18/2022 22:32:57'!
recibirDaño:  unaCantidadDeDaño
	| dañoADescontar |
	dañoADescontar := (unaCantidadDeDaño - dañoAAbsorber-agilidad) max: 0.
	(dañoADescontar = 0) ifTrue:[distraido := True] ifFalse:[(distraido = True)ifTrue:[dañoADescontar := dañoADescontar + 2]].
	puntosDeVida := puntosDeVida - dañoADescontar.
	(puntosDeVida > 0) ifFalse:[consciente := False].! !


!CombatienteOrcoOlgra class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:33:12'!
usarArmaduraDeCuero
	dañoAAbsorber := 2.! !

!CombatienteOrcoOlgra class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:33:04'!
usarArmaduraDeMetal
	dañoAAbsorber := 6.! !

!CombatienteOrcoOlgra class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:33:07'!
usarEspada
	dañoAInfligir := 8.! !

!CombatienteOrcoOlgra class methodsFor: 'equipo' stamp: 'EP 9/18/2022 22:33:09'!
usarHacha
	dañoAInfligir := 10.! !


!CombatienteOrcoOlgra class methodsFor: 'as yet unclassified' stamp: 'MN 9/18/2022 17:05:52'!
estaFueraDeCombate
	^(consciente = False).! !

!CombatienteOrcoOlgra class methodsFor: 'as yet unclassified' stamp: 'EP 9/16/2022 18:45:00'!
estaHerido
	^(puntosDeVida ~= 20).! !

!CombatienteOrcoOlgra class methodsFor: 'as yet unclassified' stamp: 'EP 9/16/2022 18:49:04'!
noEstaHerido
	^(puntosDeVida = 20).! !

!CombatienteOrcoOlgra class methodsFor: 'as yet unclassified' stamp: 'EP 9/16/2022 18:15:50'!
tienePuntosDeVida: unosPuntos
	^(unosPuntos = self puntosDeVida).! !


!CombatienteOrcoOlgra class methodsFor: '--** private fileout/in **--' stamp: 'EP 9/18/2022 22:47:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	fuerza := 1.
	enemigos := ((Array new: 1) at: 1 put: CombatienteHumanoArthas; yourself).
	puntosDeVida := 20.
	dañoAInfligir := 2.
	dañoAAbsorber := 0.
	estrategia := ((SerializableBlockClosure basicNew instVarAt: 1 put: CombatienteOrcoOlgra; instVarAt: 2 put: '[ (theSelf instVarNamed: ''enemigos'') anyOne. ]'; instVarAt: 3 put: #(); yourself) asEvaluable).
	agilidad := 0.
	consciente := True.
	distraido := False.! !


!classDefinition: #CombatientesTest category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #CombatientesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CombatientesTest class' category: 'AtaquesFantasticosPaso2'!
CombatientesTest class
	instanceVariableNames: ''!

!CombatientesTest class methodsFor: '--** private fileout/in **--' stamp: 'JMB 9/14/2022 00:19:03'!
initialize

	"Este método está para crear unidades. No se debe tocar"

	| puntosDeVida |
	puntosDeVida := BaseUnit named: 'puntosDeVida' sign: 'pv'.

	Smalltalk at: #pv put: puntosDeVida.
	Smalltalk at: #puntosDeVida put: puntosDeVida.! !


!CombatientesTest class methodsFor: 'preparacion de combates' stamp: 'EP 9/18/2022 22:34:20'!
arthasConHachaDejaFueraDeCombateAMankrik.
	self combatienteHumanoArthas usarHacha.
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.! !

!CombatientesTest class methodsFor: 'preparacion de combates' stamp: 'EP 9/18/2022 22:34:25'!
mankrikConHachaDejaFueraDeCombateAArthas
	self combatienteOrcoMankrik usarHacha.
	self combatienteOrcoMankrik atacarA: self combatienteHumanoArthas. 
	self combatienteOrcoMankrik atacarA: self combatienteHumanoArthas. 
	self combatienteOrcoMankrik atacarA: self combatienteHumanoArthas. ! !

!CombatientesTest class methodsFor: 'preparacion de combates' stamp: 'EP 9/18/2022 22:34:29'!
olgraConHachaDejaFueraDeCombateAMankrik.
	self combatienteOrcoOlgra usarHacha.
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.! !


!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'EP 9/18/2022 22:34:38'!
test01CuandoArthasAtacaAOlgraLeHaceDaño
	
	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 18*pv) description: 'Olgra debe tener 18 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'EP 9/18/2022 22:34:51'!
test02CuandoArthasAtacaMasDeUnaVezAOlgraLeHaceDañoEnCadaAtaque

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 16*pv) description: 'Olgra debe tener 16 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'EP 9/18/2022 22:35:00'!
test03CuandoArthasAtacaConUnHachaHace10DeDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarHacha.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 10*pv) description: 'Olgra debe tener 10 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'EP 9/18/2022 22:35:09'!
test04CuandoArthasAtacaConUnaEspadaHace8DeDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarEspada.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 12*pv) description: 'Olgra debe tener 12 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'EP 9/18/2022 22:35:18'!
test05CuandoOlgraUsaUnaArmaduraDeCueroResuceLosAtaquesCon2DeDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarEspada.
	self combatienteOrcoOlgra usarArmaduraDeCuero.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 14*pv) description: 'Olgra debe tener 14 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'EP 9/18/2022 22:35:29'!
test06CuandoOlgraUsaUnaArmaduraDeMetalResuceLosAtaquesCon6DeDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarEspada.
	self combatienteOrcoOlgra usarArmaduraDeMetal.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 18*pv) description: 'Olgra debe tener 18 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - combatientes' stamp: 'EP 9/18/2022 22:35:37'!
test07CuandoOlgraUsaUnaArmaduraResuceElDañoPeroNoRecuperaPuntosDeVida

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarArmaduraDeMetal.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: self combatienteOrcoOlgra noEstaHerido description: 'Olgra debe tener los puntos de vida completos'.! !


!CombatientesTest class methodsFor: 'tests - atacar' stamp: 'EP 9/18/2022 22:35:49'!
test08CuandoArthasNoTieneEnemigosNoAtacaANadie
	self comenzarUnNuevoCombate .
	
	self combatienteHumanoArthas atacar.
	
	Assert isTrue: self combatienteOrcoOlgra noEstaHerido description: 'Olgra debe tener los puntos de vida completos'.
	Assert isTrue: self combatienteOrcoMankrik noEstaHerido description: 'Mankrik debe tener los puntos de vida completos'.
	
	! !

!CombatientesTest class methodsFor: 'tests - atacar' stamp: 'EP 9/18/2022 22:36:00'!
test09CuandoArthasTieneEnemigosAtacaAUno
	| soloOlgraEstaHerido soloMankrikEstaHerido |
	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra . self combatienteOrcoMankrik .}.
	
	self combatienteHumanoArthas atacar.
	
	soloOlgraEstaHerido := self combatienteOrcoOlgra estaHerido and: [self combatienteOrcoMankrik noEstaHerido ].
	soloMankrikEstaHerido := self combatienteOrcoMankrik estaHerido and: [self combatienteOrcoOlgra noEstaHerido ].
	Assert isTrue: (soloOlgraEstaHerido or: [soloMankrikEstaHerido]).! !

!CombatientesTest class methodsFor: 'tests - atacar' stamp: 'JMB 9/14/2022 00:20:44'!
test10CuandoArthasTieneComoEstrategiaAtacarAlMasHeridoDañaAlQueEstaMasHerido
	
	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra . self combatienteOrcoMankrik .}.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra .	
	self combatienteHumanoArthas focalizarEnElMasHerido.
	
	self combatienteHumanoArthas atacar.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 16*pv) description: 'Olgra debe tener 16 puntos de vida'.
	! !

!CombatientesTest class methodsFor: 'tests - atacar' stamp: 'EP 9/18/2022 22:36:20'!
test11CuandoArthasTieneComoEstrategiaAtacarAlMasSanoDañaAlQueEstaMenosHerido
	
	self comenzarUnNuevoCombate.
	self combatienteHumanoArthas usarEspada.
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra . self combatienteOrcoMankrik .}.
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.	
	self combatienteHumanoArthas focalizarEnElMasSano.
	
	self combatienteHumanoArthas atacar.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 12*pv) description: 'Olgra debe tener 12 puntos de vida'.
	! !


!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:36:31'!
test12CuandoOlgraAtacaConSusPuñosAMankrikLeHace2DeDañoMas1PorFuerza
	
	self comenzarUnNuevoCombate.
	
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 17*pv) description: 'Mankrik debe tener 17 puntos de vida (20 inicial - 2 por puños - 1 por fuerza)'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:36:39'!
test13CuandoMankrikAtacaConSusPuñosAOlgraLeHace2DeDañoMas2PorFuerza
	
	self comenzarUnNuevoCombate.
	
	self combatienteOrcoMankrik atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 16*pv) description: 'Olgra debe tener 16 puntos de vida (20 inicial - 2 por puños - 2 por fuerza)'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:36:50'!
test14CuandoMankrikAtacaAArthasLeHaceDañoReducidoEn1PorSuAgilidad
	
	self comenzarUnNuevoCombate.
	
	self combatienteOrcoMankrik atacarA: self combatienteHumanoArthas.

	Assert 
		isTrue: (self combatienteHumanoArthas tienePuntosDeVida: 17*pv) 
		description: 'Arthas debe tener 17 puntos de vida (20 inicial - 2 por puños - 2 por fuerza + 1 agilidad de Arthas)'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:36:58'!
test15CuandoOlgraAtacaConUnHachaHace10DeDañoMas1PorFuerza

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarHacha.
	
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 9*pv) description: 'Olgra debe tener 9 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:37:09'!
test16CuandoOlgraAtacaConUnaEspadaHace8DeDañoMas1PorFuerza

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarEspada.
	
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 11*pv) description: 'Mankrik debe tener 11 puntos de vida'.
	! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:37:19'!
test17CuandoMankrikAtacaConUnHachaHace10DeDañoMas2PorFuerza

	self comenzarUnNuevoCombate .
	self combatienteOrcoMankrik usarHacha.
	
	self combatienteOrcoMankrik atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 8*pv) description: 'Olgra debe tener 8 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:37:31'!
test18CuandoMankrikAtacaConUnaEspadaHace8DeDañoMas2PorFuerza

	self comenzarUnNuevoCombate .
	self combatienteOrcoMankrik usarEspada.
	
	self combatienteOrcoMankrik atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 10*pv) description: 'Olgra debe tener 10 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:37:44'!
test19CuandoMankrikUsaUnaArmaduraDeCueroResuceLosAtaquesCon2DeDaño

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarEspada.
	self combatienteOrcoMankrik usarArmaduraDeCuero.
	
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 13*pv) description: 'Mankrik debe tener 13 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:37:54'!
test20CuandoMankrikUsaUnaArmaduraDeMetalResuceLosAtaquesCon6DeDaño

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarEspada.
	self combatienteOrcoMankrik usarArmaduraDeMetal.
	
	self combatienteOrcoOlgra atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 17*pv) description: 'Mankrik debe tener 17 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:38:02'!
test21CuandoArthasUsaUnaArmaduraDeCueroResuceLosAtaquesCon2DeDaño

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarEspada.
	self combatienteHumanoArthas usarArmaduraDeCuero.
	
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	
	Assert isTrue: (self combatienteHumanoArthas tienePuntosDeVida: 14*pv) description: 'Arthas debe tener 14 puntos de vida'.! !

!CombatientesTest class methodsFor: 'tests - fuerza y agilidad' stamp: 'EP 9/18/2022 22:38:12'!
test22CuandoArthasUsaUnaArmaduraDeMetalResuceLosAtaquesCon6DeDaño

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarEspada.
	self combatienteHumanoArthas usarArmaduraDeMetal.
	
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	
	Assert isTrue: (self combatienteHumanoArthas tienePuntosDeVida: 18*pv) description: 'Arthas debe tener 18 puntos de vida'.! !


!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'EP 9/18/2022 22:40:06'!
test23CuandoArthasEstaFueraDeCombateNoHaceDaño

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarHacha.
	
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isFalse: self combatienteOrcoOlgra estaHerido.! !

!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'EP 9/18/2022 22:40:18'!
test24CuandoOlgraEstaFueraDeCombateNoHaceDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarHacha.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	self combatienteOrcoOlgra atacarA: self combatienteHumanoArthas.
	
	Assert isFalse: self combatienteHumanoArthas estaHerido.! !

!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'EP 9/18/2022 22:40:34'!
test25CuandoMankrikEstaFueraDeCombateNoHaceDaño

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas usarHacha.
	
	self arthasConHachaDejaFueraDeCombateAMankrik.
	
	self combatienteOrcoMankrik atacarA: self combatienteHumanoArthas.
	
	Assert isFalse: self combatienteHumanoArthas estaHerido.! !

!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'EP 9/18/2022 22:40:50'!
test26ArthasNoAtacaALosEnemigosFueraDeCombate

	self comenzarUnNuevoCombate .
	self combatienteHumanoArthas focalizarEnElMasHerido.	
	self arthasConHachaDejaFueraDeCombateAMankrik.
	self combatienteHumanoArthas enemigos: {self combatienteOrcoOlgra . self combatienteOrcoMankrik .}.
	
	self combatienteHumanoArthas atacar.
	
	Assert isTrue: self combatienteOrcoOlgra estaHerido.! !

!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'EP 9/18/2022 22:41:01'!
test27OlgraNoAtacaALosEnemigosFueraDeCombate

	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra focalizarEnElMasHerido.
	self olgraConHachaDejaFueraDeCombateAMankrik.
	self combatienteOrcoOlgra enemigos: {self combatienteHumanoArthas. self combatienteOrcoMankrik .}.
	
	self combatienteOrcoOlgra atacar.
	
	Assert isTrue: self combatienteHumanoArthas estaHerido.! !

!CombatientesTest class methodsFor: 'tests - fuera de combate' stamp: 'EP 9/18/2022 22:41:11'!
test28MankrikNoAtacaALosEnemigosFueraDeCombate

	self comenzarUnNuevoCombate .
	self combatienteOrcoMankrik focalizarEnElMasHerido.
	self mankrikConHachaDejaFueraDeCombateAArthas.
	self combatienteOrcoMankrik enemigos: {self combatienteHumanoArthas. self combatienteOrcoOlgra .}.
	
	self combatienteOrcoMankrik atacar.
	
	Assert isTrue: self combatienteOrcoOlgra estaHerido.! !


!CombatientesTest class methodsFor: 'tests - condicion de distraido' stamp: 'EP 9/18/2022 22:41:26'!
test29CuandoOlgraEstaDistraidoLeHacen2MasDeDaño
	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarArmaduraDeCuero.	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas usarEspada.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert 
		isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 12*pv) 
		description: 'Olgra debe tener 12 puntos de vida: 20 (inicial) - 8 (por espada) + 2 (armadura de cuero) - 2 (daño por distraido)'.! !

!CombatientesTest class methodsFor: 'tests - condicion de distraido' stamp: 'EP 9/18/2022 22:41:37'!
test30CuandoElAtaqueNoInflingeDañoOlgraNoRecibeDañoPorEstarDistradido
	self comenzarUnNuevoCombate .
	self combatienteOrcoOlgra usarArmaduraDeCuero.	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	
	Assert isTrue: self combatienteOrcoOlgra noEstaHerido description: 'Olgra debe tener los puntos de vida completos'.! !

!CombatientesTest class methodsFor: 'tests - condicion de distraido' stamp: 'EP 9/18/2022 22:41:52'!
test31CuandoMankrikEstaDistraidoLeHacen2MasDeDaño
	self comenzarUnNuevoCombate .
	self combatienteOrcoMankrik usarArmaduraDeCuero.	
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	self combatienteHumanoArthas usarEspada.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	
	Assert 
		isTrue: (self combatienteOrcoMankrik tienePuntosDeVida: 12*pv) 
		description: 'Mankrik debe tener 12 puntos de vida: 20 (inicial) - 8 (por espada) + 2 (armadura de cuero) - 2 (daño por distraido)'.! !

!CombatientesTest class methodsFor: 'tests - condicion de distraido' stamp: 'EP 9/18/2022 22:42:02'!
test32CuandoElAtaqueNoInflingeDañoMankrikNoRecibeDañoPorEstarDistradido
	self comenzarUnNuevoCombate .
	self combatienteOrcoMankrik usarArmaduraDeCuero.	
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	
	self combatienteHumanoArthas atacarA: self combatienteOrcoMankrik.
	
	Assert isTrue: self combatienteOrcoMankrik noEstaHerido description: 'Mankrik debe tener los puntos de vida completos'.! !


!CombatientesTest class methodsFor: 'Para completar' stamp: 'EP 9/18/2022 22:42:08'!
combatienteHumanoArthas
	^CombatienteHumanoArthas ! !

!CombatientesTest class methodsFor: 'Para completar' stamp: 'EP 9/18/2022 22:42:10'!
combatienteOrcoMankrik
	^CombatienteOrcoMankrik ! !

!CombatientesTest class methodsFor: 'Para completar' stamp: 'EP 9/18/2022 22:42:12'!
combatienteOrcoOlgra
	^CombatienteOrcoOlgra ! !

!CombatientesTest class methodsFor: 'Para completar' stamp: 'EP 9/18/2022 22:42:16'!
comenzarUnNuevoCombate
	CombatienteHumanoArthas prepararseParaElCombate .
	CombatienteOrcoOlgra prepararseParaElCombate .
	CombatienteOrcoMankrik prepararseParaElCombate .! !


!classDefinition: #EstrategiasTest category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #EstrategiasTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstrategiasTest class' category: 'AtaquesFantasticosPaso2'!
EstrategiasTest class
	instanceVariableNames: ''!

!EstrategiasTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:42:48'!
orquestadorParaArthasUsandoUnHachaYConFocoEnElMasHeridoVsOrcos
	
	OrquestadorDeCombatesTest prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasHerido. 
	self combatienteHumanoArthas usarHacha.
	OrquestadorDeCombatesTest 
		establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
	^ OrquestadorDeCombatesTest orquestadorDeCombates! !

!EstrategiasTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:42:55'!
orquestadorParaArthasUsandoUnHachaYConFocoEnElMasSanoVsOrcos
	
	OrquestadorDeCombatesTest prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasSano. 
	self combatienteHumanoArthas usarHacha.
	OrquestadorDeCombatesTest 
		establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
	^ OrquestadorDeCombatesTest orquestadorDeCombates! !

!EstrategiasTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:43:02'!
puntosDeVidaDelGanadorFocalizandoEnElMasHerido
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaArthasUsandoUnHachaYConFocoEnElMasHeridoVsOrcos.
	orquestadorDeCombates desarrollarDuranteRondas: 100.
	^ self combatienteHumanoArthas puntosDeVida! !

!EstrategiasTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:43:07'!
puntosDeVidaDelGanadorFocalizandoEnElMasSano
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaArthasUsandoUnHachaYConFocoEnElMasSanoVsOrcos.
	orquestadorDeCombates desarrollarDuranteRondas: 100.
	^ self combatienteHumanoArthas puntosDeVida! !


!EstrategiasTest class methodsFor: 'combatientes' stamp: 'EP 9/18/2022 22:42:33'!
combatienteHumanoArthas
	^CombatienteHumanoArthas ! !

!EstrategiasTest class methodsFor: 'combatientes' stamp: 'EP 9/18/2022 22:42:37'!
combatienteOrcoMankrik
	^CombatienteOrcoMankrik ! !

!EstrategiasTest class methodsFor: 'combatientes' stamp: 'EP 9/18/2022 22:42:39'!
combatienteOrcoOlgra
	^CombatienteOrcoOlgra ! !


!EstrategiasTest class methodsFor: 'tests' stamp: 'EP 9/18/2022 22:43:15'!
test01FocalizarEnElMasHeridoEsMejorQueEnElMasSano
	
	Assert isTrue: self puntosDeVidaDelGanadorFocalizandoEnElMasHerido > self puntosDeVidaDelGanadorFocalizandoEnElMasSano.! !


!classDefinition: #OrquestadorDeCombate category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #OrquestadorDeCombate
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeCombate class' category: 'AtaquesFantasticosPaso2'!
OrquestadorDeCombate class
	instanceVariableNames: 'ganador rondasAlcanzadas'!

!OrquestadorDeCombate class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 20:10:31'!
bando1
	^Bando1.
! !

!OrquestadorDeCombate class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 20:10:46'!
bando2
	^Bando2! !

!OrquestadorDeCombate class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 22:26:06'!
desarrollarDuranteRondas: unNumero
	rondasAlcanzadas := 0.
	[rondasAlcanzadas < unNumero and: (self hayGanador = False)] whileTrue: [self todosAtacan. rondasAlcanzadas := rondasAlcanzadas + 1].! !

!OrquestadorDeCombate class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 20:50:56'!
establecerCombateEntreBando1: unEquipo1 contraBando2: unEquipo2
	self bando1 asignarCombatientes: unEquipo1.
	self bando1 asignarEnemigos: unEquipo2.
	
	self bando2 asignarCombatientes: unEquipo2.
	self bando2 asignarEnemigos: unEquipo1.! !

!OrquestadorDeCombate class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 20:14:03'!
hayGanador
	^(self bando1 todosNoqueados = True) or: (self bando2 todosNoqueados = True).! !

!OrquestadorDeCombate class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 20:28:59'!
obtenerGanador
	 (self bando1 todosNoqueados and: self bando2 todosNoqueados = False) ifTrue: [ganador := 1].
	 (self bando2 todosNoqueados and: self bando1 todosNoqueados = False) ifTrue: [ganador := 2].
	^ganador.
	 ! !

!OrquestadorDeCombate class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 20:35:17'!
obtenerRondasAlcanzadas
	^rondasAlcanzadas.! !

!OrquestadorDeCombate class methodsFor: 'as yet unclassified' stamp: 'EP 9/18/2022 20:48:28'!
todosAtacan
	self bando1 atacar.
	self bando2 atacar.! !


!OrquestadorDeCombate class methodsFor: '--** private fileout/in **--' stamp: 'EP 9/18/2022 22:47:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	ganador := nil.
	rondasAlcanzadas := 0.! !


!classDefinition: #OrquestadorDeCombatesTest category: 'AtaquesFantasticosPaso2'!
DenotativeObject subclass: #OrquestadorDeCombatesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AtaquesFantasticosPaso2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrquestadorDeCombatesTest class' category: 'AtaquesFantasticosPaso2'!
OrquestadorDeCombatesTest class
	instanceVariableNames: ''!

!OrquestadorDeCombatesTest class methodsFor: 'para completar' stamp: 'EP 9/18/2022 20:36:08'!
assertElResultadoIndicaQueGanoElBando1: resultadoDeUnCombate alcanzadaLaRonda: unNumeroDeRondaEsperado
	Assert isTrue: (resultadoDeUnCombate obtenerGanador = 1 and: resultadoDeUnCombate obtenerRondasAlcanzadas = unNumeroDeRondaEsperado)
	description: 'El ganador deberia ser bando1.'! !

!OrquestadorDeCombatesTest class methodsFor: 'para completar' stamp: 'EP 9/18/2022 20:36:38'!
assertElResultadoIndicaQueGanoElBando2: resultadoDeUnCombate alcanzadaLaRonda: unNumeroDeRondaEsperado
Assert isTrue: (resultadoDeUnCombate obtenerGanador = 2 and: resultadoDeUnCombate obtenerRondasAlcanzadas = unNumeroDeRondaEsperado)
	description: 'El ganador deberia ser bando2.'! !

!OrquestadorDeCombatesTest class methodsFor: 'para completar' stamp: 'EP 9/18/2022 20:38:10'!
assertElResultadoIndicaQueNoHayGanador: resultadoDeUnCombate  alcanzadaLaRonda: unNumeroDeRondaEsperado
Assert isTrue: (resultadoDeUnCombate hayGanador = False)
	description: 'No deberia haber ganador.'! !

!OrquestadorDeCombatesTest class methodsFor: 'para completar' stamp: 'EP 9/18/2022 20:57:25'!
establecerCombateEntreBando1: unEquipo1 contraBando2: unEquipo2
	self orquestadorDeCombates bando1 asignarCombatientes: unEquipo1.
	self orquestadorDeCombates bando1 asignarEnemigos: unEquipo2.
.
	self orquestadorDeCombates bando2 asignarCombatientes: unEquipo2.
	self orquestadorDeCombates bando2 asignarEnemigos: unEquipo1.! !

!OrquestadorDeCombatesTest class methodsFor: 'para completar' stamp: 'EP 9/18/2022 20:12:48'!
orquestadorDeCombates
	^OrquestadorDeCombate.! !


!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:46:32'!
orquestadorParaCombateArthasConFocoEnElMasSanoVsOrcos	
	
	self prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasSano. 
	self establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:46:39'!
orquestadorParaCombateArthasInmuneYFocoEnElMasHeridoVsOrcos	
	
	self prepararCombatientes.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas usarArmaduraDeMetal. 
	self combatienteHumanoArthas focalizarEnElMasHerido. 
	self establecerCombateEntreBando1:  {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:46:46'!
orquestadorParaCombateArthasVsOlgra	
	
	self prepararCombatientes. 
	self establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:46:50'!
orquestadorParaCombateArthasVsOrcos
	self prepararCombatientes.
	self establecerCombateEntreBando1: { self combatienteHumanoArthas } contraBando2: {self combatienteOrcoOlgra. self combatienteOrcoMankrik }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:46:57'!
orquestadorParaCombateManoAManoConBando2Inmune	
	
	self prepararCombatientes.
	self combatienteOrcoOlgra usarEspada.
	self establecerCombateEntreBando1: {self combatienteHumanoArthas } contraBando2: { self combatienteOrcoOlgra }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:47:03'!
orquestadorParaCombateOrcosVsArthas
	self prepararCombatientes.
	self establecerCombateEntreBando1: {self combatienteOrcoOlgra. self combatienteOrcoMankrik } contraBando2: { self combatienteHumanoArthas }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:47:09'!
orquestadorParaCombateOrcosVsArthasConFocoEnElMasSano	
	
	self prepararCombatientes.
	self combatienteHumanoArthas focalizarEnElMasSano. 
	self establecerCombateEntreBando1: { self combatienteOrcoOlgra. self combatienteOrcoMankrik } contraBando2: {self combatienteHumanoArthas }. 
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:47:19'!
orquestadorParaCombateOrcosVsArthasInmuneYFocoEnElMasHerido	
	
	self prepararCombatientes.
	self combatienteHumanoArthas atacarA: self combatienteOrcoOlgra.
	self combatienteHumanoArthas usarArmaduraDeMetal. 
	self combatienteHumanoArthas focalizarEnElMasHerido. 
	self establecerCombateEntreBando1: { self combatienteOrcoOlgra. self combatienteOrcoMankrik } contraBando2: {self combatienteHumanoArthas }.
	^ self orquestadorDeCombates! !

!OrquestadorDeCombatesTest class methodsFor: 'combates' stamp: 'EP 9/18/2022 22:47:23'!
prepararCombatientes
	self combatienteHumanoArthas prepararseParaElCombate. 
	self combatienteOrcoOlgra prepararseParaElCombate.
	self combatienteOrcoMankrik prepararseParaElCombate. ! !


!OrquestadorDeCombatesTest class methodsFor: 'combatientes' stamp: 'EP 9/18/2022 22:47:31'!
combatienteHumanoArthas

	^ CombatienteHumanoArthas! !

!OrquestadorDeCombatesTest class methodsFor: 'combatientes' stamp: 'EP 9/18/2022 22:47:38'!
combatienteOrcoMankrik

	^ CombatienteOrcoMankrik! !

!OrquestadorDeCombatesTest class methodsFor: 'combatientes' stamp: 'EP 9/18/2022 22:47:42'!
combatienteOrcoOlgra

	^ CombatienteOrcoOlgra! !


!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'EP 9/18/2022 22:45:46'!
test01AlDesarrollarUnCombateSinRondasLosCombatientesNoSeAtacan

	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	orquestadorDeCombates desarrollarDuranteRondas: 0.
	Assert isTrue: self combatienteHumanoArthas noEstaHerido.
	Assert isTrue: self combatienteOrcoOlgra noEstaHerido.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'EP 9/18/2022 22:45:30'!
test02AlDesarrollarUnCombateManoAManoDeUnaRondaLosBandosSeAtacanUnaVez
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	orquestadorDeCombates desarrollarDuranteRondas: 1.
	
	Assert isTrue: (self combatienteHumanoArthas tienePuntosDeVida: 18*pv) description: 'Arthas debe recibir un puñetazo (2 de daño)'.
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 18*pv) description: 'Olgra debe recibir un puñetazo (2 de daño)'.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'EP 9/18/2022 22:45:41'!
test03AlDesarrollarUnCombateManoAManoConMasDeUnaRondaLosBandosSeAtacanCadaVez
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	orquestadorDeCombates desarrollarDuranteRondas: 2.
	
	Assert isTrue: (self combatienteHumanoArthas tienePuntosDeVida: 16*pv) description: 'Arthas debe recibir dos puñetazos (4 de daño)'.
	Assert isTrue: (self combatienteOrcoOlgra tienePuntosDeVida: 16*pv) description: 'Olgra debe recibir dos puñetazos (4 de daño)'.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'EP 9/18/2022 22:45:55'!
test04AlDesarrollarUnCombateManoAManoSinGanadoresElResultadoEsIndeterminado
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 0.
	
	self assertElResultadoIndicaQueNoHayGanador: resultado alcanzadaLaRonda: 0.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'EP 9/18/2022 22:46:03'!
test05AlDesarrollarUnCombateManoAManoGanaElBando1CuandoDejaFueraDeCombateASuRival
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 10.
	
	self assertElResultadoIndicaQueGanoElBando1: resultado alcanzadaLaRonda: 10.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'EP 9/18/2022 22:46:12'!
test06AlDesarrollarUnCombateCuandoHayUnGanadorFinalizaEnLaRondaQueElPerdedorQuedoFueraDeCombate
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOlgra.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 11.
	
	self assertElResultadoIndicaQueGanoElBando1: resultado alcanzadaLaRonda: 10.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - mano a mano' stamp: 'EP 9/18/2022 22:46:20'!
test07AlDesarrollarUnCombateManoAManoGanaElBando2CuandoDejaFueraDeCombateASuRival
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateManoAManoConBando2Inmune.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 100.
	
	self assertElResultadoIndicaQueGanoElBando2: resultado alcanzadaLaRonda: 3.! !


!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'EP 9/18/2022 22:45:12'!
test08AlDesarrollarUnCombateLosDelBando1PuedenAtacarACualquieraDelBando2
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateArthasConFocoEnElMasSanoVsOrcos.
	
	orquestadorDeCombates desarrollarDuranteRondas: 2.
	
	Assert isTrue: self combatienteOrcoOlgra estaHerido. 
	Assert isTrue: self combatienteOrcoMankrik estaHerido. ! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'EP 9/18/2022 22:45:01'!
test09AlDesarrollarUnCombateAtacanTodesLosDelBando1EnCadaRonda
	"
		En cada ronda Olgra daña a Arthas en 2  (2 puños + 1 por fuerza - 1 por agilidad de Arthas) y  Mankrik 3 (2 puños + 2 por fuerza - 1 por agilidad de Arthas) 
	"
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateOrcosVsArthas.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 4.
	
	self assertElResultadoIndicaQueGanoElBando1: resultado alcanzadaLaRonda: 4.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'EP 9/18/2022 22:44:49'!
test10AlDesarrollarUnCombateLosDelBando2PuedenAtacarACualquieraDelBando1
	
	| orquestadorDeCombates |
	orquestadorDeCombates := self orquestadorParaCombateOrcosVsArthasConFocoEnElMasSano.
	
	orquestadorDeCombates desarrollarDuranteRondas: 2.
	
	Assert isTrue: self combatienteOrcoOlgra estaHerido. 
	Assert isTrue: self combatienteOrcoMankrik estaHerido. ! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'EP 9/18/2022 22:44:39'!
test11AlDesarrollarUnCombateAtacanTodesLosDelBando2EnCadaRonda
	"
		En cada ronda Olgra daña a Arthas en 2  (2 puños + 1 por fuerza - 1 por agilidad de Arthas) y  Mankrik 3 (2 puños + 2 por fuerza - 1 por agilidad de Arthas) 
	"
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasVsOrcos.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 4.
	
	self assertElResultadoIndicaQueGanoElBando2: resultado alcanzadaLaRonda: 4.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'EP 9/18/2022 22:43:41'!
test12AlDesarrollarUnCombateLosDelBando1NoGananSiTodosLosDelBando2NoEstanFueraDeCombate
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateArthasInmuneYFocoEnElMasHeridoVsOrcos.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 10.
	
	self assertElResultadoIndicaQueNoHayGanador: resultado alcanzadaLaRonda: 10.! !

!OrquestadorDeCombatesTest class methodsFor: 'tests - muches vs muches' stamp: 'EP 9/18/2022 22:43:34'!
test13AlDesarrollarUnCombateLosDelBando2NoGananSiTodosLosDelBando1NoEstanFueraDeCombate
	
	| orquestadorDeCombates resultado |
	orquestadorDeCombates := self orquestadorParaCombateOrcosVsArthasInmuneYFocoEnElMasHerido.
	
	resultado := orquestadorDeCombates desarrollarDuranteRondas: 10.
	
	self assertElResultadoIndicaQueNoHayGanador: resultado alcanzadaLaRonda: 10.! !

Bando1 initializeAfterFileIn!
Bando2 initializeAfterFileIn!
CombatienteOrcoMankrik initializeAfterFileIn!
CombatienteHumanoArthas initializeAfterFileIn!
CombatienteOrcoOlgra initializeAfterFileIn!
CombatientesTest initialize!
OrquestadorDeCombate initializeAfterFileIn!