# Script para respaldo automático de bases de datos PostgreSQL

<h3> Genera archivos con formato: [nombre_bd]_[fecha]_[hora].sql en el directorio backups_postgresql
que se crea la misma ruta donde se encuentra el script.</h3>

Ejemplo de respaldo creado: nombredb_20250522_193510.sql

-Desglose del nombre y timestamp:

-nombredb (Nombre de la base de datos)

-2025 (Año 2025)

-05 (Mes 5 Mayo)

-22 (Día 22)

-193510 (Hora militar 19:35:10)

-----

Diseñado para facilitar el respaldo de una BD de PostgreSQL.

-----

Para ejecutar el script, use el siguiente comando:

```
$ bash respaldo_automatico_db_postgres.sh
```
