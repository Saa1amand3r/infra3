package be.kdg.programming5.backend.controller;


import be.kdg.programming5.backend.controller.dto.QuoteDto;
import be.kdg.programming5.backend.domain.Quote;
import be.kdg.programming5.backend.service.QuoteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/quotes")
@Slf4j
public class QuotesController {
    private final QuoteService quoteService;

    public QuotesController(QuoteService quoteService) {
        this.quoteService = quoteService;
    }

    @GetMapping
    public ResponseEntity<List<QuoteDto>> getQuotes() {
        quoteService.getQuotes();
        if (quoteService.getQuotes().isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(quoteService.getQuotes().stream().map(quote -> new QuoteDto(quote.getQuote(),
                quote.getAuthor())).toList());
    }

    @PostMapping
    public ResponseEntity<QuoteDto> addQuote(@RequestBody QuoteDto quoteDto) {
        log.info("Received quote: {}", quoteDto);
        Quote quote = quoteService.addQuote(quoteDto.text(), quoteDto.author());
        log.info("Added quote: {}", quote);
        return ResponseEntity.ok(new QuoteDto(quote.getQuote(), quote.getAuthor()));
    }
}
