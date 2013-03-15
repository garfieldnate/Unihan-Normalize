#Unihan::Normalize

This project is similar to the C project libUnihan. It processes the Unihan database text files and produces a normalized data structure.
Fields in the unihan database can have multiple values (usually space-separated). This processor splits each field into its atomic parts and stores each separately. In the future I hope to produce a 5NF SQLite database like libUnihan. 