<h1 align="center">Análisis técnico</h1>

## 1. Análisis Técnico
El **Reddit Bot Analyzer** se diseña bajo una arquitectura modular orientada a servicios, priorizaremos la asincronía y la escalabilidad debido a restricciones de tiempo en la extracción de datos externos.
- **Patrón de arquitectura:** Cliente-Servidor con procesamiento en segundo plano (Background Workers). El Frontend y el Backend están completamente desacoplados.
- **Flujo de Ejecución:** Dado que la API de Reddit (PRAW) tiene límites de peticiones y la descarga toma tiempo, el Backend utiliza enfoque asíncrono. La petición del usuario desencadena un proceso en segundo plano (Celery), permitiendo que la interfaz web siga respondiendo sin bloquearse.
- **Estrategia de Datos:** Se optó por base de datos NoSQL (MongoDB) por su naturaleza orientada a documentos, lo que permite almacenar las JSON crudas de la API de Reddit sin necesidad de mapeos relacionales o migraciones constantes.
- **Modelo de Machine Learning:** Se utilizará enfoque de aprendizaje no supervisado (Detección de Anomalías), ya que no contamos con dataset inmenso de bots previamente etiquetados. El sistema buscará perfiles (vectores de características) que se desvíen estadísticamente del comportamiento de un humano promedio en el subreddit.

## 2. Librerías y Herramientas
El ecosistema esta basado enteramento **Python**.
### Frontend
- **Streamlit:** Framework para la creación rápida del dashboard interactivo y visualización de gráficos sin HTML/JS.
### Backend y Orquestación
- **FastAPI:** Framework web asíncrono y de alto rendimiento para construir la API REST.
- **Uvicorn:** Servidor ASGI para ejecutar FastAPI.
- **Celery:** Gestor de colas de tareas distribuidas para manejar la extracción de Reddit en segundo plano.
- **Redis:** Actuará como Broker de mensajes para Celery.
### Extracción y Procesamiento de Datos
- **PRAW:** Biblioteca oficial para interactuar con la API de Reddit de forma segura y manejando límites de peticiones.
- **Pandas:** Para limpieza de datos y construcción de la matriz de características.
- **NLTK/Spacy:** Procesamiento de Lenguaje Natural para medir entropía, similitud y longitud de textos en comentarios.
### Machine Learning y Almacenamiento
- **Scikit-Learn:** Para entrenamiento y ejecución del modelo de detección de anomalías.
- **PyMongo:** Driver de Python para conectar la API con la base de datos MongoDB.

## 3. Estructura de Archivos del Proyecto
La estructura separa las responsabilidades. Mantiene el codigo de la web separado del codigo del servidor y del modelo matemático.
```txt
reddit_bot_analyzer/
├── frontend/                   # Contenedor 1: Aplicación Web
│   ├── app.py                  # Archivo principal de Streamlit (Dashboard)
│   └── environment_front.yml
│
├── backend/                    # Contenedor 2: API, Extracción y ML
│   ├── api/
│   │   ├── main.py             # Punto de entrada de FastAPI
│   │   └── routes.py           # Rutas
│   │
│   ├── scraper/
│   │   └── reddit_client.py    # Lógica de conexión y descarga con PRAW
│   │
│   ├── ml/
│   │   ├── feature_eng.py      # Pandas/NLTK: Convierte texto a números
│   │   └── model_predict.py    # Carga Scikit-Learn y hace la predicción
│   │
│   ├── db/
│   │   └── database.py         # Conexión a MongoDB con PyMongo
│   │
│   ├── core/
│   │   ├── config.py           # Variables de entorno y configuraciones
│   │   └── celery_worker.py    # Configuración de tareas en segundo plano
│   │
│   └── environment_back.yml
│
├── notebooks/                  # Carpeta para experimentación (Jupyter)
│   └── entrenamiento_ml.ipynb  # Pruebas del modelo antes de pasarlo al backend
│
├── .env                        # Credenciales (API Keys de Reddit, Passwords)
├── .gitignore
└── README.md
```