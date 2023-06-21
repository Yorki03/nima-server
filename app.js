const express = require('express');
const cors = require('cors');
const mysqlConnect = require('./mysql');
const bcypt = require('bcryptjs');
const path = require('path');
require('dotenv').config();

const app = express();  

//Acceso al directotio publico
app.use(express.static('public'));

//Middlewares
app.use(cors({origin: "*"}));
app.use(express.json());


//Modelo de usuario
const User = {
    async create(name, email, password){
        //encriptar el password
        const hashedPassword = bcypt.hashSync(password, 10);
        //Insertar el usuario en la base de datos
        await mysqlConnect.query('INSERT INTO usuario (name, email,password) VALUES(?, ?, ?)', [name, email, hashedPassword]);
    },
};


//Rutas
app.get('/cuello', (req,res)=>{
    mysqlConnect.query('SELECT * FROM cuello', (err, rows, fields)=>{
        if(!err){
            res.json(rows);
        }else{
            console.log(err);            
        }
    });
});
app.get('/cuerpo', (req,res)=>{
    mysqlConnect.query('SELECT * FROM cuerpo', (err, rows, fields)=>{
        if(!err){
            res.json(rows);
        }else{
            console.log(err);            
        }
    });
});
app.get('/manga', (req,res)=>{
    mysqlConnect.query('SELECT * FROM manga', (err, rows, fields)=>{
        if(!err){
            res.json(rows);
        }else{
            console.log(err);            
        }
    });
});

app.get('/telas',(req,res)=>{
    mysqlConnect.query('SELECT * FROM tela', (err, rows, fields)=>{
        if(!err){
            res.json(rows);
        }else{
            console.log(err);            
        }
    });
});

app.get('/botones',(req,res)=>{
    mysqlConnect.query('SELECT * FROM boton', (err, rows, fields)=>{
        if(!err){
            res.json(rows);
        }else{
            console.log(err);            
        }
    });
});

app.get('/producto/:id_boton/:id_tela/:id_cuerpo/:id_cuello/:id_manga', (req, res) => {
    const id_boton = req.params.id_boton;
    const id_tela = req.params.id_tela;
    const id_cuerpo = req.params.id_cuerpo;
    const id_cuello = req.params.id_cuello;
    const id_manga = req.params.id_manga;
  
    mysqlConnect.query('SELECT * FROM producto WHERE id_boton = ? AND id_tela = ? AND id_cuerpo = ? AND id_cuello = ? AND id_manga = ?', 
      [id_boton, id_tela, id_cuerpo, id_cuello, id_manga], 
      (err, rows, fields) => {
        if (err) {
          console.log(err);
          res.status(500).json({ error: 'Error al buscar el producto.' });
        } else {
          res.json(rows);
        }
    });
});

app.post('/pedido', (req, res)=>{
    
    const {nombre, email, telefono, direccion, id_producto} = req.body;
    const sql = 'INSERT INTO pedido (nombre, email, telefono, direccion, id_producto) VALUE (?, ?, ?, ?, ?)';
    
    mysqlConnect.query(sql, [nombre, email, telefono, direccion, id_producto], (err, rows)=>{
        if (err) {
            console.log(err);
            res.status(500).json({ error: 'Error al buscar el producto.' });
          } else {
            res.json(rows);
          }
    });
});

//Controlador de rutas
app.get('*',(req, res)=>{
    res.sendFile(path.resolve(__dirname, 'public/index.html'));
});



//Puerto de conexion al puerto
app.listen(3000, ()=>{
    console.log('Server corrirndo en puerto 3000');
});