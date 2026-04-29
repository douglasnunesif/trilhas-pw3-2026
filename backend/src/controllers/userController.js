const User = require("../models/userModel")

exports.register = (req, res) => {

   const { name, email, password } = req.body

   const newUser = {
       name,
       email,
       password,
       role: "cliente"
   }

   User.createUser(newUser, (err, result) => {

       if(err){
           return res.status(400).json({message:"Erro ao cadastrar"})
       }

       res.json({message:"Usuário cadastrado com sucesso"})
   })
}

exports.getProfile = (req, res) => {

   const email = req.user.email

   User.findByEmail(email, (err, result) => {

       res.json(result[0])
   })
}

exports.update = (req, res) => {

   const email = req.user.email

   User.update(email, req.body, (err) => {

       if(err){
           return res.status(400).json({message:"Erro ao atualizar"})
       }

       res.json({message:"Atualizado com sucesso"})
   })
}

exports.delete = (req, res) => {

   const email = req.user.email

   User.delete(email, (err) => {

       if(err){
           return res.status(400).json({message:"Erro ao excluir"})
       }

       res.json({message:"Conta excluída"})
   })
}
