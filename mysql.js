const mysql = require('mysql');

const mysqlConnet = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'nima_db'
});

mysqlConnet.connect(function(err){
    if(err){
        console.error(err);        
    }else{
        console.log('Database conectada');        
    }
});

module.exports = mysqlConnet;