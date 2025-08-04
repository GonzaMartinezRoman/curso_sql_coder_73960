## 7. Importación y Gestión de Datos

### 🧪 Actividad práctica: Presentación de Script de Creación de Vistas

#### 📌 Consigna

Crea **5 vistas** con base en los datos de la base de datos del proyecto final.

#### ✅ Aspectos a incluir

- En base a las **tablas elegidas** para tu proyecto, deberás idear **5 o más vistas** de una o más tablas.
- Genera el **script SQL** de creación de dichas vistas.

#### 💡 Ejemplo

Si tu proyecto tiene una tabla `productos`, puedes:

- Crear una vista que relacione `productos` con la tabla `categorías`.
- Mostrar el costo de cada producto, incluyendo valores de IVA (TAX).
- Representar diferentes tipos de datos calculados.

---

### 🧪 Actividad práctica: Script de Creación de Funciones Almacenadas

#### 📌 Consigna

Presentar el **script de creación de 2 funciones almacenadas**, con base en los datos del proyecto final.

#### ✅ Indicaciones

- Incluye **una función que utilice funciones propias de SQL** internamente.
- La segunda función debe obtener datos de **otras tablas**:
  - Puedes usarla como alternativa a un `JOIN` o una subconsulta.

#### 🧠 Requisitos

- Cada función debe recibir **al menos un parámetro de entrada**.
- Las funciones pueden retornar **cualquier tipo de dato**.

---

### 🧪 Actividad práctica: Script de Creación de Stored Procedures

#### 📌 Consigna

Crea **2 Stored Procedures** basados en las tablas del proyecto final.

#### ✅ Stored Procedure 1

- Permite ordenar una tabla según:
  - Un **campo de ordenamiento** (pasado como parámetro).
  - Un segundo parámetro indica si el orden es **ascendente** o **descendente**.

#### ✅ Stored Procedure 2

Este procedimiento puede realizar una de las siguientes acciones:

1. **Insertar registros** en una tabla del proyecto.
2. **Eliminar un registro específico** de una tabla del proyecto.

#### 📝 Recomendaciones

- Agrega **comentarios** explicativos en ambos scripts para aclarar:
  - Qué hace cada procedimiento.
  - Cómo se usa.
- Inspírate en los **ejemplos vistos en clase**.
