import Quote from "./Quote";

const QuoteList = ({ quotes }) => {
    return (
        <ul className="max-w-2xl mx-auto">
            {quotes.map((quote, i) => (
                <Quote key={i} text={quote.text} author={quote.author} />
            ))}
        </ul>
    );
};

export default QuoteList;
