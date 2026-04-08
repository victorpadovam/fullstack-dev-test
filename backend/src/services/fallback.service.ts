import { normalizeText } from "../utils/normalize";

export class FallbackService {
    static getSuggestions(occasion: string, relationship: string): string[] {
        const normalizedOccasion = normalizeText(occasion);
        const normalizedRelationship = normalizeText(relationship);

        const map: Record<string, Record<string, string[]>> = {
            aniversario: {
                amigo: [
                    "Feliz aniversário! Que seu dia seja cheio de alegria e momentos especiais.",
                    "Parabéns! Desejo muita saúde, felicidade e sucesso neste novo ciclo.",
                    "Que seu aniversário seja incrível e cercado de pessoas queridas."
                ],
                colega: [
                    "Feliz aniversário! Desejo um dia especial e um novo ciclo de muitas conquistas.",
                    "Parabéns! Que não faltem saúde, sucesso e bons momentos neste novo ano.",
                    "Muitas felicidades e um excelente aniversário para você!"
                ]
            },
            casamento: {
                amigo: [
                    "Parabéns por esse momento tão especial! Que o amor e a felicidade acompanhem essa nova fase.",
                    "Desejo uma vida a dois repleta de carinho, cumplicidade e momentos inesquecíveis.",
                    "Que essa união seja cheia de amor, paz e muitas alegrias."
                ]
            },
            agradecimento: {
                amigo: [
                    "Com carinho e gratidão, obrigado por tudo o que você faz.",
                    "Sua ajuda fez toda a diferença. Meu muito obrigado de coração!",
                    "Sou muito grato pela sua presença e generosidade."
                ]
            }
        };

        const suggestions =
            map[normalizedOccasion]?.[normalizedRelationship] ||
            [
                `Com carinho, desejo que este momento de ${occasion} seja muito especial para você.`,
                `Que esta ocasião traga alegria, afeto e boas lembranças. Com carinho para um(a) ${relationship} especial.`,
                `Desejo tudo de melhor nesta ocasião tão importante.`
            ];

        return suggestions.slice(0, 3);
    }
}