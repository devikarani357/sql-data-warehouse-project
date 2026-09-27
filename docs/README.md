# SQL Data Warehouse Project

## Overview

This project demonstrates the design and implementation of a modern SQL Data Warehouse using a layered architecture and Star Schema data model.

The project integrates data from CRM and ERP source systems, transforms and cleans the data through multiple warehouse layers, and prepares business-ready datasets for analytics and reporting.

The implementation focuses on SQL-based ETL, data integration, data quality, dimensional modeling, and analytical reporting.

---

## Project Objectives

The main objectives of this project are to:

- Build a complete SQL Data Warehouse from raw source data.
- Integrate CRM and ERP datasets.
- Implement Bronze, Silver, and Gold data layers.
- Perform data cleansing and standardization using SQL.
- Handle duplicate and invalid records.
- Implement dimensional modeling using a Star Schema.
- Create customer and product dimensions.
- Create a sales fact table.
- Build analytical SQL views.
- Perform data quality testing.
- Create reusable SQL analytics queries.

---

# Data Warehouse Architecture

The project follows a three-layer architecture:


                    SOURCE SYSTEMS
                ┌─────────────────────┐
                │     CRM Sources     │
                │     ERP Sources     │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │    BRONZE LAYER     │
                │                     │
                │     Raw Data        │
                │  Minimal Transform  │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │    SILVER LAYER     │
                │                     │
                │ Clean + Standardize │
                │ Validate + Transform│
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │     GOLD LAYER      │
                │                     │
                │   Star Schema       │
                │ Dimensions + Fact   │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │      ANALYTICS      │
                │                     │
                │ Customer / Product  │
                │ Sales Analysis      │
                └─────────────────────┘
