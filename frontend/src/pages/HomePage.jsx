import { useEffect, useState } from "react";
import axios from "axios";
import Spinner from "../components/Spinner";
import QuoteList from "../components/QuoteList";

const HomePage = () => {
    const [quotes, setQuotes] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchQuotes = async () => {
            const res = await axios.get("http://spring-quotes-app:8080/quotes");
            setQuotes(res.data || []);
            setLoading(false);
        };
        fetchQuotes();
    }, []);

    if (loading) return <Spinner />;

    return (
        <div className="py-10 px-4">
            <h1 className="text-3xl font-bold text-center mb-6">Quotes of the Day</h1>
            <QuoteList quotes={quotes.slice(0, 3)} />
        </div>
    );
};

export default HomePage;
