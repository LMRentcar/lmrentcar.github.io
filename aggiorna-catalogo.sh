#!/bin/bash
set -e

echo "🏎️ Aggiornamento catalogo L.M. RENT CAR..."

mkdir -p backups/catalogo-reale
cp src/data/cars.js backups/catalogo-reale/
cp src/components/CarCard.jsx backups/catalogo-reale/
cp src/pages/Fleet.jsx backups/catalogo-reale/
cp src/pages/CarDetails.jsx backups/catalogo-reale/
cp src/pages/Home.jsx backups/catalogo-reale/
cp src/pages/About.jsx backups/catalogo-reale/
cp src/styles/global.css backups/catalogo-reale/

# Catalogo basato sulle fotografie reali.
# Modelli e caratteristiche non confermati non vengono inventati.
cat > src/data/cars.js <<'EOF'
export const cars = [
  {
    id: 'veicolo-01',
    brand: 'L.M. RENT CAR',
    name: 'Veicolo 01',
    category: 'Auto e veicoli',
    image: '/images/cars/wix-03.jpeg',
    description: 'Contattaci per conoscere modello, caratteristiche e disponibilità.'
  },
  {
    id: 'veicolo-02',
    brand: 'L.M. RENT CAR',
    name: 'Veicolo 02',
    category: 'City car',
    image: '/images/cars/wix-04.jpeg',
    description: 'Contattaci per conoscere caratteristiche e disponibilità.'
  },
  {
    id: 'veicolo-03',
    brand: 'L.M. RENT CAR',
    name: 'Veicolo 03',
    category: 'Auto',
    image: '/images/cars/wix-05.jpeg',
    description: 'Contattaci per conoscere caratteristiche e disponibilità.'
  },
  {
    id: 'veicolo-04',
    brand: 'L.M. RENT CAR',
    name: 'Veicolo 04',
    category: 'City car',
    image: '/images/cars/wix-07.jpeg',
    description: 'Contattaci per conoscere caratteristiche e disponibilità.'
  },
  {
    id: 'veicolo-05',
    brand: 'L.M. RENT CAR',
    name: 'Veicolo 05',
    category: 'City car',
    image: '/images/cars/wix-10.jpeg',
    description: 'Contattaci per conoscere caratteristiche e disponibilità.'
  },
  {
    id: 'veicolo-06',
    brand: 'L.M. RENT CAR',
    name: 'Veicolo 06',
    category: 'Auto',
    image: '/images/cars/wix-11.jpeg',
    description: 'Contattaci per conoscere caratteristiche e disponibilità.'
  }
]
EOF

cat > src/components/CarCard.jsx <<'EOF'
import { Link } from 'react-router-dom'
import { ArrowUpRight } from 'lucide-react'

export default function CarCard({ car }) {
  return (
    <article className="real-car-card">
      <Link to={`/auto/${car.id}`} className="real-car-image">
        <img src={car.image} alt={`${car.name} - L.M. Rent Car`} loading="lazy"/>
      </Link>

      <div className="real-car-info">
        <p className="eyebrow">{car.category}</p>
        <h3>{car.name}</h3>
        <p>Informazioni e disponibilità su richiesta.</p>

        <Link to={`/auto/${car.id}`} className="text-link">
          SCOPRI IL VEICOLO <ArrowUpRight size={18}/>
        </Link>
      </div>
    </article>
  )
}
EOF

cat > src/pages/Fleet.jsx <<'EOF'
import CarCard from '../components/CarCard'
import { cars } from '../data/cars'
import { whatsappLink } from '../data/company'
import { ArrowUpRight } from 'lucide-react'

export default function Fleet() {
  return (
    <main className="inner-page">
      <section className="page-heading">
        <p className="eyebrow">L.M. RENT CAR</p>
        <h1>LA NOSTRA <em>FLOTTA.</em></h1>
        <p>Scopri alcuni dei veicoli presentati da L.M. Rent Car.</p>
      </section>

      <section className="section-pad">
        <div className="cars-grid">
          {cars.map(car => <CarCard key={car.id} car={car}/>)}
        </div>

        <p className="fleet-disclaimer">
          Le immagini provengono dalla galleria aziendale.
          Modelli, disponibilità e condizioni sono da confermare direttamente.
        </p>
      </section>

      <section className="showroom-gallery section-pad">
        <p className="eyebrow">IL NOSTRO PARCO AUTO</p>
        <h2>SCOPRI IL MONDO <em>L.M. RENT CAR.</em></h2>

        <div className="showroom-grid">
          <img src="/images/cars/wix-01.jpeg" alt="Parco auto L.M. Rent Car" loading="lazy"/>
          <img src="/images/cars/wix-02.jpeg" alt="Esposizione veicoli L.M. Rent Car" loading="lazy"/>
          <img src="/images/cars/wix-08.jpeg" alt="Automobili L.M. Rent Car" loading="lazy"/>
          <img src="/images/cars/wix-09.jpeg" alt="Galleria parco auto" loading="lazy"/>
        </div>

        <a
          href={whatsappLink('Buongiorno, vorrei informazioni sui veicoli disponibili.')}
          target="_blank"
          rel="noopener noreferrer"
          className="btn btn-gold"
        >
          CHIEDI DISPONIBILITÀ <ArrowUpRight size={18}/>
        </a>
      </section>
    </main>
  )
}
EOF

cat > src/pages/CarDetails.jsx <<'EOF'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, ArrowUpRight } from 'lucide-react'
import { cars } from '../data/cars'
import { whatsappLink } from '../data/company'

