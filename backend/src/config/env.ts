import dotenv from "dotenv";

dotenv.config();

export const env = {
    port: Number(process.env.PORT) || 3333,
    geminiApiKey: process.env.GEMINI_API_KEY || "",
};