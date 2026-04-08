import express from "express";
import cors from "cors";
import suggestionsRoutes from "./routes/suggestions.routes";
import { suggestionsRateLimit } from "./middleware/rate-limit.middleware";

const app = express();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
    res.status(200).json({ message: "API rodando 🚀" });
});

app.use("/api/v1/suggestions", suggestionsRateLimit, suggestionsRoutes);

export default app;