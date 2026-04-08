import { GoogleGenAI } from "@google/genai";
import { env } from "../config/env";
import { buildSuggestionPrompt } from "../utils/prompt-builder";
import { parseSuggestionsFromText } from "../utils/parse-suggestions";

export class GeminiService {
    private static client = env.geminiApiKey
        ? new GoogleGenAI({ apiKey: env.geminiApiKey })
        : null;

    static async generateSuggestions(
        occasion: string,
        relationship: string
    ): Promise<string[]> {
        if (!this.client) {
            throw new Error("Missing GEMINI_API_KEY");
        }

        const prompt = buildSuggestionPrompt(occasion, relationship);

        const response = await this.client.models.generateContent({
            model: "gemini-2.5-flash",
            contents: prompt,
        });

        const text = response.text;

        if (!text) {
            throw new Error("Empty LLM response");
        }

        return parseSuggestionsFromText(text);
    }
}