const mongoose = require('mongoose')
const { ObjectId } = mongoose.Schema.Types
const postSchema = new mongoose.Schema({

    doc: {
        type: String,
    },

}, { timestamps: true })

const Post = mongoose.model('Post', postSchema)
module.exports = Post
