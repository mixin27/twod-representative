import { live } from "#/controllers/twod";
import { Router } from "express";

const router = Router();

router.get("/live", live);

export default router;
