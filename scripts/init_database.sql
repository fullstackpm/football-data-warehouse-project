/*
========================================================================
Football Data Warehouse — Schema Initialisation
========================================================================
Script Purpose:
  Sets up the medallion architecture schemas (bronze, silver, gold)
  for the FootballDataWarehouse database.

Prerequisites:
  1. Create the 'footballdatawarehouse' database manually or via:
     CREATE DATABASE footballdatawarehouse;
  2. Connect to 'footballdatawarehouse' before running this script.

WARNING:
  This script uses IF NOT EXISTS so it is safe to re-run.
========================================================================
*/

-- Create schemas for medallion architecture
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
