#SQL

This is a sample script to create physical schema and insert data into a Next Gen Restraunt system.

The scripts needs to be executed in the order:

Create schema using DDL statements
Execute the SQL queries to retrieve and analysis the data stored
Note: This schema is deisgned to work on Oracle database. There might be minimal changes in the data types or syntax if you try to run the same on other databases. Overall, this should help you get started on understanding how to model the schema on relational database where data redundancy is not allowed.

Key things to know about OLTP i.e transactional systems:

When designing a relational database, we usually go through a process of defining a logical schema where define dependencies or relations (1-1 or 1-n or n-1) between the tables.
Data is not stored in multiple places i.e no redundancy is allowed.
Indexes are defined for better throughput i.e retrieve the output by minimal scanning of the database for faster retrieval of data.
Multiple tables are joined to obtain the required information.
As per CAP theorem, RDBMS are usually support availability and are consistent however, they are not suitable for horizontal scaling as they do not support partitioning across multiple nodes.
