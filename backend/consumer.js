const { SQS } = reqiure("@aws-sdk/client-sqs");
require("dotenv").config();

async function awsSQSConsumer(sqs, queueUrl) {
  while (true) {
    try {
      const { Messages } = await sqs.receiveMessage({
        QueueUrl: queueUrl,
        MaxNumberOfMessage: 1,
        WaitTimeSeconds: 10,
      });
      if (!Messages) continue;
      console.log(Messages);
    } catch (error) {
      console.error("Error", error);
    }
  }
}

(async () => {
  const sqs = new SQS({
    region: process.env.REGION,
    credentials: {
      accessKeyId: process.env.AWS_KEY,
      secretAccessKey: process.env.AWS_SECRET,
    },
  });
  await awsSQSConsumer(sqs, process.env.QUEUE_URL);
})();
