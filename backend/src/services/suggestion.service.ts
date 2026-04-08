import { FallbackService } from "./fallback.service";
import { GeminiService } from "./gemini.service";
import { SuggestionResponseDto } from "../types/api.types";

export class SuggestionService {
    static async getSuggestions(
        occasion: string,
        relationship: string
    ): Promise<SuggestionResponseDto> {
        try {
            const suggestions = await GeminiService.generateSuggestions(
                occasion,
                relationship
            );

            return {
                suggestions,
                source: "llm", // Se a chave Gemini estiver ok sugestões reais da LLM
            };
        } catch (error) {
            console.error("LLM failed, using fallback:", error);

            const fallbackSuggestions = FallbackService.getSuggestions(
                occasion,
                relationship
            );

            return {
                suggestions: fallbackSuggestions,
                source: "fallback", // se nao resposta invalida
            };
        }
    }
}