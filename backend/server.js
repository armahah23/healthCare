require('dotenv').config();
const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");
const userRoutes = require("./api/routes/userRoutes");
const persionalInfoRoutes = require("./api/routes/persionalInfoRoutes");
// const snsRoutes = require("./api/routes/snsroutes");

const app = express();
app.use(cors());
app.use(express.json());

// connect mongodb atlas
mongoose
  .connect(process.env.MONGODB_URI)
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.log("Connection failed", err);
  });

// Register routes
// app.use("/api", snsRoutes);
app.use("/api", userRoutes);
app.use("/api", persionalInfoRoutes);

//port
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});