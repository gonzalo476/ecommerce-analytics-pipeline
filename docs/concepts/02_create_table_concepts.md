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