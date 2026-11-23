#!/bin/bash
set -e

echo "🏎️ Creazione L.M. RENT CAR Luxury Black..."

npm install react-router-dom lucide-react motion

mkdir -p src/components src/pages src/data src/styles public/images

cat > src/data/cars.js <<'EOF'
export const cars = [
  {
    id: "mercedes-classe-a",
    brand: "Mercedes-Benz",
    name: "Classe A",
    category: "Premium",
    transmission: "Automatico",
    fuel: "Diesel",
    seats: 5,
    image: "https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=1200&q=85",
    description: "Eleganza, comfort e tecnologia per ogni viaggio."
  },
  {
    id: "bmw-serie-3",
    brand: "BMW",
    name: "Serie 3",
    category: "Luxury",
    transmission: "Automatico",
    fuel: "Diesel",
    seats: 5,
    image: "https://images.unsplash.com/photo-1555215695-3004980ad54e?w=1200&q=85",
    description: "Prestazioni e piacere di guida senza compromessi."
  },
  {
    id: "audi-a5",
    brand: "Audi",
    name: "A5 Sportback",
    category: "Premium",
    transmission: "Automatico",
    fuel: "Diesel",
    seats: 5,
    image: "https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=1200&q=85",
    description: "Design sportivo e raffinatezza in ogni dettaglio."
  },
  {
    id: "porsche-911",
    brand: "Porsche",
    name: "911 Carrera",
    category: "Sport",
    transmission: "Automatico",
    fuel: "Benzina",
    seats: 4,
    image: "https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=1200&q=85",
    description: "Un'icona di stile e prestazioni."
  },
  {
    id: "range-rover",
    brand: "Range Rover",
    name: "Sport",
    category: "SUV",
    transmission: "Automatico",
    fuel: "Diesel",
    seats: 5,
    image: "https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?w=1200&q=85",
    description: "Presenza imponente e comfort superiore."
  },
  {
    id: "mercedes-classe-c",
    brand: "Mercedes-Benz",
    name: "Classe C",
    category: "Luxury",
    transmission: "Automatico",
    fuel: "Diesel",
    seats: 5,
    image: "https://images.unsplash.com/photo-1563720223185-11003d516935?w=1200&q=85",
    description: "Il perfetto equilibrio tra lusso e dinamismo."
  }
]
EOF

cat > src/components/Navbar.jsx <<'EOF'
import { useState } from 'react'
import { Link, NavLink } from 'react-router-dom'
import { Menu, X, ArrowUpRight } from 'lucide-react'

export default function Navbar() {
  const [open, setOpen] = useState(false)

  const links = [
    ['/', 'Home'],
    ['/flotta', 'La Flotta'],
    ['/servizi', 'Servizi'],
    ['/chi-siamo', 'Chi Siamo'],
    ['/contatti', 'Contatti']
  ]

  return (
    <header className="navbar">
      <Link to="/" className="brand" onClick={() => setOpen(false)}>
        <span className="brand-main">L.M.</span>
        <span className="brand-sub">RENT CAR</span>
      </Link>

      <nav className={open ? 'nav-links open' : 'nav-links'}>
        {links.map(([path, label]) => (
          <NavLink
            key={path}
            to={path}
            end={path === '/'}
            onClick={() => setOpen(false)}
          >
            {label}
          </NavLink>
        ))}
        <Link className="nav-mobile-cta" to="/contatti" onClick={() => setOpen(false)}>
          Richiedi preventivo
        </Link>
      </nav>

      <Link to="/contatti" className="nav-cta">
        PRENOTA ORA <ArrowUpRight size={16}/>
      </Link>

      <button
        className="menu-toggle"
        onClick={() => setOpen(!open)}
        aria-label="Apri menu"
        aria-expanded={open}
      >
        {open ? <X/> : <Menu/>}
      </button>
    </header>
  )
}
EOF

cat > src/components/Footer.jsx <<'EOF'
import { Link } from 'react-router-dom'
import { ArrowUpRight, Instagram, Facebook } from 'lucide-react'

