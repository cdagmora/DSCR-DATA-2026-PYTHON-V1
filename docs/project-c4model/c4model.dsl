workspace "OSINT R-Healty" "Analizador de Subreddits" {

    !identifiers hierarchical

    model {
        u = person "Analista / Usuario Final"
        
        se = softwareSystem "API de Reddit" {
            tags "reddit"
        }

        ss = softwareSystem "Reddit Bot Analyzer" {
            
            fro = container "Aplicación Web (Dashboard)" "Interfaz gráfica para solicitar análisis y ver resultados" "Streamlit"
            
            bd = container "Base de Datos" "Almacena análisis históricos y resultados temporales" "MongoDB" {
                tags "Database"
            }

            # Contenedor principal que aloja nuestros componentes (Nivel 3)
            back = container "Backend Application" "Orquesta peticiones, extrae datos y ejecuta predicciones" "FastAPI + Python" {
                
                apiRouter = component "API Router" "Recibe la petición web del subreddit a analizar" "FastAPI"
                taskManager = component "Gestor de Tareas" "Administra la cola de procesos en segundo plano" "Celery"
                redditExt = component "Servicio de Extracción" "Descarga posts, comentarios y metadatos" "PRAW"
                featEng = component "Ingeniería de Características" "Convierte datos crudos en vectores numéricos" "Pandas / NLTK"
                mlPred = component "Servicio de Predicción ML" "Aplica el modelo de detección de anomalías" "Scikit-Learn"
                dbRepo = component "Repositorio BD" "Gestiona la lectura y escritura de datos" "PyMongo"
            }
        }

        # --- RELACIONES ---
        
        # Nivel 1 y 2 (Usuario y Contenedores)
        u -> ss.fro "Introduce subreddit y ve resultados"
        ss.fro -> ss.back.apiRouter "Llama a la API para analizar" "JSON/REST"
        ss.back.apiRouter -> ss.fro "Devuelve respuesta final / ID de tarea"
        
        # Nivel 3 (Relaciones internas dentro del Backend)
        ss.back.apiRouter -> ss.back.taskManager "Encola la petición"
        ss.back.taskManager -> ss.back.redditExt "Inicia proceso de extracción"
        ss.back.redditExt -> se "Pide los datos a Reddit" "API externa"
        se -> ss.back.redditExt "Devuelve datos en crudo" "JSON"
        ss.back.redditExt -> ss.back.featEng "Pasa datos crudos"
        ss.back.featEng -> ss.back.mlPred "Envía datos vectorizados"
        ss.back.mlPred -> ss.back.dbRepo "Guarda registro de predicciones"
        ss.back.dbRepo -> ss.bd "Lee/Escribe en la base de datos" "TCP"
    }

    views {
        # Nivel 1: Diagrama de Contexto
        systemContext ss "Diagram1_Context" {
            include *
            autoLayout tb
        }

        # Nivel 2: Diagrama de Contenedores
        container ss "Diagram2_Containers" {
            include *
            autoLayout tb
        }

        # Nivel 3: Diagrama de Componentes (Haciendo zoom al Backend)
        component ss.back "Diagram3_Components" {
            include *
            autoLayout tb
        }

        styles {
            element "Element" {
                color #ffffff
                background #0773af
                stroke #055b8a
                strokeWidth 3
                shape roundedbox
            }
            element "Person" {
                background #10a40b
                color #ffffff
                shape person
            }
            element "Database" {
                shape cylinder
            }
            element "reddit" {
                background #ff4500
                color #ffffff
                stroke #8c0b04
            }
        }
    }

    configuration {
        scope softwaresystem
    }
}