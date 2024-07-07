# MaxlandCineApp
## Proyecto para pruebas de programación en Swift y SwiftUI

Este proyecto consiste en un sencilla aplicación para crear registros de películas y series de televisión que hayamos visto, indicando su título, la fecha en que se vió, una puntuación mediante estrellas, una imagen de portada y un texto para realizar una crítica o explicación de lo que nos ha parecido.

La aplicación puede activar la autenticación biométrica, siempre que esté disponible, de este modo podemos proteger la lista de películas y series. 
También es posible exportar una copia de los datos mediante un archivo JSON que se puede importar también. Esto sirve como sistema de copia de seguridad o para intercambio de datos entre dos o más aplicaciones.

Los datos se guardan de forma local en el dispositivo mediante **CoreData**, además de utilizar **arquitectura MVVM** para su gestión.
**¡ATENCIÓN! A partir de la versión 1.7.9 se migrarán los datos de CoreData a SwiftData que se convertirá en el sistema de almacenamiento por defecto a partir de esa versión.**

Enlace para descarga en AppStore:
[Pulsa aquí](https://apps.apple.com/es/app/maxland-cine/id1625050643?l=es)
