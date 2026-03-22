# DSCR-DATA-2026-PYTHON-V1
Objetive: Tool focused on collecting and analyzing a person's digital footprint based on public information.
State: Work in progress

## 🗺️ Roadmap del Proyecto

El desarrollo de **Reddit Bot Analyzer** está estructurado en 4 fases principales para asegurar una integración progresiva desde la extracción de datos hasta la visualización final.

| Fase | Duración Estimada | Objetivo Principal | Hitos / Tareas Clave | Estado |
| :--- | :--- | :--- | :--- | :---: |
| **1. Fundamentos y Extracción** | Semanas 1-2 | Conectar el sistema con Reddit y obtener datos crudos. | <ul><li>Script de extracción usando **PRAW** (últimos 500 posts).</li><li>Creación del esqueleto de la API con **FastAPI**.</li></ul> | 🔄 En progreso |
| **2. Motor de Data Science** | Semanas 3-4 | Convertir texto en métricas y detectar anomalías. | <ul><li>Ingeniería de características con **Pandas** y **NLTK** (entropía, promedios).</li><li>Entrenamiento del modelo base con **Scikit-Learn**.</li><li>Integración del modelo en la API para predicciones.</li></ul> | ⏳ Pendiente |
| **3. Interfaz Visual (Dashboard)**| Semanas 5-6 | Construir la plataforma amigable para el usuario final. | <ul><li>Desarrollo de la interfaz gráfica con **Streamlit**.</li><li>Conexión entre el Dashboard y la API principal.</li><li>Visualización de gráficos (porcentaje de salud, sospechosos).</li></ul> | ⏳ Pendiente |
| **4. Optimización y Almacenaje**| Semana 7+ | Mejorar el rendimiento y guardar resultados históricos. | <ul><li>Integración de **MongoDB** para guardar predicciones.</li><li>Implementación de **Celery** para procesos en segundo plano.</li><li>Pruebas finales y despliegue del sistema.</li></ul> | ⏳ Pendiente |