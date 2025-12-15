## Claves Foráneas

Una **Clave Foránea (Foreign Key o FK)** es una columna (o un conjunto de columnas) en una tabla, llamada **Tabla Hija**, que hace referencia a la Clave Primaria (`PRIMARY KEY`) de otra tabla, llamada **Tabla Padre**.

Una Clave Foránea fuerza una regla estricta: *solo se pueden insertar o modificar un valor en la tabla Hija si ese valor ya existe en la Clave Primaria de la Tabla Padre*.

Diferencias Principales entre Sistemas:

- **MySQL / Oracle (RDBMS):** La `FOREIGN KEY` es una restricción activa impuesta por el motor. Cada vez que se inserta o se actualiza una fila, el motor revisa la Tabla Padre en tiempo real. Si la regla se rompe, la transacción falla. Esto garantiza la integridad al 100%.
- **Spark SQL (Computación Distribuida):** Spark SQL permite la sintaxis `FOREIGN KEY`, pero **NO aplica la restricción**. La `FOREIGN KEY` se guarda únicamente como metadatos en el Catálogo de Datos. Esto es asi para que herramientas de *downstream* como **dbt** y herramientas **BI** sepan que existe una relación, pero **no detiene las inserciones de datos inconsistentes**. La validación debe hacerse explícitamente en el pipeline de datos.

**MySQL**

```sql
CREATE TABLE Order_Detail (
    detail_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    quantity INT,
    
    -- crear la foreign key
    CONSTRAINT fk_order
    FOREIGN KEY (order_id)
    REFERENCES Orders (order_id)
);
```

**Oracle**

```sql
CREATE TABLE Order_Detail (
    detail_id NUMBER PRIMARY KEY,
    order_id NUMBER NOT NULL,
    quantity NUMBER,
    
    -- crear la foreign key
    CONSTRAINT fk_order
    FOREIGN KEY (order_id)
    REFERENCES Orders (order_id)
);
```

