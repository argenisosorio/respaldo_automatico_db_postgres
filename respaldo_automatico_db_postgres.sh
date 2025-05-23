#!/bin/bash
#
# Script para respaldo automático de bases de datos PostgreSQL
#
# Genera archivos con formato: [nombre_bd]_[fecha]_[hora].sql en el directorio
# backups_postgresql que se crea la misma ruta donde se encuentra el script.
#
# Ejemplo de respaldo creado: nombredb_20250522_193510.sql
#
# Desglose del nombre y timestamp:
# nombredb (Nombre de la base de datos)
# 2025 (Año	2025)
# 05 (Mes 5 Mayo)
# 22 (Día 22)
# 193510 (Hora militar 19:35:10)
#
# Autor: Ing. Argenis Osorio
#
# Fecha de creación: 22/05/25
#
# Última actualización: 22/05/25

# Configuración de la BD (Modificar estos valores).
DB_NAME="nombre_base_de_datos" # Nombre de la BD a respaldar.
DB_OWNER="usuario_propietario" # Dueño de la BD.
DB_PASSWORD="contraseña" # Contraseña de la BD.

# Directorio de respaldo (Se creará en la misma ruta del script).
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="${SCRIPT_DIR}/backups_postgres"
mkdir -p "$BACKUP_DIR"

# Generar nombre del archivo con fecha y hora actuales.
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${DB_NAME}_${TIMESTAMP}.sql"
FULL_PATH="$BACKUP_DIR/$BACKUP_FILE"

# Realizar el respaldo de la BD.
export PGPASSWORD="$DB_PASSWORD"
echo "Respaldando la base de datos '$DB_NAME'..."
pg_dump -U "$DB_OWNER" -h 127.0.0.1 --no-owner --no-acl "$DB_NAME" > "$FULL_PATH"
unset PGPASSWORD

# Verificación de éxito.
if [ $? -eq 0 ]; then
    echo "┌─────────────────────────────────────────────────────"
    echo "│  ✔ Respaldo exitoso"
    echo "│  Ubicación: $FULL_PATH"
    echo "│  Tamaño aproximado: $(du -h "$FULL_PATH" | cut -f1)"
    echo "└─────────────────────────────────────────────────────"
else
    echo "┌─────────────────────────────────────────────────────"
    echo "│  ✖ Error al realizar el respaldo"
    echo "└─────────────────────────────────────────────────────"
    exit 1
fi
