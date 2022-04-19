# SQL
This repo help one to get started with designing the schemas and define queries on top of relational databases. RDBMS or relational databases are primarily designed for transactional systems i.e recording and managing day to day activities and transactions such as production, selling, income and expanses, purchase. As per CAP theorem, RDBMS are usually support availability and are consistent however, they are not suitable for horizontal scaling as they do not support partitioning across multiple nodes.

Key things to know about OLTP i.e transactional systems:
1. When designing a relational database, we usually go through a process of defining a logical schema where define dependencies or relations 
   (1-1 or 1-n or n-1) between the tables.
2. Data is not stored in multiple places i.e no redundancy is allowed.
3. Indexes are defined for better throughput i.e retrieve the output by minimal scanning of the database for faster retrieval of data.
4. Multiple tables are joined to obtain the required information. 


