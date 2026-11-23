import SplashScreen from './components/SplashScreen'
import { HashRouter, Routes, Route, useLocation } from 'react-router-dom'
import { useEffect } from 'react'
import Navbar from './components/Navbar'
import Footer from './components/Footer'
import WhatsAppButton from './components/WhatsAppButton'
import Home from './pages/Home'
import Fleet from './pages/Fleet'
import CarDetails from './pages/CarDetails'
import Services from './pages/Services'
import About from './pages/About'
import Contact from './pages/Contact'
import './styles/global.css'

function ScrollToTop() {
  const { pathname } = useLocation()
  useEffect(() => {
    window.scrollTo(0, 0)
  }, [pathname])
  return null
}

export default function App() {
  return (
    <>
      <SplashScreen />

    <HashRouter>
      <ScrollToTop/>
      <Navbar/>
      <Routes>
        <Route path="/" element={<Home/>}/>
        <Route path="/flotta" element={<Fleet/>}/>
        <Route path="/auto/:id" element={<CarDetails/>}/>
        <Route path="/servizi" element={<Services/>}/>
        <Route path="/chi-siamo" element={<About/>}/>
        <Route path="/contatti" element={<Contact/>}/>
        <Route path="*" element={<Home/>}/>
      </Routes>
      <Footer/>
      <WhatsAppButton/>
    </HashRouter>
  
    </>
)
}
