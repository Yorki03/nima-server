const jwt = require('jsonwebtoken');

const validarJWT = (req, res, next)=>{

    const token = req.headers.authorization;

    if(!token){
        res.status(401).json({mensaje: 'No se proporciono un token de autenticacion'});
        return;
    }

    try {
        const {uid} = jwt.verify(token, process.env.SECRETOPRIVATEKEY);
        req.uid = uid;
        next();

    } catch (error) {
        res.status(401).json({mensaje: 'Token de autenticacion invalido'});
        return;
    }
}

module.exports = validarJWT;