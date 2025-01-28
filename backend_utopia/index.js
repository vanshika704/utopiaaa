import express from "express";
import connectDB from "./db/db.js";
import dotenv from "dotenv";
import cors from "cors";
import userRoutes from "./routes/users.js";

dotenv.config();
const PORT = process.env.PORT || 3000;
const app = express();

app.use(cors());
app.use(express.json());
connectDB();

app.get("/", (req, res) => {
  res.send("Server is running!");
});

app.use("/api/users", userRoutes);


app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
