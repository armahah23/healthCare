import { Rekognition } from "aws-sdk";
import { config } from "dotenv";
const { sqs } = require("@aws-sdk/client-sqs");

async function sendMessage(sqs,params) {
    try {
        const data = await sqs.sendMessage(params);
        return data;
        console.log("Success, message sent. MessageID:", data.MessageId);
    }
    catch (err) {
        console.error("Error:", err.stack);
    }
}

{async() => {
    const sqs = new SQS({
        Region:process.env.REGION,
        credintials:{
            accessKeyId:process.env.AWS_KEY,
            secretAccessKey:process.env.AWS_SECRET
        }
    })
    const params = {
        Messagebody:JSON.stringify({"message": "Hello from the sender!"}),
        QueuseURL: process.env.QUEUE_URL
    }

    const response = await sendMessage(sqs,params);
    console.log(response);
}}{}