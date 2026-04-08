import { Request, Response } from "express";
import { SuggestionService } from "../services/suggestion.service";

export class SuggestionsController {
    static async create(req: Request, res: Response) {
        const { occasion, relationship } = req.body;

        if (
            !occasion ||
            !relationship ||
            typeof occasion !== "string" ||
            typeof relationship !== "string"
        ) {
            return res.status(400).json({
                error: "occasion and relationship are required",
            });
        }

        const result = await SuggestionService.getSuggestions(
            occasion,
            relationship
        );

        return res.status(200).json(result);
    }
}