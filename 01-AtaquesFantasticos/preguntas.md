## Preguntas
aa
1. ¿Qué crítica le harías al protocolo de #estaHerido y #noEstaHerido? (en vez de tener solo el mensaje #estaHerido y hacer “#estaHerido not” para saber la negación)

Si bien tener #estaHerido y #noEstaHerido puede ayudar a la legibilidad del código, creemos que no sería incorrecto simplificarlo en un solo mensaje y utilizar la negación "not". Una ventaja de esta alternativa sería reducir el número de métodos de los combatientes, ayudando a la legibilididad.

2. ¿Qué opinan de que para algunas funcionalidades tenemos 3 tests para el mismo comportamiento pero aplicando a cada uno de los combatientes (Arthas, Mankrik y Olgra)

Debido a el formato con el que trabajamos, creemos que esto es correcto porque se asegura que todos los combatientes tienen el mismo comportamiento, que es lo esperado. Si por el contrario fuesen todos instancias de una clase por ejemplo, esto seria redundante. Además son útiles en caso de que desconozcamos como están implementadas las funcionalidades.
 
3. ¿Cómo modelaron el resultado de haber desarrollado un combate? ¿qué opciones consideraron y por qué se quedaron con la que entregaron y por qué descartaron a las otras?
 
El primer modelado que se nos ocurrió pareció ser suficiente, así que no exploramos otras alternativas. Decidimos modelar un orquestador, que guarda los bandos y hace que los combatientes en estos se ataquen por cada ronda que se desarrolla.  Transcurrido esto, se pregunta a cada bando si tiene a todos sus combatientes noqueados y decide un ganador en base a esto, que también guarda y chequeamos que la cantidad de rondas transcurridas, previamente guardadas en un colaborador interno, sea la correcta.
