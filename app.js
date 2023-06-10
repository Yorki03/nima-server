const express = require('express');
const cors = require('cors');
const mysqlConnect = require('./mysql');
const bodyParser = require('body-parser');
const {check, validationResult} =require('express-validator');
const bcypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const validarJWT = require('./middelwares/validar-jwt');
const generarJWT = require('./herpers/generar-jwt');
require('dotenv').config();

const app = express();  


//Middlewares
app.use(cors({origin: "*"}));
app.use(express.json());
//app.use(bodyParser.urlencoded({extended: false}));
//app.use(bodyParser.json);

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
  

app.post('/registrarse',[
    check('name').notEmpty(),
    check('email').isEmail(),
    check('password').isLength({min: 8})
], async(res, req)=>{
    //validar los campos de los folmularios
    const err = validationResult(req);
    if(!err.isEmpty()){
        return res.status(422).json({errors: err.array()});
    }

    //crear el usuario en la base de datos
    const {name, email, password} = req.body;
    await User.create(name, email, password).then(()=> {
        res.status(201).send('Ususario creado exitosamente');
    })
    .catch((err) => {
        console.log(err);
        res.status(500).send('Error al crear el usuario');
    });    
});

app.post('/login',[
    check('email').isEmail(),
    check('password').isLength({min: 8})
], async(req, res)=>{
   const {email, password} = req.body;
   const query = 'SELECT id FROM usuario WHERE email = ? AND password = ?'; 
   mysqlConnect.query(query, [email, password],(err, reslts)=>{
       if(err)throw err;
       else if(reslts.length === 0){
           res.status(401).json({
                msg: 'Usuario o clave incorrectos',
                ok: false
            });
        }
       else{
           //Generando el TOKEN
           const token = jwt.sign(reslts[0].id, process.env.SECRETOPRIVATEKEY); 
           
           res.status(200).json({
               mensage: 'Autenticacion exitosa',
               uid: reslts[0].id,
               ok: true,
               token: token
            });
        }
   });
});

app.get('/renew', validarJWT,(req, res)=>{
    mysqlConnect.query('SELECT*FROM usuarios WHERE id = ?', req.uid, (err, rows, fields)=>{
        if(!err){
            res.json(rows[0]);
        }else{
            console.log(err);
            res.sendStatus(500);
        }
    });
});

//Puerto de conexion al puerto
app.listen(3000, ()=>{
    console.log('Server corrirndo en puerto 3000');
});