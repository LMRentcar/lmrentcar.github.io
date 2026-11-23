#!/bin/bash
set -e

echo "🏎️ Aggiornamento L.M. RENT CAR 2.0..."

mkdir -p src/components src/pages public/images/company

# Backup dei file modificati
mkdir -p backups/update-2
cp src/components/Navbar.jsx backups/update-2/
cp src/components/Footer.jsx backups/update-2/
cp src/components/CarCard.jsx backups/update-2/
cp src/pages/CarDetails.jsx backups/update-2/
cp src/pages/Contact.jsx backups/update-2/
cp src/pages/About.jsx backups/update-2/
cp src/styles/global.css backups/update-2/

# Dati aziendali centralizzati
cat > src/data/company.js <<'EOF'
export const company = {
  name: 'L.M. RENT CAR',
  legalName: 'LM RENT CAR SRLS',
  vat: '11068671210',
  phone: '+39 380 639 3306',
  whatsapp: '393806393306',
  email: 'lmrentcar@outlook.it',
  address: 'Via Ferrari 49, 80036 Palma Campania (NA)',
  tagline: 'Noleggio e Vendita Auto'
}

export function whatsappLink(message) {
  return `https://wa.me/${company.whatsapp}?text=${encodeURIComponent(message)}`
}
EOF

# Nuovo logo testuale
cat > src/components/Logo.jsx <<'EOF'
import { Link } from 'react-router-dom'

export default function Logo() {
  return (
    <Link to="/" className="luxury-logo" aria-label="L.M. Rent Car - Home">
      <span className="luxury-logo-script">L.M.</span>
      <span className="luxury-logo-name">RENT CAR</span>
      <span className="luxury-logo-tagline">Noleggio e Vendita Auto</span>
    </Link>
  )
}
EOF

# Navbar aggiornata
cat > src/components/Navbar.jsx <<'EOF'
import { useState } from 'react'
import { Link, NavLink } from 'react-router-dom'
import { Menu, X, ArrowUpRight } from 'lucide-react'
import Logo from './Logo'
import { whatsappLink } from '../data/company'

export default function Navbar() {
  const [open, setOpen] = useState(false)

  const links = [
    ['/', 'Home'],
    ['/flotta', 'La Flotta'],
    ['/servizi', 'Servizi'],
    ['/chi-siamo', 'Chi Siamo'],
    ['/contatti', 'Contatti']
  ]

  const whatsapp = whatsappLink(
    'Buongiorno, vorrei ricevere informazioni sui servizi di L.M. Rent Car.'
  )

  return (
    <header className="navbar">
      <Logo />

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

        <a
          className="nav-mobile-cta"
          href={whatsapp}
          target="_blank"
          rel="noopener noreferrer"
          onClick={() => setOpen(false)}
        >
          Richiedi preventivo
        </a>
      </nav>

      <a
        href={whatsapp}
        target="_blank"
        rel="noopener noreferrer"
        className="nav-cta"
      >
        WHATSAPP <ArrowUpRight size={16}/>
      </a>

      <button
        className="menu-toggle"
        onClick={() => setOpen(!open)}
        aria-label={open ? 'Chiudi menu' : 'Apri menu'}
        aria-expanded={open}
      >
        {open ? <X/> : <Menu/>}
      </button>
    </header>
  )
}
EOF

# Pulsante WhatsApp fisso
cat > src/components/WhatsAppButton.jsx <<'EOF'
import { MessageCircle } from 'lucide-react'
import { whatsappLink } from '../data/company'

export default function WhatsAppButton() {
  return (
    <a
      className="whatsapp-floating"
      href={whatsappLink(
        'Buongiorno, vorrei ricevere informazioni da L.M. Rent Car.'
      )}
      target="_blank"
      rel="noopener noreferrer"
      aria-label="Contatta L.M. Rent Car su WhatsApp"
      title="Scrivici su WhatsApp"
    >
      <MessageCircle size={27}/>
    </a>
  )
}
EOF

