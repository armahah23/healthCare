const express = require('express');
const router = express.Router();
const persionalInfoController = require('../controller/persionalInfoController');

router.post('/user/persionalinfo', persionalInfoController.createPersionalInfo);

module.exports = router;