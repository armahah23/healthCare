const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");
const loginRoutes = require("./api/routes/loginRoutes");
const persionalInfoRoutes = require("./api/routes/persionalInfoRoutes");

const app = express();
app.use(cors());
app.use(express.json());

// connect mongodb atlas
mongoose
  .connect(
    "mongodb+srv://armaempoff:TChf1akA6Vjq5npt@cluster1.n3l2d.mongodb.net/healthapp")
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.log("Connection failed", err);
  });

// Register routes
app.use("/api", loginRoutes);
app.use("/api", persionalInfoRoutes);

//port
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});