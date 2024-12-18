const PersionalInfo = require("../schemas/persionalInfoSchema");

exports.createPersionalInfo = async (req, res) => {
  try {
    const { userId, dietType, gender, age, height, weight, goal } = req.body;

    if (!userId || !dietType || !gender || !age || !height || !weight || !goal) {
      return res.status(400).json({ message: "Please fill in all fields" });
    }

    const persionalInfo = await PersionalInfo.create({
      userId,
      dietType,
      gender,
      age,
      height,
      weight,
      goal,
    });

    await new PersionalInfo(persionalInfo).save();

    res.status(201).json({ message: "Personal Info created successfully", });
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
