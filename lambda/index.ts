import { PutItemCommand, DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { SNSClient, PublishCommand } from "@aws-sdk/client-sns";

export const handler = async (event: any, context: any) => {
  console.log(`Event: ${JSON.stringify(event, null, 2)}`);
  console.log(`Context: ${JSON.stringify(context, null, 2)}`);

  const client = new DynamoDBClient({});
  const snsClient = new SNSClient({});

  // DynamoDB
  const command = new PutItemCommand({
    TableName: process.env.DYNAMODB_TABLE,
    Item: {
      PK: { S: "TEST PK" },
      SK: { S: `TEST SK ${Date.now()}` },
    },
  });

  const response = await client.send(command);
  console.log("DYNAMODB RESPONSE: \n" + JSON.stringify(response, null, 2));

  // SNS
  const params = {
    Message: `IEM Lambda Test - ${Date.now()}`,
    TopicArn: process.env.SNS_TOPIC,
  };

  const result = await snsClient.send(new PublishCommand(params));
  console.log("SNS RESULT: \n" + JSON.stringify(result, null, 2));
};
