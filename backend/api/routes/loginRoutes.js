const express = require("express");
const router = express.Router();
const userController = require("../controller/userController");

router.post("/createuser", userController.createUser);
router.post("/login", userController.login);
router.get("/getallusers", userController.getAllUsers);

module.exports = router;