export default function Footer() {
  return (
    <footer className="footer">
      <div className="footer-top">
        <div>
          <div className="footer-logo">L.M. <span>RENT CAR</span></div>
          <p>Il tuo viaggio. Il nostro stile.</p>
        </div>

        <div className="footer-links">
          <Link to="/">Home</Link>
          <Link to="/flotta">La Flotta</Link>
          <Link to="/servizi">Servizi</Link>
          <Link to="/chi-siamo">Chi Siamo</Link>
          <Link to="/contatti">Contatti</Link>
        </div>

        <Link to="/contatti" className="footer-contact">
          PARLIAMONE <ArrowUpRight size={22}/>
        </Link>
      </div>

      <div className="footer-bottom">
        <span>© {new Date().getFullYear()} L.M. RENT CAR</span>
        <span>DRIVE YOUR EXPERIENCE.</span>
        <span>Luxury Black Edition</span>
      </div>
    </footer>
  )
}
EOF

cat > src/components/CarCard.jsx <<'EOF'
import { Link } from 'react-router-dom'
import { ArrowUpRight, Fuel, Users, Gauge } from 'lucide-react'
import { motion } from 'motion/react'

export default function CarCard({ car }) {
  return (
    <motion.article
      className="car-card"
      initial={{ opacity: 0, y: 35 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.55 }}
    >
      <Link to={`/auto/${car.id}`} className="car-image">
        <img src={car.image} alt={`${car.brand} ${car.name} - foto illustrativa`} loading="lazy"/>
        <span className="car-category">{car.category}</span>
      </Link>

      <div className="car-content">
        <p className="car-brand">{car.brand}</p>
        <h3>{car.name}</h3>

        <div className="car-specs">
          <span><Gauge size={15}/> {car.transmission}</span>
          <span><Fuel size={15}/> {car.fuel}</span>
          <span><Users size={15}/> {car.seats} posti</span>
        </div>

        <Link to={`/auto/${car.id}`} className="car-button">
          SCOPRI IL VEICOLO <ArrowUpRight size={18}/>
        </Link>
      </div>
    </motion.article>
  )
}
EOF

cat > src/pages/Home.jsx <<'EOF'
import { Link } from 'react-router-dom'
import { ArrowUpRight, ArrowDown, ShieldCheck, Gem, Clock3 } from 'lucide-react'
import { motion } from 'motion/react'
import { cars } from '../data/cars'
import CarCard from '../components/CarCard'

export default function Home() {
  return (
    <>
      <section className="hero">
        <div className="hero-image"/>
        <div className="hero-shade"/>

        <div className="hero-content">
          <motion.div
            initial={{ opacity: 0, y: 25 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8 }}
          >
            <p className="eyebrow"><span className="gold-line"/> L.M. RENT CAR EXPERIENCE</p>
            <h1>DRIVE YOUR<br/><em>EXPERIENCE.</em></h1>
            <p className="hero-description">
              Ogni viaggio merita qualcosa di straordinario.
              Scopri una nuova idea di libertà, stile ed eleganza.
            </p>

            <div className="hero-actions">
              <Link to="/flotta" className="btn btn-gold">
                ESPLORA LA FLOTTA <ArrowUpRight size={18}/>
              </Link>
              <Link to="/contatti" className="btn btn-outline">
                RICHIEDI PREVENTIVO
              </Link>
            </div>
          </motion.div>
        </div>

        <a href="#flotta" className="scroll-hint">
          SCOPRI DI PIÙ <ArrowDown size={17}/>
        </a>

        <div className="hero-index">01 / 04</div>
      </section>

      <section className="intro section-pad">
        <p className="eyebrow centered">L'ECCELLENZA SU STRADA</p>
        <h2>NON È SOLO UN'AUTO.<br/><em>È UN'ESPERIENZA.</em></h2>
        <p>
          Il piacere di scegliere il proprio viaggio.
          Un'esperienza di noleggio pensata per accompagnarti
          con stile, comfort e libertà.
        </p>
      </section>

      <section className="fleet-section section-pad" id="flotta">
        <div className="section-heading">
          <div>
            <p className="eyebrow">LA NOSTRA SELEZIONE</p>
            <h2>LA FLOTTA <em>PREMIUM.</em></h2>
          </div>
          <Link to="/flotta" className="text-link">
            VEDI TUTTE LE AUTO <ArrowUpRight size={18}/>
          </Link>
        </div>

        <p className="demo-notice">
          Anteprima grafica: i veicoli mostrati sono illustrativi e non rappresentano disponibilità confermate.
        </p>

        <div className="cars-grid">
          {cars.slice(0, 3).map(car => <CarCard key={car.id} car={car}/>)}
        </div>
      </section>

      <section className="experience-banner">
        <div className="experience-overlay"/>
        <div className="experience-content">
          <p className="eyebrow">BEYOND THE ORDINARY</p>
          <h2>IL LUSSO DI<br/><em>ANDARE OLTRE.</em></h2>
          <p>La strada è tua. Scegli come viverla.</p>
          <Link to="/servizi" className="btn btn-gold">
            SCOPRI DI PIÙ <ArrowUpRight size={18}/>
          </Link>
        </div>
      </section>

      <section className="values section-pad">
        <div className="section-heading">
          <div>
            <p className="eyebrow">IL NOSTRO APPROCCIO</p>
            <h2>OGNI DETTAGLIO <em>CONTA.</em></h2>
          </div>
        </div>

        <div className="values-grid">
          <div className="value-card">
            <Gem size={32}/>
            <span>01</span>
            <h3>STILE</h3>
            <p>Un'esperienza curata in ogni dettaglio.</p>
          </div>
          <div className="value-card">
            <ShieldCheck size={32}/>
            <span>02</span>
            <h3>FIDUCIA</h3>
            <p>Un rapporto costruito sulla chiarezza.</p>
          </div>
          <div className="value-card">
            <Clock3 size={32}/>
            <span>03</span>
            <h3>LIBERTÀ</h3>
            <p>Il piacere di vivere ogni viaggio a modo tuo.</p>
          </div>
        </div>
      </section>

      <section className="final-cta">
        <p className="eyebrow">YOUR NEXT JOURNEY STARTS HERE</p>
        <h2>PRONTO A <em>PARTIRE?</em></h2>
        <Link to="/contatti" className="btn btn-gold">
          RICHIEDI UN PREVENTIVO <ArrowUpRight size={18}/>
        </Link>
      </section>
    </>
  )
}
EOF

