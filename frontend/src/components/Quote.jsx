const Quote = ({ text, author }) => {
    return (
        <li className="bg-white shadow p-4 rounded-md mb-4 border-l-4 border-blue-600">
            <h2 className="text-lg font-semibold italic text-gray-800">“{text}”</h2>
            <p className="text-sm text-gray-600 mt-2 text-right">— {author}</p>
        </li>
    );
};

export default Quote;
