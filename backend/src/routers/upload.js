const express = require('express')

const { json } = require('body-parser')
const Post = require('../models/post')

const app = new express.Router()

app.post('/upload',async (req,res)=>{
    console.log(req.body)
   try{
       const post=new Post(req.body)
       await post.save()
       res.status(201).send(post)
   }catch(e){
       res.status(400)
       res.send(e)        
   }

})

module.exports = app 