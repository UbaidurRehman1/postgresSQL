<h1>Postgres SQL</h2>
<ol>
    <li>for listing databases use: <strong>\l</strong></li>
    <li>create database use: <strong>CREATE DATABASE database_name</strong></li>
    <li>connect to database: <strong>psql -h localhost -p 5432 -U postgres database_name</strong></li>
    <li>connect to database(b): <strong>get into postgres -> \c database_name</strong></li>
    <li>drop database: <strong>DROP DATABASE database_name;</strong></li>
    <li>\d use for describing all tables </li>
    <li>\d table_name use to describe specific table</li>
    <li>BIGSERIAL auto increment the number</li>
    <li>\i is used to execute a file (sql)</li>
    <li>https://mockaroo.com/ to generate random data</li>
</ol>

<ol>
    <h1>How to execute school.sql file in your postgres sql server</h1>
    <li>open terminal</li>
    <li>Go to the directory where school.sql is placed</li>
    <li>open up the session with your postgres sql server</li>
    <ol>
        <li>psql -h localhost -U postgres -W</li>
        <li>it will promt for password, write your password which you wrote in installation</li>
    </ol>
    <li>after successfully login run <strong>CREATE DATABASE school;</strong> note: semi colon is important</li>
    <li>connect to newly made database using <strong>\c school</strong> and give password to prompt</li>
    <li>now run <strong>\i school.sql</strong></li>
    <li>And that's all</li>
</ol>