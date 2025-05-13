# Cómo correr el programa

Este proyecto utiliza **Docker** y **Docker Compose** para facilitar la configuración del entorno, incluyendo la base de datos PostgreSQL y PgAdmin para la administración visual.

---

## Requisitos previos

- Tener **Docker** y **Docker Compose** instalados en tu máquina.

---

## Instrucciones para ejecutar el proyecto

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/Ninaswiftie09/Proyecto3_BD
   cd <Proyecto3_BD>

2. **Levantar contenedores**

    docker-compose up --build

3. **Verificar que los servicios estén corriendo**
    PgAdmin estará disponible en tu navegador en: http://localhost:5050
    Interfaz gráfica al abrir el index.html dentro de la carpeta de frontend

## Credenciales de acceso
    PgAdmin:  
        Correo: admin@admin.com

        Contraseña: admin

**Base de datos PostgreSQL:**
    Nombre de la base de datos: proyecto

    Usuario: postgres

    Contraseña: pass

    Host: db 

    Puerto: 5432