export default function CarDetails() {
  const { id } = useParams()
  const car = cars.find(item => item.id === id)

  if (!car) {
    return (
      <main className="inner-page section-pad">
        <h1>Veicolo non trovato</h1>
        <Link to="/flotta" className="btn btn-gold">TORNA ALLA FLOTTA</Link>
      </main>
    )
  }

  return (
    <main className="inner-page">
      <section className="car-detail-real section-pad">
        <Link to="/flotta" className="text-link">
          <ArrowLeft size={18}/> TORNA ALLA FLOTTA
        </Link>

        <div className="car-detail-grid">
          <div className="car-detail-photo">
            <img src={car.image} alt={car.name}/>
          </div>

          <div className="car-detail-copy">
            <p className="eyebrow">{car.category}</p>
            <h1>{car.name}</h1>
            <p>{car.description}</p>

            <a
              href={whatsappLink(
                `Buongiorno, vorrei informazioni sul ${car.name} presente nella galleria del vostro sito.`
              )}
              target="_blank"
              rel="noopener noreferrer"
              className="btn btn-gold"
            >
              RICHIEDI INFORMAZIONI <ArrowUpRight size={18}/>
            </a>
          </div>
        </div>
      </section>
    </main>
  )
}
EOF

cat > src/pages/About.jsx <<'EOF'
import { ArrowUpRight } from 'lucide-react'
import { whatsappLink } from '../data/company'

export default function About() {
  return (
    <main className="inner-page">
      <section className="page-heading">
        <p className="eyebrow">IL NOSTRO MONDO</p>
        <h1>QUESTA È <em>L.M. RENT CAR.</em></h1>
        <p>Noleggio e vendita auto. La mobilità incontra la passione.</p>
      </section>

      <section className="about-real section-pad">
        <div className="about-real-photo">
          <img src="/images/cars/wix-13.jpeg" alt="Ufficio L.M. Rent Car"/>
        </div>

        <div className="about-real-copy">
          <p className="eyebrow">CHI SIAMO</p>
          <h2>LA TUA STRADA.<br/><em>LA NOSTRA PASSIONE.</em></h2>
          <p>
            L.M. Rent Car si occupa di noleggio e vendita auto.
            Il nostro obiettivo è offrire soluzioni di mobilità
            adatte alle diverse esigenze dei clienti.
          </p>
          <p>
            Per conoscere i veicoli disponibili, le condizioni
            e ricevere un preventivo personalizzato,
            contattaci direttamente.
          </p>

          <a
            href={whatsappLink('Buongiorno, vorrei informazioni su L.M. Rent Car.')}
            target="_blank"
            rel="noopener noreferrer"
            className="btn btn-gold"
          >
            PARLA CON NOI <ArrowUpRight size={18}/>
          </a>
        </div>
      </section>
    </main>
  )
}
EOF

# Aggiorna la Home senza alterare le altre sezioni.
python3 - <<'PY'
from pathlib import Path

p = Path('src/pages/Home.jsx')
s = p.read_text()

s = s.replace(
    'LA FLOTTA <em>PREMIUM.</em>',
    'LA NOSTRA <em>FLOTTA.</em>'
)

s = s.replace(
    '''Anteprima grafica: i veicoli mostrati sono illustrativi e non rappresentano disponibilità confermate.''',
    '''Fotografie dalla galleria L.M. Rent Car. Disponibilità e caratteristiche su richiesta.'''
)

p.write_text(s)
PY

cat >> src/styles/global.css <<'EOF'

/* CATALOGO REALE L.M. RENT CAR */

.real-car-card {
  background: #171717;
  border: 1px solid rgba(215,174,98,.14);
  overflow: hidden;
  transition: transform .3s, border-color .3s;
}

.real-car-card:hover {
  transform: translateY(-5px);
  border-color: rgba(215,174,98,.55);
}

.real-car-image {
  display: block;
  height: 310px;
  overflow: hidden;
  background: #222;
}

.real-car-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform .5s;
}

.real-car-card:hover img {
  transform: scale(1.045);
}

.real-car-info {
  padding: 28px;
}

.real-car-info h3 {
  margin: 10px 0;
  font-size: 26px;
}

.real-car-info > p:not(.eyebrow) {
  color: #aaa;
  margin-bottom: 22px;
}

.fleet-disclaimer {
  color: #999;
  margin-top: 30px;
  font-size: 13px;
}

.showroom-gallery {
  background: #111;
}

.showroom-gallery h2 {
  margin: 15px 0 35px;
}

.showroom-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 18px;
  margin-bottom: 35px;
}

.showroom-grid img {
  width: 100%;
  height: 360px;
  object-fit: cover;
}

.car-detail-grid,
.about-real {
  display: grid;
  grid-template-columns: 1.1fr 1fr;
  gap: 65px;
  align-items: center;
}

.car-detail-grid {
  margin-top: 45px;
}

.car-detail-photo img,
.about-real-photo img {
  width: 100%;
  max-height: 650px;
  object-fit: cover;
}

.car-detail-copy h1 {
  font-size: clamp(40px, 5vw, 75px);
  margin: 15px 0 25px;
}

.car-detail-copy > p:not(.eyebrow),
.about-real-copy p:not(.eyebrow) {
  color: #aaa;
  line-height: 1.9;
  margin-bottom: 25px;
}

.about-real-copy h2 {
  margin: 15px 0 25px;
}

@media(max-width: 800px) {
  .showroom-grid,
  .car-detail-grid,
  .about-real {
    grid-template-columns: 1fr;
  }

  .showroom-grid img {
    height: 250px;
  }

  .real-car-image {
    height: 280px;
  }

  .car-detail-grid,
  .about-real {
    gap: 30px;
  }
}
EOF

echo "🔨 Controllo del sito..."
npm run build

echo ""
echo "✅ CATALOGO AGGIORNATO!"
echo "🌐 http://localhost:5173/"
