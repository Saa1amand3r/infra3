package be.kdg.programming5.backend.service;

import be.kdg.programming5.backend.domain.Quote;
import be.kdg.programming5.backend.repository.QuoteRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class QuoteService {
    private final QuoteRepository quoteRepository;

    public QuoteService(QuoteRepository quoteRepository) {
        this.quoteRepository = quoteRepository;
    }


    public List<Quote> getQuotes() {
        return quoteRepository.findAll();
    }

    public Quote addQuote(String quote, String author) {
        log.info("Adding quote: {} by {}", quote, author);
        return quoteRepository.save(new Quote(quote,author));
    }
}
