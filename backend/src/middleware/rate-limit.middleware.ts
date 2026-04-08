import rateLimit from "express-rate-limit";

export const suggestionsRateLimit = rateLimit({
    windowMs: 60 * 1000, // 60 segundos
    max: 10, // máximo de 10 requisições
    standardHeaders: true,
    legacyHeaders: false,
    message: {
        error: "Too many requests. Please try again in a minute."
    }
});