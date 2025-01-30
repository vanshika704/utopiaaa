
import express from "express";
import bcrypt from "bcrypt"; 
import User from "../models/signup.js"; // Ensure this path is correct

const router = express.Router();


const generateUniqueCode = (name) => {
  if (!name) {
    throw new Error("Name is required to generate a unique code.");
  }

  const initials = name
    .split(" ")
    .map((word) => word[0])
    .join("")
    .toUpperCase();
  const randomNumber = Math.floor(1000 + Math.random() * 9000); // Random 4-digit number
  return `${initials}-${randomNumber}`;
};

// User Signup route
router.post("/signup", async (req, res) => {
  const { name, email, password } = req.body;

  // Check if all required fields are provided
  if (!name || !email || !password) {
    return res.status(400).json({ message: "Name, email, and password are required." });
  }

  // Generate simple unique code
  let uniqueCode;
  try {
    uniqueCode = generateUniqueCode(name);
  } catch (error) {
    return res.status(400).json({ message: error.message });
  }

  try {
    // Hash the password before saving it to the database
    const hashedPassword = await bcrypt.hash(password, 10); // 10 is the salt rounds

    // Create and save user
    const user = new User({ name, email, password: hashedPassword, uniqueCode });
    await user.save();

    // Log the registered user to the server console
    console.log("User registered:", user);

    // Respond with success
    res.status(201).json({
      message: "User registered successfully",
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        uniqueCode: user.uniqueCode,
      },
    });
  } catch (error) {
    if (error.code === 11000) {
      res.status(400).json({ message: "Email already exists" });
    } else {
      res.status(500).json({ message: "Server error", error: error.message });
    }
  }
});
// User Login route
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  // Validate input
  if (!email || !password) {
    return res.status(400).json({ message: "Email and password are required" });
  }

  try {
    // Find user by email
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Compare password with the hashed password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(400).json({ message: "Invalid email or password" });
    }

    // Respond with user details (exclude sensitive fields)
    res.status(200).json({
      message: "Login successful",
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        uniqueCode: user.uniqueCode,
      },
    });
  } catch (error) {
    res.status(500).json({ message: "Server error", error: error.message });
  }
});


export default router;
