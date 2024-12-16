const persionalInfoSchema = require("../models/persionalInfoSchema");

//create persional info
exports.createPersionalInfo = async (req, res) => {
  try {
    const { dietType, gender, age, height, weight, activityLevel, goal } =
      req.body;

    if (
      !dietType ||
      !gender ||
      !age ||
      !height ||
      !weight ||
      !activityLevel ||
      !goal
    ) {
      return res.status(400).json({ message: "Please fill in all fields" });
    }
    const persionalInfo = await PersonalInfo.create({
      dietType,
      gender,
      age,
      height,
      weight,
      activityLevel,
      goal,
    });
    await new PersonalInfo(persionalInfo).save();
    res.status(201).json({ message: "Persional Info created successfully" });
  } catch (err) {
    console.log(err);
    res.status(500).json({ message: "Internal server error" });
  }
};

//get persional info
exports.getPersonalInfo = async (req, res) => {
  try {
    const personalInfo = await PersonalInfo.find();
    res.status(200).json(personalInfo);
  } catch (err) {
    console.log(err);
    res.status(500).json({ message: "Internal server error" });
  }
};
