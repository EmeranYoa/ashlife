/*
Copyright 2017 - 2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at
    http://aws.amazon.com/apache2.0/
or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.
*/




const express = require('express')
const bodyParser = require('body-parser')
const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware')
const axios = require('axios')

// declare a new express app
const app = express()
app.use(bodyParser.json())
app.use(awsServerlessExpressMiddleware.eventContext())

const dreamboothApiVersion = "v3";
const dreamboothApiKey = "QRPI1z4lwCgPsWKbReXxfc1DDYey5CKPWMcCWeYYd8rAlzwSsNEUiMNzxdSe";

const dreamboothBaseUrl = "https://stablediffusionapi.com/api/"+ dreamboothApiVersion;

const dreamboothTraining = dreamboothBaseUrl + "/fine_tune";
const dreamboothTextToImage = dreamboothBaseUrl + "/dreambooth";
const dreamboothImageToImage = dreamboothBaseUrl + "/dreambooth/img2img";
const webhook = "https://3d0zjl4cce.execute-api.us-east-1.amazonaws.com/dev/webhook";

// Enable CORS for all methods
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*")
  res.header("Access-Control-Allow-Headers", "*")
  next()
});


app.post('/training', function(req, res) {
  // Add your code here
  res.json({success: 'post call succeed!', url: req.url, body: req.body})
});

app.post('/img2img', async function(req, res) {
      console.log("ASHLIFE Start");
    try {
      const data = {...req.body, key: dreamboothApiKey, webhook: webhook};
      const response = await axios.post(
        dreamboothImageToImage,
        data
      );
      console.log("ASHLIFE RESPONSE", response);
      res.status(200).json(response.data);
    } catch (e) {
      console.log("ASHLIFE ERROR", e.message);
      res.status(500).json({status: 'error', message: e.message});
    }
});

app.post('/txt2img', function(req, res) {
  // Add your code here
  res.json({success: 'post call succeed!', url: req.url, body: req.body})
});

app.post('/webhook', function(req, res) {
  // Add your code here
  res.json({success: 'post call succeed!', url: req.url, body: req.body})
});

app.listen(3000, function() {
    console.log("App started")
});

// Export the app object. When executing the application local this does nothing. However,
// to port it to AWS Lambda we will create a wrapper around that will load the app from
// this file
module.exports = app
