export function buildSuggestionPrompt(
    occasion: string,
    relationship: string
): string {
    return `
You are a helpful assistant that writes short and warm gift card messages.

Generate exactly 3 short gift card messages in Brazilian Portuguese.

Context:
- Occasion: ${occasion}
- Relationship: ${relationship}

Rules:
- Each message must be 1 to 2 short sentences
- Warm, natural, and appropriate for a gift card
- Avoid emojis
- Avoid repeating the same wording
- Return ONLY valid JSON in this exact format:
{
  "suggestions": [
    "message 1",
    "message 2",
    "message 3"
  ]
}
`.trim();
}