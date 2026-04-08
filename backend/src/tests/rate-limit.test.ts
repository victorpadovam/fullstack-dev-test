import { describe, it, expect, vi } from "vitest";
import request from "supertest";
import app from "../app";
import { SuggestionService } from "../services/suggestion.service";

vi.mock("../services/suggestion.service");

describe("Rate Limit - POST /api/v1/suggestions", () => {
    it("bloqueia após 10 requisicoes no mesmo minuto", async () => {
        vi.spyOn(SuggestionService, "getSuggestions").mockResolvedValue({
            suggestions: ["ok"],
            source: "fallback",
        });

        const payload = { occasion: "aniversario", relationship: "amigo" };

        // Faz 10 requisicoes (dentro do limite)
        for (let i = 0; i < 10; i++) {
            await request(app).post("/api/v1/suggestions").send(payload);
        }

        // 11ª requisicoes deve ser bloqueada
        const res = await request(app)
            .post("/api/v1/suggestions")
            .send(payload);

        expect(res.status).toBe(429);
        expect(res.body.error).toBe("Too many requests. Please try again in a minute.");
    });
});