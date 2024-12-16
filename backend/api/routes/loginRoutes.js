const express = require("express");
const router = express.Router();

router.post("/createuser", userController.createUser);
router.post("/login", userController.login);