## CREATE

El comando `CREATE` es parte del lenguaje de definición de datos (DDL - Data Definition Language) en SQL. Se utiliza para ***construir***, ***definir*** e ***inicializar*** objetos dentro de una base de datos.

```sql
CREATE database_name;
```

El comando `CREATE` se utiliza para crear los objetos fundamentales de una base de datos. Los usos mas comunes son:

| Objeto           | Descripción                                                  | Ejemplo                                                      |
| ---------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| CREATE DATABASE  | Crea una ***base de datos*** con el nombre especificado.     | `CREATE DATABASE MyDatabase;`                                |
| CREATE TABLE     | Crea una ***nueva tabla*** en la base de datos para almacenar datos. Quizá el uso mas frecuente. | `CREATE TABLE Users (ID INT, name VARCHAR(50));`             |
| CREATE VIEW      | Crea una ***vista***, que es una tabla virtual basada en el resultado de una consulta SQL. | `CREATE VIEW ActiveUsersView AS SELECT * FROM Users WHERE State = 'Active';` |
| CREATE INDEX     | Crea un ***índice*** en una tabla para acelerar la recuperación o la extracción de filas. Muy utilizado en bases de datos masivos. | `CREATE INDEX idx_name ON Users (name);`                     |
| CREATE PROCEDURE | Crea un ***procedimiento*** almacenado; un conjunto de sentencias SQL que se pueden ejecutar como una sola unidad. | `CREATE PROCEDURE GetUsers AS SELECT * FROM Users;`          |
| CREATE FUNCTION  | Crea una ***función*** definida por el usuario que devuelve un valor escalar o una tabla. | `CREATE FUNCTION CalculateUserAge (...) RETURNS INT ....;`   |
| CREATE TRIGGER   | Crea un disparador, que es un objeto que se ejecuta automáticamente en respuesta a eventos (tales como `INSERT`, `UPDATE` o `DELETE`) de una tabla especifica. | `CREATE TRIGGER UpdateUserStatus ....;`                      |



## CREAR UNA BASE DE DATOS

La sentencia `CREATE DATABASE` o su equivalente `CREATE SCHEMA` es un comando fundamental del lenguaje de definición de datos (**DDL**) en SQL. Su propósito central es crear un ***contenedor lógico*** dentro del sistema de gestión de datos. Este contenedor, a menudo llamado **Base de Datos Lógica** o **Schema**, funciona como un espacio de nombres para organizar y agrupar objetos relacionados como *tablas*, *vistas*, *funciones* y *procedimientos*.

**Diferencia Principal**

La diferencia critica no radica en la función lógica o la creación del propio contenedor, si no en la naturaleza física y su arquitectura que ese contenedor representa:

- **MySQL:** `CREATE DATABASE` crea una **Base de Datos Lógica** que el sistema asocia fuertemente con una ubicación de almacenamiento. Es un concepto simple de *contenedor de objetos* y *almacenamiento local*.
- **Oracle:** La Base de Datos Lógica que contiene objetos se llama **Schema** y siempre está vinculada a un **Usuario** (quien es el dueño de los objetos). El comando `CREATE DATABASE` se usa para **crear el servidor completo de Oracle** (la instancia), un proceso de alto nivel que rara vez hace un usuario común.
- **Spark SQL:** `CREATE DATABASE` crea solo un **registro de metadatos** en el catalogo de datos (Metastore). Esto significa que crea el nombre de la carpeta lógica, pero **no contiene los datos físicamente**; simplemente apunta a una ubicación de archivos Parquet u ORC en un sistema de archivos distribuidos (como S3 o HDFS). Es un concepto de **contenedor de metadatos**.

 **MySQL (Universal)**

```sql
CREATE DATABASE MyDatabase
	[[DEFAULT] CHARACTER SET charset_name]
	[[DEFAULT] COLLATE collation_name];
```

**Oracle**

```sql
-- 1.- Crea el usuario que será el esquema o contenedor
CREATE USER DATABASE_DEV IDENTIFIED BY "password123";
-- 2.- Dar permisos
GRANT CREATE SESSION, CREATE TABLE TO DATABASE_DEV;
```

**Spark SQL**

```sql
CREATE DATABASE IF NOT EXISTS MyDatabase
COMMENT 'Base de datos principal'
LOCATION 's3://my-datalake/MyDatabase';
```

