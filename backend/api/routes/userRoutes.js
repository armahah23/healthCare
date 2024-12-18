const express = require("express");
const router = express.Router();
const userController = require("../controller/userController");

router.post("/createuser", userController.createUser);
router.post("/login", userController.login);
router.get("/getallusers", userController.getAllUsers);
router.get("/getuser/:id", userController.getUserById);

module.exports = router;