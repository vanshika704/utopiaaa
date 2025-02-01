import express from "express";
import connectDB from "./db/db.js";
import dotenv from "dotenv";
import cors from "cors";
import userRoutes from "./routes/users.js";

dotenv.config();
const PORT = process.env.PORT || 5000;
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Connect to Database
connectDB();

// Test Route
app.get("/", (req, res) => {
  res.send("Server is running!");
});

// User Route
app.use("/api/users", userRoutes);

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
