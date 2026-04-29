const jwt = require("jsonwebtoken")

const SECRET = "segredo123"

module.exports = (req, res, next) => {

   const token = req.headers.authorization

   if(!token){
       return res.status(401).json({message:"Sem token"})
   }

   try{
       const decoded = jwt.verify(token, SECRET)
       req.user = decoded
       next()
   }catch{
       return res.status(401).json({message:"Token inválido"})
   }
}
