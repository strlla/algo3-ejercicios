# Código Repetido

Este ejercicio tiene por objetivo que saquen el código repetido que encuentren en el modelo y en los tests. Por ej. entre el test01 y test02.

Los tests provistos ya funcionan, simplemente hay que sacar el código repetido y los tests deben seguir funcionando.

Se pueden modificar las clases provistas, sólo para eliminar código repetido. No se puede modificar lo que verifican los tests. O sea, sólo se puede hacer un cambio de diseño de tal manera que siga testeando lo mismo, que la funcionalidad sea la misma, pero que no haya código repetido.

Aclaración: Para hacer este ejercicio más sencillo se modela a un Customer utilizando un String en vez de una clase Customer. No es el objetivo del ejercicio que ustedes corrijan esta decisión, ni las consecuencias que trae consigo (por ej. que no se pueda agregar al CustomerBook dos Customers diferentes con el mismo nombre).


# Preguntas

## Abstracción de los tests 01 y 02 

En los test 01 y 02 hay código repetido. Cuando lo extrajeron crearon algo nuevo. Eso es algo que estaba en la realidad y no estaba representado en nuestro código, por eso teníamos código repetido. ¿Cuál es esa entidad de la realidad que crearon?

Creamos un ente de la realidad que se encarga de medir el tiempo de ejecución del registro y borrado de clientes y verifica si supera una cierta cantidad de tiempo. Un ejemplo sería un cronómetro. Para hacer esto dimos uso de los métodos que poseía SmallTalk para bloques de código.

## Cómo representar en Smalltalk

¿Cuáles son las formas en que podemos representar entes de la realidad en Smalltalk que conocés? Es decir, ¿qué cosas del lenguaje Smalltalk puedo usar para representar entidades de la realidad?

En Smalltalk, se pueden utilizar las clases para representar las ideas abstractas que conforman los objetos y las instancias para representar las entidades individuales y fisicas de estos con los que se interactúa en el día a día. A su vez, estos objetos tienen mensajes que definen su comportamiento.

## Teoría de Naur

¿Qué relación hay entre sacar código repetido (creando abstracciones) y la teoría del modelo/sistema (del paper de Naur)?

La teoría del modelo/sistema establece que los programas inevitablemente van a cambiarse a futuro por demanda del cliente. Debido a esto, se debe realizar el mayor esfuerzo posible para sacar todo código repetido, ya que este dificulta la capacidad del programa para ser cambiado. Además, deshacerse de el facilita la creación de modelos basados en la realidad.
