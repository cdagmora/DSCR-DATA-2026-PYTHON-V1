<h1 align="center">Análisis teórico</h1>

Link para editar este documento: [https://typst.app/project/wadZLqZ2Wyx9vA0W1AVCmk](https://typst.app/project/wadZLqZ2Wyx9vA0W1AVCmk)

## 1. Alcances del proyecto
- **Alcance funcional:** La aplicación web recibirá el nombre de un subreddit. Extraerá una muestra representativa de las publicaciones recientes (por ejemplo, últimos 500 posts o últimos 7 días).
- **Procesamiento:** Analizará a los usuarios que interactúan en ese hilo o subreddit usando un modelo de clasificación previamente entrenado.
- **Salida:** Mostrará un dashboard o panel de resultados con el porcentaje estimado de interacciones automatizadas y lista de usuarios más sospechosos, además de gráficos de su comportamiento.
- **Limitaciones:** El sistema estará limitado por las restricciones de la API de Reddit. Analizará por lotes a petición del usuario.

## 2. ¿Qué información buscamos obtener?
- **Metadatos de la cuenta:** Fecha de creación, ratio de karma, avatar genérico, correo verificado.
- **Comportamiento temporal:** Frecuencia de publicación, tiempo de respuesta.
- **Patrones de actividad:** En qué otros subreddits participa. (Evitar subreddits de karma gratis) o saltar entre comunidades sin relación lógica.
- **Análisis de contenido:** Longitud promedio de comentarios, similitud de textos, uso excesivo de enlaces externos, análisis de feeling.

## 3. ¿De qué redes buscamos obtener información?
- **Principal:** Reddit. La extracción puede hacerse mediante la API de Reddit usando la biblioteca PRAW o en caso extremo scrapping.
- **Secundario:** Se podrían cruzar los enlaces compartidos por sospechosos con bases de datos como VirusTotal o listas negras de phishing.

## 4. ¿Qué debería predecir a partir de los datos recopilados?
- **Probabilidad individual:** Un puntaje que indique probabilidad de que un usuario sea un bot.
- **Probabilidad global:** Porcentaje de "salud" de un subreddit o hilo analizado.
- ~~**Clasificación de tipo de bot:** Predecir si el bot es de spam, político, granjero de karma, etc.~~

## 5. ¿Cómo podemos usar los datos para construir un perfil?
- **Creación de vectores de características:** Cada usuario se convierte en una fila de datos numéricos. Ejemplo: `[edad_cuenta_dias, posts_por_dia, varianza_tiempo_entre_posts, entropia_de_vocabulario, ratio_karma_comentarios]`.
- **Detección de anomalías:** Se construirá un perfil base de humano promedio. Todo perfil vectorial que se desvíe radicalmente de esta norma o que sea idéntico a otras cuentas, será etiquetado como bot.
