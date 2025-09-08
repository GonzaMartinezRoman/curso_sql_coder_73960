# Suminet ERP - Sistema de Gestión de Materiales e Inventario

Este repositorio contiene el proyecto **Suminet ERP**, desarrollado como trabajo final del curso de SQL, comisión 73690, de Coderhouse.  
Se trata de una solución ficticia que emula el **núcleo de un sistema ERP** enfocado en la **gestión de abastecimiento** de una pyme industrial, con inspiración en los sistemas utilizados en sectores como **Oil & Gas, manufactura y logística**.

---

## 📌 Introducción

El objetivo del proyecto es diseñar e implementar una **base de datos relacional normalizada** que represente de manera simplificada, pero realista, los procesos clave de abastecimiento.  
La propuesta busca integrar en un mismo modelo el **catálogo maestro de materiales**, el **control de inventario**, la **gestión de proveedores** y las **operaciones de compra**, asegurando la trazabilidad y consistencia de los datos.

---

## 🎯 Objetivos del proyecto

- Modelar una **base de datos ERP** para materiales e inventario.  
- Representar los procesos de:
  - Catálogo maestro de materiales.  
  - Gestión de stock y movimientos de inventario.  
  - Administración de proveedores.  
  - Emisión y control de órdenes de compra.  
- Facilitar consultas SQL que soporten:
  - Reportes de inventario.  
  - Análisis de proveedores.  
  - Alertas de stock.  
  - Patrones de compra.  

---

## 🚩 Situación problemática

En muchas empresas industriales, la gestión de materiales se ve afectada por:
- **Duplicación de datos** en catálogos no unificados.  
- **Errores de compra** por información incompleta o inconsistente.  
- **Falta de trazabilidad** en inventarios y proveedores.  
- **Costos ocultos** por sobrestock, faltantes o stock inmovilizado.  

**Suminet ERP** busca resolver estas brechas mediante una **única fuente de verdad** para la gestión de materiales, inventarios y compras.

---

## 🏭 Modelo de negocio

La empresa ficticia **Suminet S.A.** opera como proveedor integral de servicios logísticos e industriales para el sector energético.  
Su operación depende de un sistema que le permita:

- Mantener un **catálogo centralizado de materiales**.  
- Registrar la **ubicación y cantidad de stock** en distintos almacenes.  
- Monitorear en tiempo real los **movimientos de inventario**.  
- Administrar un **padrón de proveedores** con certificaciones y auditorías.  
- Emitir y controlar **órdenes de compra** a proveedores externos.  

---

## 🧩 Módulos principales

El proyecto se estructura en **cuatro módulos**:

1. **Catálogo Maestro de Materiales**  
   - Normalización de ítems, categorías y unidades.  

2. **Inventario**  
   - Registro de stock, ubicaciones y movimientos.  

3. **Catálogo Maestro de Proveedores**  
   - Información de proveedores, certificaciones, auditorías y desempeño.  

4. **Compras**  
   - Órdenes de compra, estados y detalles de materiales adquiridos.  

---

## 📊 Funcionalidades destacadas

- **Vistas SQL** para reportes consolidados de materiales, inventarios y compras.  
- **Funciones** para cálculos automáticos de stock y rotación de materiales.  
- **Stored Procedures** que estandarizan la carga de datos maestros.  
- **Triggers** que registran cambios de inventario para auditoría.  

---

## 🛠️ Herramientas utilizadas

- **MySQL Workbench** → modelado y desarrollo de la base de datos.  
- **Microsoft Excel** → visualización y análisis de información.  

---

## 📂 Estructura del repositorio

- `/02_Datos` → scripts de inserción de datos.  
- `/03_Funcionalidades` → vistas, funciones, procedimientos y triggers.  
- Documentación complementaria del proyecto.  

---

## 🚀 Propósito

Este proyecto no es un ERP operativo, sino una **demostración académica y práctica** de cómo estructurar un sistema de gestión de abastecimiento con buenas prácticas de **modelado relacional**, **integridad referencial** y **normalización de datos**.

---
