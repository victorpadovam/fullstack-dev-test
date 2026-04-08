import { describe, it, expect, vi, beforeEach } from "vitest";
import request from "supertest";
import app from "../app";
import { SuggestionService } from "../services/suggestion.service";

vi.mock("../services/suggestion.service");

describe("POST /api/v1/suggestions", () => {
    beforeEach(() => {
        vi.clearAllMocks();
    });

    it("retorna 400 quando occasion está ausente", async () => {
        const res = await request(app)
            .post("/api/v1/suggestions")
            .send({ relationship: "amigo" });

        expect(res.status).toBe(400);
        expect(res.body.error).toBe("occasion and relationship are required");
    });

    it("retorna 400 quando relationship está ausente", async () => {
        const res = await request(app)
            .post("/api/v1/suggestions")
            .send({ occasion: "aniversario" });

        expect(res.status).toBe(400);
        expect(res.body.error).toBe("occasion and relationship are required");
    });

    it("retorna 200 com sugestões válidas", async () => {
        vi.spyOn(SuggestionService, "getSuggestions").mockResolvedValue({
            suggestions: ["Parabéns!", "Feliz aniversário!", "Que dia especial!"],
            source: "llm",
        });

        const res = await request(app)
            .post("/api/v1/suggestions")
            .send({ occasion: "aniversario", relationship: "amigo" });

        expect(res.status).toBe(200);
        expect(res.body.suggestions).toHaveLength(3);
        expect(res.body.source).toBe("llm");
    });

    it("retorna 200 com source=fallback quando LLM falha", async () => {
        vi.spyOn(SuggestionService, "getSuggestions").mockResolvedValue({
            suggestions: ["Mensagem padrão"],
            source: "fallback",
        });

        const res = await request(app)
            .post("/api/v1/suggestions")
            .send({ occasion: "natal", relationship: "colega" });

        expect(res.status).toBe(200);
        expect(res.body.source).toBe("fallback");
    });
});