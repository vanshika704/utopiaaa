// import dotenv from "dotenv";
// dotenv.config();
// import mongoose from "mongoose";
// const mongoURI = process.env.MONGO_URI;
// const connectDB = async () => {
//     try {
    
//         await mongoose.connect(mongoURI, {
           
//         });
//         console.log("Connected to MongoDB Atlas! 🚀");
//     } catch (err) {
//         console.error("MongoDB connection error:", err.message);
       
//     }
// };

// export default connectDB;

import mongoose from "mongoose";

const connectDB = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGO_URI, {
     
    });
    console.log(`MongoDB Connected: ${conn.connection.host}`);
  } catch (error) {
    console.error(`Error: ${error.message}`);
    process.exit(1);
  }
};

export default connectDB;
