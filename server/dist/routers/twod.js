"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const twod_1 = require("../controllers/twod");
const express_1 = require("express");
const router = (0, express_1.Router)();
router.get("/live", twod_1.live);
exports.default = router;