# Aggiornamento App
python3 - <<'PY'
from pathlib import Path

p = Path("src/App.jsx")
s = p.read_text()

if "WhatsAppButton" not in s:
    s = s.replace(
        "import Footer from './components/Footer'",
        "import Footer from './components/Footer'\nimport WhatsAppButton from './components/WhatsAppButton'"
    )
    s = s.replace(
        "<Footer/>",
        "<Footer/>\n      <WhatsAppButton/>"
    )

p.write_text(s)
PY

# Schede auto: preventivo diretto su WhatsApp
python3 - <<'PY'
from pathlib import Path

p = Path("src/pages/CarDetails.jsx")
s = p.read_text()

if "whatsappLink" not in s:
    s = s.replace(
        "import { cars } from '../data/cars'",
        "import { cars } from '../data/cars'\nimport { whatsappLink } from '../data/company'"
    )

s = s.replace(
    '''<Link to="/contatti" className="btn btn-gold">
            RICHIEDI INFORMAZIONI <ArrowUpRight size={18}/>
          </Link>''',
    '''<a
            href={whatsappLink(
              `Buongiorno, vorrei informazioni sulla ${car.brand} ${car.name} mostrata sul sito.`
            )}
            target="_blank"
            rel="noopener noreferrer"
            className="btn btn-gold"
          >
            RICHIEDI PREVENTIVO <ArrowUpRight size={18}/>
          </a>'''
)

p.write_text(s)
PY

# Nuova pagina Contatti
cat > src/pages/Contact.jsx <<'EOF'
import { Phone, Mail, MapPin, MessageCircle, ArrowUpRight } from 'lucide-react'
import { company, whatsappLink } from '../data/company'

export default function Contact() {
  return (
    <main className="inner-page">
      <section className="page-heading">
        <p className="eyebrow">LET'S TALK</p>
        <h1>INIZIA IL TUO <em>VIAGGIO.</em></h1>
        <p>Contattaci per informazioni, disponibilità e preventivi.</p>
      </section>

      <section className="contact-layout section-pad">
        <div>
          <p className="eyebrow">L.M. RENT CAR</p>
          <h2>IL TUO PROSSIMO<br/><em>VIAGGIO INIZIA QUI.</em></h2>
          <p className="contact-description">
            Hai bisogno di un'auto? Contattaci direttamente.
            Ti forniremo tutte le informazioni sulle soluzioni disponibili.
          </p>

          <a
            href={whatsappLink(
              'Buongiorno, vorrei richiedere un preventivo per un noleggio auto.'
            )}
            target="_blank"
            rel="noopener noreferrer"
            className="btn btn-gold"
          >
            SCRIVICI SU WHATSAPP <ArrowUpRight size={18}/>
          </a>
        </div>

        <div className="contact-card">
          <a
            className="contact-row"
            href={whatsappLink('Buongiorno, vorrei informazioni.')}
            target="_blank"
            rel="noopener noreferrer"
          >
            <MessageCircle/>
            <div>
              <strong>WHATSAPP</strong>
              <p>{company.phone}</p>
            </div>
          </a>

          <a className="contact-row" href={`tel:${company.phone.replace(/\s/g, '')}`}>
            <Phone/>
            <div>
              <strong>TELEFONO</strong>
              <p>{company.phone}</p>
            </div>
          </a>

          <a className="contact-row" href={`mailto:${company.email}`}>
            <Mail/>
            <div>
              <strong>EMAIL</strong>
              <p>{company.email}</p>
            </div>
          </a>

          <div className="contact-row">
            <MapPin/>
            <div>
              <strong>SEDE</strong>
              <p>{company.address}</p>
            </div>
          </div>
        </div>
      </section>

      <section className="maps-section">
        <div className="section-heading">
          <div>
            <p className="eyebrow">DOVE SIAMO</p>
            <h2>VIENI A <em>TROVARCI.</em></h2>
          </div>
        </div>

        <iframe
          title="Mappa sede L.M. Rent Car"
          src="https://www.google.com/maps?q=Via%20Ferrari%2049%2C%20Palma%20Campania&output=embed"
          width="100%"
          height="400"
          style={{border:0}}
          loading="lazy"
          referrerPolicy="no-referrer-when-downgrade"
        />
      </section>
    </main>
  )
}
EOF

