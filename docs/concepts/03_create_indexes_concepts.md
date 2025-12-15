

## Index

Un **Índice (Index)** es una estructura de datos especial, ligada a una tabla, que está diseñada para acelerar la búsqueda y recuperación de datos.

El **concepto core** es la **optimizacion de la busqueda**. Cuando de hace una consulta a una tabla, el motor de la base de datos generalmente tiene que leer todas las filas (a esto se le conoce como *Full Table Scan*). Un índice le dice al motor exactamente donde están los datos que busca, permitiéndole ir directamente a esa ubicación, como si fuera un acceso directo.

**Analogía Simple:** Una tabla sin índice es como una guía telefónica sin orden alfabético: para encontrar el número de "Juan Pérez", se tendría que leer todas las páginas de principio a fin. Un índice es la guía **ordenada alfabéticamente**. Si se necesita el número de Juan, va directamente a la letra J, y encuentra la fila al instante.

**Casos de Uso:**

| **Problema**                      | **Caso**                                                     | **Uso**                                                      |
| --------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Aceleración de JOINs**          | Cuando se consolida el *Data Warehouse*, si se unen la tabla de `Ventas` (50 millones de filas) con la tabla `Productos` (10,000 filas) por el `product_id`. | Coloque índices en las **columnas clave de unión** (`JOIN key`) en la tabla más pequeña (la de `Productos`). |
| **Eficiencia de Carga (UPDATEs)** | En un *pipeline* ETL que necesita actualizar el estado de miles de pedidos en una tabla de `Pedidos` (OLTP). | Cree un índice en la columna de búsqueda (`order_id`) para que el motor encuentre el registro a actualizar al instante, evitando un escaneo completo. |
| **Optimización de Filtros**       | Cuando los analistas filtran datos repetidamente por un campo específico (ej. `WHERE country = 'Mexico'`). | Coloque un índice en la columna `country` para acelerar todas las consultas que utilicen ese filtro. |

**MySQL**

```sql
-- 1.- crear la tabla
CREATE TABLE web_transactions (
    transaction_id INT PRIMARY KEY,
    client_email VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2)
);

-- 2.- crear el index
CREATE INDEX idx_email
ON web_transactions (client_email);
```

**Oracle**

```sql
-- casi identico a MySQL pero el index se almacena en el Tablespace
CREATE INDEX idx_email
ON web_transactions (client_email)
TABLESPACE USERS;
```

Spark SQL

```sql
-- la búsqueda no se acelera con indices, si no con la organización de los datos.
USE data_lakehouse;
CREATE TABLE web_transactions (
    transaction_id INT,
    client_email STRING,
    amount DECIMAL(10, 2)
)
USING PARQUET
-- la optimización se hace aquí, dividiendo los datos por fecha.
PARTITIONED BY (transaction_date)
-- opcional: ordenar los datos dentro de cada archivo Parquet
CLUSTERED BY (client_email) INTO 10 BUCKETS;
```