cat > src/pages/Fleet.jsx <<'EOF'
import { useState } from 'react'
import { cars } from '../data/cars'
import CarCard from '../components/CarCard'

export default function Fleet() {
  const [filter, setFilter] = useState('Tutte')
  const categories = ['Tutte', ...new Set(cars.map(c => c.category))]
  const filtered = filter === 'Tutte' ? cars : cars.filter(c => c.category === filter)

  return (
    <main className="inner-page">
      <section className="page-heading">
        <p className="eyebrow">THE COLLECTION</p>
        <h1>LA NOSTRA <em>FLOTTA.</em></h1>
        <p>Scopri il piacere di guidare qualcosa di speciale.</p>
      </section>

      <section className="fleet-section section-pad">
        <div className="filters">
          {categories.map(category => (
            <button
              key={category}
              className={filter === category ? 'filter active' : 'filter'}
              onClick={() => setFilter(category)}
            >
              {category}
            </button>
          ))}
        </div>

        <p className="demo-notice">
          Catalogo dimostrativo: modelli, fotografie e caratteristiche da confermare.
        </p>

        <div className="cars-grid">
          {filtered.map(car => <CarCard key={car.id} car={car}/>)}
        </div>
      </section>
    </main>
  )
}
EOF

cat > src/pages/CarDetails.jsx <<'EOF'
import { useParams, Link } from 'react-router-dom'
import { ArrowLeft, ArrowUpRight, Fuel, Gauge, Users } from 'lucide-react'
import { cars } from '../data/cars'

export default function CarDetails() {
  const { id } = useParams()
  const car = cars.find(c => c.id === id)

  if (!car) {
    return (
      <main className="inner-page page-heading">
        <h1>AUTO NON TROVATA</h1>
        <Link to="/flotta" className="btn btn-gold">TORNA ALLA FLOTTA</Link>
      </main>
    )
  }

  return (
    <main className="inner-page">
      <section className="detail-layout">
        <div className="detail-image">
          <img src={car.image} alt={`${car.brand} ${car.name} - foto illustrativa`}/>
        </div>

        <div className="detail-info">
          <Link to="/flotta" className="back-link"><ArrowLeft size={17}/> TORNA ALLA FLOTTA</Link>
          <p className="eyebrow">{car.brand} / {car.category}</p>
          <h1>{car.name}</h1>
          <div className="gold-divider"/>
          <p className="detail-description">{car.description}</p>

          <div className="detail-specs">
            <div><Gauge/><span>CAMBIO</span><strong>{car.transmission}</strong></div>
            <div><Fuel/><span>ALIMENTAZIONE</span><strong>{car.fuel}</strong></div>
            <div><Users/><span>POSTI</span><strong>{car.seats}</strong></div>
          </div>

          <p className="demo-notice">
            Scheda dimostrativa. Modello e disponibilità da verificare.
          </p>

          <Link to="/contatti" className="btn btn-gold">
            RICHIEDI INFORMAZIONI <ArrowUpRight size={18}/>
          </Link>
        </div>
      </section>
    </main>
  )
}
EOF

