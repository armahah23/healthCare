const mongoose = require("mongoose");

const persionalInfoSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },
    dietType: {
        type: String,
        required: true,
    },
    age: {
        type: Number,
        required: true,
    },
    gender: {
        type: String,
        required: true,
    },
    height: {
        type: Number,
        required: true,
    },
    weight: {
        type: Number,
        required: true,
    },
    goal: {
        type: [String],
        required: true,
    }
});

const PersonalInfo = mongoose.model("PersonalInfo", persionalInfoSchema);

module.exports = PersonalInfo;