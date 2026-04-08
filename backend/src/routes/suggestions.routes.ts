import { Router } from "express";
import { SuggestionsController } from "../controllers/suggestions.controller";

const router = Router();

router.post("/", SuggestionsController.create);

export default router;