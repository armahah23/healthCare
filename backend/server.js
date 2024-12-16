const express = require("express");
const cors = require("cors");
const app = express();
const loginRoutes = require("./api/routes/loginRoutes");
const persionalInfoRoutes = require("./api/routes/persionalInfoRoutes");

app.use(cors());
app.use(express.json());

//routes
app.use("/api", loginRoutes);
app.use("/api", persionalInfoRoutes);

//port
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
