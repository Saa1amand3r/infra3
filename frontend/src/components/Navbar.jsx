import { Link } from "react-router-dom";

const Navbar = () => {
    return (
        <nav className="bg-blue-600 text-white shadow-md">
            <div className="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
                <Link to="/" className="text-2xl font-bold hover:text-gray-200">
                    📜 QuotesApp
                </Link>
                <div className="space-x-4">
                    <Link to="/" className="hover:text-gray-200">
                        Home
                    </Link>
                    <Link to="/list" className="hover:text-gray-200">
                        All Quotes
                    </Link>
                </div>
            </div>
        </nav>
    );
};

export default Navbar;
