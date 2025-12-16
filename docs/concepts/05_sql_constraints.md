## Constraints

Una **Constraint (Restrincción)** es una regla que se aplica a las columnas de una tabla para limitar el **tipo y el rango de datos** que pueden ser insertados. Su objetivo principal es asegurar la **Integridad y la Exactitud** de la información contenida en la base de datos.

Una tabla sin *Constraints* es como un formulario que acepta cualquier cosa. Las *Constraints* son como las reglas de ese formulario:

- `NOT NULL`: Este campo es obligatorio.
- `PRIMARY KEY`: Este número de identificación debe ser único y obligatorio.
- `FOREIGN KEY`: El código que uses aquí debe existir en la lista oficial de códigos.

| **Constraint**  | **Característica**                                           | **Uso**                                                      |
| --------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **PRIMARY KEY** | Asegura que cada fila de una tabla (ej. `dim_clientes`) tenga un identificador único y que nunca haya duplicados. | Clave para uniones (`JOINs`). Si la `PRIMARY KEY` es duplicada, los reportes mostrarán datos incorrectos. |
| **NOT NULL**    | Impide que los campos obligatorios (ej. `fecha_registro`) se queden vacíos o nulos, evitando errores en cálculos *downstream*. | En la tabla de *Staging* (área de aterrizaje), para forzar que el *pipeline* falle si los datos de origen no son completos. |
| **FOREIGN KEY** | Garantiza que las relaciones entre tablas sean válidas (ej. cada `ID_Pedido` en la tabla de `Detalles` debe existir en la tabla `Pedidos`). | Protege el **Data Warehouse** de datos huérfanos. Si la FK no se cumple, los reportes se rompen. |
| **UNIQUE**      | Asegura que una columna, que no es la clave primaria, también contenga solo valores únicos (ej. `email_cliente`). | Usado para evitar crear dos cuentas de usuario con el mismo correo electrónico. |

**MySQL**

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY, -- identificador único.
    email VARCHAR(100) NOT NULL UNIQUE, -- es obligatorio y debe ser único.
    name VARCHAR(100) NOT NULL,
    birth_date DATE NULL, -- no debe estar vacío.
    
    CONSTRAINT chk_age -- ejemplo de un check constraint
    CHECK (birth_date < CURDATE()) -- fecha de nacimiento debe ser menor a la fecha actual
);
```

**Oracle**

```sql
CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    email VARCHAR2(100) NOT NULL UNIQUE,
    name VARCHAR2(100) NOT NULL,
    birth_date DATE,
    
    CONSTRAINT chk_age
    CHECK (birth_date < SYSDATE) -- Oracle actively enforces CHECK constraints
);
```

Spark SQL

```sql
CREATE TABLE users (
    user_id INT NOT NULL PRIMARY KEY, -- el motor ignora el PRIMARY KEY
    email STRING NOT NULL, -- el motor no verifica si es NOT NULL
    name STRING NOT NULL,
    birth_date DATE 
)
USING PARQUET; -- la validacion se debe de realizar con PySpark o dbt
```

