import { useEffect, useState } from "react";
import axios from "axios";
import Spinner from "../components/Spinner";
import AddQuoteForm from "../components/AddQuoteForm";
import QuoteList from "../components/QuoteList";

const QuotesListPage = () => {
    const [quotes, setQuotes] = useState([]);
    const [reloadQuotes, setReloadQuotes] = useState(false)
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchQuotes = async () => {
            const res = await axios.get("/api/quotes");
            setQuotes(res.data || []);
            setLoading(false);
        };
        fetchQuotes();
        setReloadQuotes(false);
    }, [reloadQuotes]);

    if (loading) return <Spinner />;

    return (
        <div className="py-10 px-4">
            <h1 className="text-3xl font-bold text-center mb-6">Quotes Database</h1>
            <AddQuoteForm setReloadQuotes={setReloadQuotes} />
            <h2 className="text-2xl font-semibold mb-4 text-center">All Quotes</h2>
            <QuoteList quotes={quotes} />
        </div>
    );
};

export default QuotesListPage;
