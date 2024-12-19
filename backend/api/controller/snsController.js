const { SNSClient, PublishCommand } = require("@aws-sdk/client-sns");

const snsClient = new SNSClient({ region: "us-east-1" });
const SNS_TOPIC_ARN = 'arn:aws:sns:us-east-1:767397848591:FitnessApp';

exports.sendReminder = async (req, res) => {
    const { message, subject } = req.body;

    // Validate input
    if (!message || !subject) {
        return res.status(400).json({ error: 'Message and subject are required.' });
    }

    try {
        // Publish message to SNS topic
        const params = {
            Message: message,
            Subject: subject,
            TopicArn: SNS_TOPIC_ARN,
        };

        const command = new PublishCommand(params);
        const data = await snsClient.send(command);

        res.status(200).json({ message: "Message sent successfully", data });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Failed to send message", details: err });
    }
};