cat > src/pages/Services.jsx <<'EOF'
import { Link } from 'react-router-dom'
import { ArrowUpRight, CarFront, MessageCircle, Sparkles } from 'lucide-react'

export default function Services() {
  return (
    <main className="inner-page">
      <section className="page-heading">
        <p className="eyebrow">L.M. RENT CAR EXPERIENCE</p>
        <h1>I NOSTRI <em>SERVIZI.</em></h1>
        <p>Un nuovo modo di vivere la strada.</p>
      </section>

      <section className="section-pad">
        <p className="demo-notice">
          Questa sezione presenta il concept del sito. I servizi effettivamente offerti saranno confermati con l'azienda.
        </p>
        <div className="values-grid">
          <div className="value-card">
            <CarFront size={35}/>
            <h3>NOLEGGIO AUTO</h3>
            <p>Scopri le soluzioni di mobilità disponibili.</p>
          </div>
          <div className="value-card">
            <MessageCircle size={35}/>
            <h3>PREVENTIVI</h3>
            <p>Contattaci per informazioni e richieste personalizzate.</p>
          </div>
          <div className="value-card">
            <Sparkles size={35}/>
            <h3>ESPERIENZA</h3>
            <p>Un approccio orientato alla qualità del viaggio.</p>
          </div>
        </div>
      </section>

      <section className="final-cta">
        <h2>IL TUO VIAGGIO <em>INIZIA QUI.</em></h2>
        <Link to="/contatti" className="btn btn-gold">
          CONTATTACI <ArrowUpRight size={18}/>
        </Link>
      </section>
    </main>
  )
}
EOF

cat > src/pages/About.jsx <<'EOF'
import { Link } from 'react-router-dom'
import { ArrowUpRight } from 'lucide-react'

export default function About() {
  return (
    <main className="inner-page">
      <section className="page-heading">
        <p className="eyebrow">THE BRAND</p>
        <h1>QUESTA È <em>L.M. RENT CAR.</em></h1>
        <p>La passione per il viaggio incontra lo stile.</p>
      </section>

      <section className="about-layout section-pad">
        <div className="about-image"/>
        <div className="about-text">
          <p className="eyebrow">CHI SIAMO</p>
          <h2>NON SOLO<br/><em>MOBILITÀ.</em></h2>
          <p>
            L.M. Rent Car è il brand al centro di questo progetto.
            Stiamo preparando una presentazione autentica dell'azienda,
            della sua storia e dei suoi valori.
          </p>
          <p>
            Questa prima versione mostra l'identità visiva che vogliamo
            costruire: moderna, essenziale e riconoscibile.
          </p>
          <Link to="/contatti" className="btn btn-gold">
            CONTATTACI <ArrowUpRight size={18}/>
          </Link>
        </div>
      </section>
    </main>
  )
}
EOF

cat > src/pages/Contact.jsx <<'EOF'
import { Link } from 'react-router-dom'
import { ArrowUpRight, MapPin, MessageCircle, Mail } from 'lucide-react'

export default function Contact() {
  return (
    <main className="inner-page">
      <section className="page-heading">
        <p className="eyebrow">LET'S TALK</p>
        <h1>INIZIA IL TUO <em>VIAGGIO.</em></h1>
        <p>Il prossimo viaggio comincia da una semplice richiesta.</p>
      </section>

      <section className="contact-layout section-pad">
        <div>
          <p className="eyebrow">CONTATTI</p>
          <h2>PARLIAMO DEL TUO<br/><em>PROSSIMO VIAGGIO.</em></h2>
          <p className="contact-description">
            Stiamo completando i recapiti ufficiali.
            Presto potrai richiedere informazioni e preventivi
            direttamente da questa pagina.
          </p>
        </div>

        <div className="contact-card">
          <div className="contact-row">
            <MessageCircle/>
            <div>
              <strong>WHATSAPP</strong>
              <p>Numero ufficiale da inserire</p>
            </div>
          </div>
          <div className="contact-row">
            <Mail/>
            <div>
              <strong>EMAIL</strong>
              <p>Indirizzo ufficiale da inserire</p>
            </div>
          </div>
          <div className="contact-row">
            <MapPin/>
            <div>
              <strong>SEDE</strong>
              <p>Indirizzo da confermare</p>
            </div>
          </div>
          <Link to="/flotta" className="btn btn-gold">
            ESPLORA LA FLOTTA <ArrowUpRight size={18}/>
          </Link>
        </div>
      </section>
    </main>
  )
}
EOF

