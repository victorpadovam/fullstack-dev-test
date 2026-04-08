export interface SuggestionRequestDto {
    occasion: string;
    relationship: string;
}

export interface SuggestionResponseDto {
    suggestions: string[];
    source: "llm" | "fallback";
}