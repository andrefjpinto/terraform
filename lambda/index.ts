import { PutItemCommand, DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { SNSClient, PublishCommand } from "@aws-sdk/client-sns";
import {
  SecretsManagerClient,
  GetSecretValueCommand,
} from "@aws-sdk/client-secrets-manager";

export const handler = async (event: any, context: any) => {
  console.log(`Event: ${JSON.stringify(event, null, 2)}`);
  console.log(`Context: ${JSON.stringify(context, null, 2)}`);

  const dynamodbClient = new DynamoDBClient({
    region: "eu-west-1",
  });
  const snsClient = new SNSClient({
    region: "eu-west-1",
  });
  const smClient = new SecretsManagerClient({
    region: "eu-west-1",
  });

  const secret_name = "iem-dev-sap-api-password";

  // DynamoDB
  const command = new PutItemCommand({
    TableName: process.env.DYNAMODB_TABLE,
    Item: {
      PK: { S: "TEST PK" },
      SK: { S: `TEST SK ${Date.now()}` },
    },
  });

  const response = await dynamodbClient.send(command);
  console.log("DYNAMODB RESPONSE: \n" + JSON.stringify(response, null, 2));

  // SNS
  const params = {
    Message: `IEM Lambda Test - ${Date.now()}`,
    TopicArn: process.env.SNS_TOPIC,
  };

  const result = await snsClient.send(new PublishCommand(params));
  console.log("SNS RESULT: \n" + JSON.stringify(result, null, 2));

  // Secrets Manager
  var smResponse = await smClient.send(
    new GetSecretValueCommand({
      SecretId: secret_name,
    })
  );

  console.log("Secrets Manager Response: \n" + JSON.stringify(smResponse));
};
