const express = require("express");
const router = express.Router();

const controller = require("../controllers/userController");
const auth = require("../../middleware/authMiddleware");

router.post("/register", controller.register);
router.get("/profile", auth, controller.getProfile);
router.put("/update", auth, controller.update);
router.delete("/delete", auth, controller.delete);

module.exports = router;
