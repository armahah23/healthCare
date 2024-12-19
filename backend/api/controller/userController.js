const bcrypt = require("bcrypt");
const User = require("../schemas/userSchema");
const jwt = require("jsonwebtoken");


// Create new user
exports.createUser = async (req, res) => {
  try {
    const { fullname, email, password, confirmPassword } = req.body;

    // Validation checks
    if (!fullname || !email || !password || !confirmPassword) {
      return res.status(400).json({ message: "Please fill in all fields" });
    }

    if (password !== confirmPassword) {
      return res.status(400).json({ message: "Passwords do not match" });
    }

    // Check if user already exists
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "Email already registered" });
    }

    // Create user
    const hashedpassword = bcrypt.hashSync(password, 10);
    const user = await User.create({
      userrole: "user",
      fullname,
      email,
      password: hashedpassword,
      date: new Date(),
    });

    const token = jwt.sign(
      { id: user._id, email: user.email }, 
      process.env.JWT_SECRET,
      { expiresIn: "1h" }
    );

    res.status(201).json({ message: "User created successfully", token });
  } catch (err) {
    if (err.code === 11000) {
      return res.status(400).json({ message: "Email already exists" });
    }
    console.log(err);
    res.status(500).json({ message: "Internal server error" });
  }
};

// Login user
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: "Please fill in all fields" });
    }

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ message: "User does not exist" });
    }

    const isMatch = bcrypt.compareSync(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ message: "Invalid credentials" });
    }

    // Assuming you have a function to generate a token
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });

    res.status(200).json({  message:"login successfully", token });
  } catch (error) {
    console.error("Error during login:", error); // Log the error details
    res.status(500).json({ message: "Server error" });
  }
};

//get all the users
exports.getAllUsers = async (req, res) => {
  try {
    const users = await User.find();
    res.status(200).json(users);
  } catch (err) {
    console.log(err);
    res.status(500).json({ message: "Internal server error" });
  }
};

//get user by id
exports.getUserById = async (req, res) => {
  try {
    const userId = req.params.id;

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    res.status(200).json(user);
  } catch (err) {
    console.log(err);
    res.status(500).json({ message: "Internal server error" });
  }
};
