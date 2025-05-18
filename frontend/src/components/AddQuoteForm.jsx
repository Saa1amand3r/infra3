import { useState } from "react";
import axios from "axios";

const AddQuoteForm = ({setReloadQuotes}) => {
    const [quoteText, setQuoteText] = useState("");
    const [author, setAuthor] = useState("");

    const submitForm = async () => {
        const quote = { text: quoteText, author: author };

        try {
            console.log(quote);
            await axios.post("http://spring-quotes-app:8080/quotes", quote);
            setQuoteText("");
            setAuthor("");
            setReloadQuotes(true);
        } catch (error) {
            console.error("Error submitting quote:", error);
            alert("Failed to add quote.");
        }
    };

    return (
        <div className="bg-white shadow-md rounded-lg p-6 max-w-md mx-auto mb-8">
            <h3 className="text-xl font-semibold mb-4">Add a New Quote</h3>
            <label htmlFor="quoteText" className="block text-sm font-medium mb-1">
                Quote:
            </label>
            <input
                id="quoteText"
                type="text"
                className="w-full p-2 border rounded mb-4"
                placeholder="Enter quote"
                value={quoteText}
                onChange={(e) => setQuoteText(e.target.value)}
            />

            <label htmlFor="author" className="block text-sm font-medium mb-1">
                Author:
            </label>
            <input
                id="author"
                type="text"
                className="w-full p-2 border rounded mb-4"
                placeholder="Enter author"
                value={author}
                onChange={(e) => setAuthor(e.target.value)}
            />

            <button
                onClick={submitForm}
                className="bg-blue-600 text-white py-2 px-4 rounded hover:bg-blue-700 w-full"
            >
                Add Quote
            </button>
        </div>
    );
};

export default AddQuoteForm;