cat > src/App.jsx <<'EOF'
import { BrowserRouter, Routes, Route, useLocation } from 'react-router-dom'
import { useEffect } from 'react'
import Navbar from './components/Navbar'
import Footer from './components/Footer'
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
    <BrowserRouter>
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
    </BrowserRouter>
  )
}
EOF

cat > src/styles/global.css <<'EOF'
@import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap');

:root {
  font-family: 'DM Sans', sans-serif;
  color: #fff;
  background: #090909;
  font-synthesis: none;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
}

* { box-sizing: border-box; }

html { scroll-behavior: smooth; }

body {
  margin: 0;
  min-width: 320px;
  background: #090909;
}

a { color: inherit; text-decoration: none; }
button { font: inherit; cursor: pointer; }
img { display: block; max-width: 100%; }

::selection { background: #c9a45c; color: #080808; }

h1, h2, h3, p { margin-top: 0; }

h1, h2, h3 {
  font-family: 'Manrope', sans-serif;
}

h1, h2 {
  letter-spacing: -0.065em;
  font-weight: 800;
}

h1 em, h2 em {
  font-style: normal;
  color: #c9a45c;
}

.navbar {
  height: 88px;
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 6%;
  border-bottom: 1px solid rgba(255,255,255,.13);
  background: rgba(0,0,0,.32);
  backdrop-filter: blur(16px);
}

.brand {
  display: flex;
  flex-direction: column;
  line-height: 1;
  min-width: 140px;
}

.brand-main {
  font-family: 'Manrope', sans-serif;
  font-size: 32px;
  font-weight: 800;
  letter-spacing: -.08em;
}

.brand-sub {
  color: #c9a45c;
  font-size: 9px;
  letter-spacing: .48em;
  margin-top: 5px;
  font-weight: 700;
}

.nav-links {
  display: flex;
  gap: 35px;
  align-items: center;
}

.nav-links a {
  color: #d3d3d3;
  font-size: 12px;
  font-weight: 700;
  transition: color .25s;
}

.nav-links a:hover,
.nav-links a.active { color: #c9a45c; }

.nav-cta {
  display: flex;
  align-items: center;
  gap: 12px;
  border: 1px solid #c9a45c;
  color: #c9a45c;
  padding: 14px 19px;
  font-size: 11px;
  font-weight: 800;
  letter-spacing: .07em;
  transition: .25s;
}

.nav-cta:hover {
  background: #c9a45c;
  color: #080808;
}

.menu-toggle, .nav-mobile-cta { display: none; }

.hero {
  height: min(900px, 100svh);
  min-height: 650px;
  position: relative;
  overflow: hidden;
  display: flex;
  align-items: center;
}

.hero-image {
  position: absolute;
  inset: 0;
  background:
    url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=2200&q=90')
    center 54% / cover no-repeat;
  animation: heroZoom 16s ease-out both;
}

@keyframes heroZoom {
  from { transform: scale(1.08); }
  to { transform: scale(1); }
}

.hero-shade {
  position: absolute;
  inset: 0;
  background:
    linear-gradient(90deg, rgba(0,0,0,.94) 0%, rgba(0,0,0,.75) 35%, rgba(0,0,0,.13) 100%),
    linear-gradient(0deg, #090909 0%, transparent 28%, rgba(0,0,0,.22) 100%);
}

.hero-content {
  position: relative;
  z-index: 2;
  width: 100%;
  max-width: 1600px;
  margin: 0 auto;
  padding: 90px 8% 0;
}

.eyebrow {
  color: #c9a45c;
  font-size: 11px;
  font-weight: 800;
  letter-spacing: .26em;
  margin-bottom: 26px;
}

.gold-line {
  display: inline-block;
  width: 35px;
  height: 1px;
  background: #c9a45c;
  vertical-align: middle;
  margin-right: 13px;
}

.hero h1 {
  font-size: clamp(60px, 7.4vw, 125px);
  line-height: 1.02;
  margin-bottom: 28px;
}

.hero-description {
  max-width: 470px;
  color: #c7c7c7;
  font-size: 15px;
  line-height: 1.9;
  margin-bottom: 35px;
}

.hero-actions {
  display: flex;
  gap: 13px;
  flex-wrap: wrap;
}

.btn {
  display: inline-flex;
  justify-content: center;
  align-items: center;
  gap: 24px;
  min-height: 53px;
  padding: 16px 25px;
  font-size: 11px;
  font-weight: 800;
  letter-spacing: .07em;
  transition: .25s ease;
}

.btn-gold {
  background: #c9a45c;
  color: #080808;
  border: 1px solid #c9a45c;
}

.btn-gold:hover {
  background: #e4c580;
  border-color: #e4c580;
  transform: translateY(-2px);
}

.btn-outline {
  border: 1px solid rgba(255,255,255,.5);
  color: #fff;
}

.btn-outline:hover {
  border-color: #c9a45c;
  color: #c9a45c;
}

.scroll-hint {
  position: absolute;
  bottom: 55px;
  left: 8%;
  z-index: 3;
  display: flex;
  align-items: center;
  gap: 18px;
  color: #ddd;
  font-size: 10px;
  letter-spacing: .15em;
}

.hero-index {
  position: absolute;
  bottom: 55px;
  right: 8%;
  z-index: 3;
  color: #c9a45c;
  font-size: 12px;
  letter-spacing: .2em;
}

.section-pad { padding: 110px 8%; }

.intro {
  text-align: center;
  max-width: 1100px;
  margin: auto;
  padding-top: 130px;
  padding-bottom: 130px;
}

.intro h2 {
  font-size: clamp(35px, 5vw, 70px);
  line-height: 1.15;
}

.intro > p:last-child {
  color: #999;
  max-width: 590px;
  margin: 25px auto 0;
  line-height: 1.9;
  font-size: 15px;
}

.centered { text-align: center; }

.fleet-section { background: #101010; }

.section-heading {
  display: flex;
  align-items: end;
  justify-content: space-between;
  gap: 30px;
  margin-bottom: 45px;
}

.section-heading h2 {
  font-size: clamp(35px, 4vw, 65px);
  margin-bottom: 0;
}

.text-link {
  color: #c9a45c;
  display: inline-flex;
  gap: 15px;
  align-items: center;
  white-space: nowrap;
  font-size: 11px;
  font-weight: 800;
  letter-spacing: .08em;
  padding-bottom: 9px;
}

.demo-notice {
  color: #a7a7a7;
  font-size: 12px;
  line-height: 1.7;
  margin-bottom: 28px;
}

.cars-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 24px;
}

.car-card {
  background: #191919;
  border: 1px solid #292929;
  overflow: hidden;
  transition: border-color .3s;
}

.car-card:hover { border-color: #80683d; }

.car-image {
  height: 245px;
  display: block;
  position: relative;
  overflow: hidden;
  background: #222;
}

.car-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform .6s;
}

.car-card:hover .car-image img { transform: scale(1.07); }

.car-category {
  position: absolute;
  top: 18px;
  left: 18px;
  background: #c9a45c;
  color: #090909;
  padding: 8px 12px;
  font-size: 10px;
  font-weight: 800;
  text-transform: uppercase;
  letter-spacing: .1em;
}

.car-content { padding: 26px; }

.car-brand {
  color: #c9a45c;
  font-size: 11px;
  letter-spacing: .16em;
  text-transform: uppercase;
  margin-bottom: 7px;
}

.car-content h3 {
  font-size: 25px;
  letter-spacing: -.04em;
  margin-bottom: 23px;
}

.car-specs {
  display: flex;
  flex-wrap: wrap;
  gap: 15px;
  border-top: 1px solid #333;
  border-bottom: 1px solid #333;
  padding: 19px 0;
}

.car-specs span {
  color: #aaa;
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 11px;
}

.car-specs svg { color: #c9a45c; }

.car-button {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 24px;
  color: #c9a45c;
  font-size: 11px;
  font-weight: 800;
  letter-spacing: .06em;
}

.experience-banner {
  min-height: 580px;
  position: relative;
  display: flex;
  align-items: center;
  background:
    url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=2000&q=85')
    center / cover;
}

.experience-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(90deg, #000 0%, rgba(0,0,0,.75) 42%, rgba(0,0,0,.25) 100%);
}

.experience-content {
  position: relative;
  padding: 100px 8%;
}

.experience-content h2 {
  font-size: clamp(48px, 6vw, 90px);
  line-height: 1.07;
}

.experience-content > p:not(.eyebrow) {
  color: #ccc;
  margin-bottom: 30px;
}

.values { background: #090909; }

.values-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
}

.value-card {
  padding: 45px 35px;
  background: #151515;
  border: 1px solid #292929;
  min-height: 260px;
}

.value-card svg {
  color: #c9a45c;
  margin-bottom: 35px;
}

.value-card > span {
  display: block;
  color: #666;
  font-size: 12px;
  margin-bottom: 10px;
}

.value-card h3 {
  font-size: 22px;
  letter-spacing: -.03em;
}

.value-card p {
  color: #999;
  line-height: 1.8;
  font-size: 13px;
}

.final-cta {
  text-align: center;
  padding: 110px 20px;
  background: #151515;
  border-top: 1px solid #292929;
}

.final-cta h2 {
  font-size: clamp(40px, 6vw, 85px);
  margin-bottom: 35px;
}

.footer {
  background: #050505;
  padding: 75px 8% 25px;
}

.footer-top {
  display: flex;
  justify-content: space-between;
  align-items: start;
  gap: 35px;
  padding-bottom: 75px;
}

.footer-logo {
  font-size: 37px;
  font-weight: 800;
  letter-spacing: -.07em;
}

.footer-logo span {
  color: #c9a45c;
  font-size: 13px;
  letter-spacing: .1em;
}

.footer-top p {
  color: #888;
  margin-top: 15px;
  font-size: 13px;
}

.footer-links {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.footer-links a {
  color: #aaa;
  font-size: 13px;
}

.footer-links a:hover { color: #c9a45c; }

.footer-contact {
  display: flex;
  gap: 18px;
  align-items: center;
  font-size: 13px;
  font-weight: 800;
  color: #c9a45c;
}

.footer-bottom {
  border-top: 1px solid #292929;
  padding-top: 25px;
  display: flex;
  justify-content: space-between;
  gap: 20px;
  color: #666;
  font-size: 10px;
  letter-spacing: .08em;
}

.inner-page { padding-top: 88px; }

.page-heading {
  padding: 115px 8% 95px;
  background:
    radial-gradient(ellipse at 80% 20%, #292218 0%, transparent 50%),
    #101010;
  border-bottom: 1px solid #292929;
}

.page-heading h1 {
  font-size: clamp(48px, 7vw, 100px);
  line-height: 1.1;
  margin-bottom: 22px;
}

.page-heading > p:last-child {
  color: #aaa;
  line-height: 1.8;
}

.filters {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
  margin-bottom: 35px;
}

.filter {
  padding: 12px 22px;
  background: transparent;
  color: #aaa;
  border: 1px solid #333;
  font-size: 12px;
}

.filter.active, .filter:hover {
  background: #c9a45c;
  border-color: #c9a45c;
  color: #090909;
}

.detail-layout {
  min-height: 750px;
  display: grid;
  grid-template-columns: 1.15fr 1fr;
}

.detail-image {
  min-height: 650px;
  background: #191919;
}

.detail-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.detail-info {
  padding: 100px 10%;
  display: flex;
  flex-direction: column;
  align-items: start;
  justify-content: center;
}

.back-link {
  color: #aaa;
  display: flex;
  gap: 10px;
  align-items: center;
  font-size: 11px;
  margin-bottom: 65px;
}

.detail-info h1 {
  font-size: clamp(50px, 5vw, 85px);
  line-height: 1.05;
}

.gold-divider {
  width: 65px;
  height: 2px;
  background: #c9a45c;
  margin: 20px 0 30px;
}

.detail-description {
  color: #aaa;
  line-height: 1.9;
}

.detail-specs {
  display: flex;
  flex-wrap: wrap;
  gap: 35px;
  margin: 30px 0;
}

.detail-specs div {
  display: flex;
  flex-direction: column;
  gap: 9px;
}

.detail-specs svg { color: #c9a45c; }

.detail-specs span {
  color: #888;
  font-size: 10px;
}

.detail-specs strong { font-size: 13px; }

.about-layout {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 8%;
  align-items: center;
}

.about-image {
  min-height: 570px;
  background:
    url('https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=1200&q=85')
    center / cover;
}

.about-text h2,
.contact-layout h2 {
  font-size: clamp(40px, 4vw, 65px);
  line-height: 1.1;
}

.about-text > p:not(.eyebrow),
.contact-description {
  color: #aaa;
  line-height: 1.9;
  margin-bottom: 25px;
}

.contact-layout {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10%;
}

.contact-card {
  background: #171717;
  padding: 45px;
  border: 1px solid #303030;
}

.contact-row {
  display: flex;
  gap: 20px;
  border-bottom: 1px solid #333;
  padding: 22px 0;
}

.contact-row svg { color: #c9a45c; }

.contact-row strong {
  font-size: 12px;
  letter-spacing: .1em;
}

.contact-row p {
  color: #999;
  margin: 10px 0 0;
  font-size: 13px;
}

.contact-card .btn { margin-top: 35px; }

@media (max-width: 1100px) {
  .nav-links { gap: 18px; }
  .navbar { padding: 0 4%; }
  .nav-cta { display: none; }
  .cars-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
}

@media (max-width: 760px) {
  .navbar { height: 74px; padding: 0 6%; }

  .brand-main { font-size: 28px; }

  .menu-toggle {
    display: flex;
    align-items: center;
    justify-content: center;
    background: transparent;
    color: #fff;
    border: 0;
  }

  .nav-links {
    display: none;
    position: absolute;
    top: 74px;
    left: 0;
    right: 0;
    padding: 30px 6%;
    background: #111;
    flex-direction: column;
    align-items: stretch;
    gap: 0;
    border-bottom: 1px solid #333;
  }

  .nav-links.open { display: flex; }

  .nav-links a {
    padding: 15px 0;
    font-size: 15px;
  }

  .nav-mobile-cta {
    display: block !important;
    color: #c9a45c !important;
  }

  .hero {
    min-height: 700px;
    height: 92svh;
  }

  .hero-image { background-position: 61% center; }

  .hero-shade {
    background:
      linear-gradient(90deg, rgba(0,0,0,.84), rgba(0,0,0,.28)),
      linear-gradient(0deg, #090909, transparent 45%);
  }

  .hero-content { padding: 50px 7% 0; }

  .hero h1 {
    font-size: clamp(46px, 11vw, 75px);
  }

  .hero-description { font-size: 13px; }

  .hero-actions { flex-direction: column; align-items: start; }

  .scroll-hint { left: 7%; bottom: 30px; }

  .hero-index { right: 7%; bottom: 30px; }

  .section-pad { padding: 75px 6%; }

  .intro { padding: 90px 6%; }

  .section-heading {
    flex-direction: column;
    align-items: start;
  }

  .cars-grid { grid-template-columns: 1fr; }

  .car-image { height: 270px; }

  .values-grid { grid-template-columns: 1fr; }

  .value-card { min-height: auto; }

  .experience-banner { min-height: 520px; }

  .experience-content { padding: 75px 6%; }

  .footer { padding: 65px 6% 25px; }

  .footer-top { flex-direction: column; padding-bottom: 45px; }

  .footer-bottom { flex-direction: column; gap: 10px; }

  .inner-page { padding-top: 74px; }

  .page-heading { padding: 80px 6%; }

  .detail-layout { grid-template-columns: 1fr; }

  .detail-image { min-height: 350px; height: 400px; }

  .detail-info { padding: 60px 6%; }

  .back-link { margin-bottom: 40px; }

  .about-layout, .contact-layout {
    grid-template-columns: 1fr;
    gap: 45px;
  }

  .about-image { min-height: 350px; }

  .contact-card { padding: 25px; }
}

@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: .01ms !important;
    transition-duration: .01ms !important;
    scroll-behavior: auto !important;
  }
}
EOF

cat > src/index.css <<'EOF'
/* Global styles are imported from App.jsx */
EOF

cat > index.html <<'EOF'
<!doctype html>
<html lang="it">
  <head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="theme-color" content="#090909"/>
    <meta name="description" content="L.M. Rent Car. Scopri il nostro mondo e richiedi informazioni sulle soluzioni di noleggio auto."/>
    <title>L.M. RENT CAR | Drive Your Experience</title>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOF

echo "🔨 Verifica compilazione..."
npm run build

echo ""
echo "✅ L.M. RENT CAR LUXURY BLACK CREATO!"
echo "🌐 Apri http://localhost:5173/"
