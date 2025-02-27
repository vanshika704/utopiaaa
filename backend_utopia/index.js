// import express from "express";
// import connectDB from "./db/db.js";
// import dotenv from "dotenv";
// import cors from "cors";
// import userRoutes from "./routes/users.js";

// dotenv.config();
// const PORT = process.env.PORT || 5000;
// const app = express();

// // Middleware
// app.use(cors());
// app.use(express.json());

// // Connect to Database
// connectDB();

// // Test Route
// app.get("/", (req, res) => {
//   res.send("Server is running!");
// });

// // User Route
// app.use("/api/users", userRoutes);

// app.listen(PORT, () => {
//   console.log(`Server running at http://localhost:${PORT}`);
// });


const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const router = express.Router();

app.use(bodyParser.json());

// Webhook endpoint for Dialogflow
router.post('/webhook', (req, res) => {
  // Define the webhook response
  const response = {
    "fulfillmentText": "Safety activated, you are safe dear.",  // Text response
    "source": "utopia",
    "payload": {
      "google": {
        "expectUserResponse": false,
        "richResponse": {
          "items": [
            {
              "simpleResponse": {
                "textToSpeech": "Safety activated, you are safe dear."
              }
            }
          ]
        },
        "linkOutSuggestion": {
          "destinationName": "Utopia Emergency",
          "url": "utopia://emergency"  // Deep link to open your app
        }
      }
    },
    "messages": [
      {
        "type": "message",
        "speech": [
          "Safety activated, you are safe dear"
        ]
      }
    ]
  };

  // Send the response back to Dialogflow / Google Assistant
  res.json(response);
});

// Add router to app
app.use(router);

// Start the server
const port = 3000;
app.listen(port, () => {
  console.log(`Webhook server is running at http://localhost:${port}`);
});
