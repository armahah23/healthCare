const express = require('express');
const { sendReminder } = require('../controller/snsController');

const router = express.Router();

// Endpoint for sending reminders
router.post('/reminder', sendReminder);

module.exports = router;
