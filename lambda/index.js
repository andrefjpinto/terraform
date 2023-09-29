const SNSClient = require("@aws-sdk/client-sns").SNSClient;
const PublishCommand = require("@aws-sdk/client-sns").PublishCommand;
const PutItemCommand = require("@aws-sdk/client-dynamodb").PutItemCommand;
const DynamoDBClient = require("@aws-sdk/client-dynamodb").DynamoDBClient;

const snsClient = new SNSClient({});
const client = new DynamoDBClient({});

exports.handler = async (event, context) => {
  try {

    console.log("EVENT: \n" + JSON.stringify(event, null, 2));

    // DynamoDB
    const command = new PutItemCommand({
      TableName: process.env.DYNAMODB_TABLE,
      Item: {
        PK: { S: "TEST PK" },
        SK: { S: "TEST SK" },
      },
    });

    const response = await client.send(command);
    console.log("DYNAMODB RESPONSE: \n" + JSON.stringify(response, null, 2));
    
    // SNS
    const params = {
      Message: "Hello World",
      TopicArn: process.env.SNS_TOPIC,
    };

    const result = await snsClient.send(new PublishCommand(params));
    console.log("SNS RESULT: \n" + JSON.stringify(result, null, 2));

    return context.logStreamName;
  } catch (error) {
    console.log("ERROR: \n" + error);
    return error;
  }
};
