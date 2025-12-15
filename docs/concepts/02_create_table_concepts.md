## CREATE TABLE

La sentencia `CREATE TABLE` es el cimiento de cualquier arquitectura de datos. En un pipeline ETL (*Extraer*, *Transformar* y  *Cargar*) o ELT (*Extraer*, *Cargar* y *Transformar*), la tabla es el **destino final** donde residen los datos limpios y listos para el consumo.

Su rol es definir el **esquema (Schema-on-write)**: usted decide de antemano la estructura (columnas y tipos de datos) que deben tener los datos. En arquitecturas modernas, `CREATE TABLE` se utiliza para:

1. **Tablas de Staging:** Almacenar datos brutos recién extraídos en la limpieza.
2. **Tablas Dimensionales:** Crear la estructura final del *Data Warehouse*.
3. **Tablas de Resultados:** Guardar los resultados de modelos o análisis avanzados (por ejemplo, en Spark).

## Definición

`CREATE TABLE` es una sentencia DDL (*Data Definition Language*) que se usa para **definir y nombrar una nueva tabla** dentro de una Base de Datos o Esquema. Su objetivo principal es especificar la **estructura de una tabla**:

1. El nombre de cada columna.
2. El tipo de dato que se almacenará cada columna (`VARCHAR` para texto, `INT` para números enteros o `DATE` para fechas).
3. Las restricciones de los datos (`PRIMARY KEY` para identificar filas únicas, `NOT NULL` para requerir un valor).

El concepto core es la **estructuración de datos**. Es igual que crear una plantilla de una hoja de calculo gigante: el usuario define exactamente cuantas columnas habrán y que tipo de información irá en cada columna.

**MySQL**

```sql
CREATE TABLE clients (
    client_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    registration_date DATE,
    monthly_volume DECIMAL(10, 2)
);
```

**Oracle**

```sql
-- se necesita especificar el Tablespace para almacenar
CREATE TABLE USER_DEV.clients (
    client_id NUMBER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    registration_date DATE,
    monthly_volume NUMBER(10, 2)
)
TABLESPACE USERS;
```

**Spark SQL**

```sql
-- 1.- seleccionar la base de datos
USE temp_analysis_data;

-- 2.- definir la estructura
CREATE TABLE clients (
    client_id INT,
    name STRING,
    registration_date DATE,
    monthly_volume DECIMAL(10, 2)
)
USING PARQUET
PARTITIONED BY (resgistration_date);
```

## Conceptos

`TABLESPACE` es similar a un contenedor físico que el DBA crea y administra. Una Base de Datos Oracle es como un edificio, y los Tablespaces **son los diferentes tipos de almacenamientos** dentro del edificio.

`PARTITIONED BY` es una forma de organizar los archivos físicos de la tabla en carpetas separadas. Hace que las consultas sean **mucho mas baratas y rápidas** en la nube.

`PRIMARY KEY` la clave primaria es una columna (o un grupo de columnas) que garantiza que cada fila en la tabla **sea única** y se pueda **identificar fácilmente**.

## Integración en Data Engineering

`CREATE TABLE` es el paso inicial dentro de un pipeline:

- **Airflow:** Los DAGs de Airflow (el orquestador) a menudo contiene tareas que ejecutan sentencias `CREATE TABLE IF NOT EXISTS` para preparar las tablas de staging antes de iniciar un proceso de carga.
- **dbt (Data Build Tool):**  dbt abstrae `CREATE TABLE` utilizando comandos como `dbt run` en sus modelos.
- **Python/Pandas:** Es común que en un script Python extraiga datos, use Pandas para limpiarlos y luego utilice la librería como `SQLAlchemy` o un conector de Spark para ejecutar la sentencia `CREATE TABLE` en el destino antes de cargar la data procesada.

**Ejemplo de Arquitectura Simple:**

1. Origen: Archivo CSV en S3.
2. **Procesamiento:** Script de Python/Spark lee el CSV.
3. **Destino (Data Lakehouse):** El script ejecuta `CREATE TABLE ... USING PARQUET` en Spark SQL.
4. **Transformación (Data Warehouse):** Un modelo de **dbt** lee desde la tabla de Spark y escribe el resultado en una tabla final en Oracle o MySQL. 