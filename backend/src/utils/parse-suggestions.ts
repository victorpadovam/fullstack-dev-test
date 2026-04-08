export function parseSuggestionsFromText(text: string): string[] {
    try {
        const cleaned = text.trim();

        const jsonStart = cleaned.indexOf("{");
        const jsonEnd = cleaned.lastIndexOf("}");

        if (jsonStart === -1 || jsonEnd === -1) {
            throw new Error("No JSON object found");
        }

        const jsonString = cleaned.slice(jsonStart, jsonEnd + 1);
        const parsed = JSON.parse(jsonString);

        if (!parsed.suggestions || !Array.isArray(parsed.suggestions)) {
            throw new Error("Invalid suggestions format");
        }

        const validSuggestions = parsed.suggestions
            .filter((item: unknown) => typeof item === "string")
            .map((item: string) => item.trim())
            .filter(Boolean)
            .slice(0, 3);

        if (validSuggestions.length < 2) {
            throw new Error("Not enough suggestions");
        }

        return validSuggestions;
    } catch (error) {
        throw new Error("Failed to parse LLM response");
    }
}