# Nuovo footer
cat > src/components/Footer.jsx <<'EOF'
import { Link } from 'react-router-dom'
import { ArrowUpRight } from 'lucide-react'
import Logo from './Logo'
import { company, whatsappLink } from '../data/company'

export default function Footer() {
  return (
    <footer className="footer">
      <div className="footer-top">
        <div>
          <Logo/>
          <p>Noleggio e Vendita Auto</p>
          <p>{company.address}</p>
        </div>

        <div className="footer-links">
          <Link to="/">Home</Link>
          <Link to="/flotta">La Flotta</Link>
          <Link to="/servizi">Servizi</Link>
          <Link to="/chi-siamo">Chi Siamo</Link>
          <Link to="/contatti">Contatti</Link>
        </div>

        <a
          href={whatsappLink('Buongiorno, vorrei informazioni.')}
          target="_blank"
          rel="noopener noreferrer"
          className="footer-contact"
        >
          CONTATTACI <ArrowUpRight size={22}/>
        </a>
      </div>

      <div className="footer-bottom">
        <span>© {new Date().getFullYear()} {company.legalName}</span>
        <span>P. IVA {company.vat}</span>
        <span>{company.email}</span>
      </div>
    </footer>
  )
}
EOF

# Stili aggiuntivi
cat >> src/styles/global.css <<'EOF'

/* L.M. RENT CAR - BRAND UPDATE 2.0 */

.luxury-logo {
  display: inline-flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-width: 145px;
  line-height: 1;
  text-align: center;
}

.luxury-logo-script {
  font-family: 'Brush Script MT', 'Snell Roundhand', cursive;
  font-size: 37px;
  font-weight: 500;
  font-style: italic;
  color: #d7ae62;
  text-shadow: 0 1px 12px rgba(201,164,92,.2);
}

.luxury-logo-name {
  font-family: 'Manrope', sans-serif;
  font-size: 13px;
  font-weight: 800;
  letter-spacing: .18em;
  color: #d7ae62;
  margin-top: 2px;
}

.luxury-logo-tagline {
  font-family: Georgia, serif;
  font-style: italic;
  font-size: 8px;
  color: #d7ae62;
  letter-spacing: .02em;
  margin-top: 5px;
}

.whatsapp-floating {
  position: fixed;
  right: 25px;
  bottom: 25px;
  width: 61px;
  height: 61px;
  background: #25d366;
  color: #fff;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 200;
  box-shadow: 0 8px 30px rgba(0,0,0,.35);
  transition: transform .25s;
}

.whatsapp-floating:hover {
  transform: scale(1.1);
}

.maps-section {
  padding: 70px 8% 110px;
  background: #101010;
}

.maps-section iframe {
  filter: grayscale(1) invert(.9) contrast(.9);
  border: 1px solid #333 !important;
}

.contact-row {
  color: inherit;
  text-decoration: none;
}

a.contact-row:hover strong {
  color: #c9a45c;
}

@media (max-width: 760px) {
  .luxury-logo {
    min-width: 110px;
  }

  .luxury-logo-script {
    font-size: 30px;
  }

  .luxury-logo-name {
    font-size: 10px;
  }

  .luxury-logo-tagline {
    font-size: 7px;
  }

  .whatsapp-floating {
    width: 55px;
    height: 55px;
    right: 17px;
    bottom: 17px;
  }

  .maps-section {
    padding: 65px 6%;
  }
}
EOF

echo "🔨 Compilazione del sito..."
npm run build

echo ""
echo "✅ AGGIORNAMENTO L.M. RENT CAR 2.0 COMPLETATO!"
echo "🌐 http://localhost:5173/"
