export function normalizeText(value: string): string {
    return value
        .trim() // Remove espaços
        .toLowerCase() // Tudo minuscula 
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, "");
}