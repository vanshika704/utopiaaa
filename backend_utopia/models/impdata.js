import mongoose from "mongoose"

const userSchema1 = new mongoose.Schema({
  uniqueCode: { type: String, required: true },
  emergencyContacts: [{ name: String, phone: String }],
  createdAt: { type: Date, default: Date.now },
});

export default mongoose.model('Userdata', userSchema1);
