const express=require('express')
var corS=require('cors')
require('./db/mongoose');
const app=express()
app.use(express.json())
const uploadRouter=require('./routers/upload')


const port =process.env.PORT || 3000

app.use(corS())

app.use(uploadRouter)


app.listen(port,()=>{
    console.log('Server is up on port '+port)
})