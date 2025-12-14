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



## CONFIGURAR LA BASE DE DATOS

La configuración de la base de datos es un punto crítico al inicio ya que afecta directamente como se almacenan, comparan y ordenan los datos, especialmente texto.

Aun que los parámetros exactos varían según el sistema de gestión de la base de datos (`MySQL`, `Oracle` y `Spark SQL`, etc.), los mas importantes y universales son `CHARACTER SET` y `COLLATE`.

 **MySQL (Universal)**

```sql
CREATE DATABASE MyDatabase
	[[DEFAULT] CHARACTER SET charset_name]
	[[DEFAULT] COLLATE collation_name];
```

**Oracle**

Oracle no existe como tal `CREATE DATABASE` como en *MySQL*, en su caso se usa `TABLESPACE` para definir un **contenedor de almacenamiento físico** donde se guardarán los datos (`mydata.dbf`). La Base de Datos Lógica (*Schema*) en Oracle es una colección de objetos pertenecientes a un usuario, y estos objetos se almacenan dentro de uno o mas `TABLESPACE`. El `TABLESPACE` es la unidad de asignación y gestión del espacio físico para los objetos de la base de datos.

La gestión de **Tablespaces** en Oracle y el concepto de *Database/Schema* en MySQL resuelven problemas relacionados con la organización y la gestión de recursos.

```sql
CREATE TABLESPACE MyTablespaceName
DATAFILE '01/oradata/DB_PROD/mydata.dbf'
SIZE 100M
AUTOEXTEND ON NEXT 10M
MAXSIZE 1G;
```

**Spark SQL**

*Spark SQL* no soporta `CHARACTER SET` u `COLLATE` directamente, en su lugar usa `UTF-8` por defecto y la configuración a nivel de sesión.

```sql
CREATE DATABASE MyDatabase
COMMENT 'Base de datos principal'
LOCATION 's3://my-bucket/MyDatabase';
```

