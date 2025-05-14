import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import HomePage from './pages/HomePage';
import QuotesListPage from "./pages/QuotesListPage";
import Navbar from "./components/Navbar";
function App() {
  return (
      <Router>
          <Navbar/>
        <Routes>
          <Route path="/" element={<HomePage />} />
            <Route path="/list" element={<QuotesListPage/>}/>
        </Routes>
      </Router>
  );
}

export default App;
