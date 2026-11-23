#!/bin/bash
set -e

echo "🏎️ L.M. RENT CAR — CATALOGO 4.0"

mkdir -p public/images/cars/licensed
mkdir -p backups/catalogo-4

cp src/data/cars.js backups/catalogo-4/
cp src/components/CarCard.jsx backups/catalogo-4/
cp src/pages/Fleet.jsx backups/catalogo-4/
cp src/pages/CarDetails.jsx backups/catalogo-4/
cp src/styles/global.css backups/catalogo-4/

echo "📸 Download immagini con licenze Creative Commons..."

python3 - <<'PY'
import json
import urllib.request
import urllib.parse
from pathlib import Path

folder = Path("public/images/cars/licensed")
folder.mkdir(parents=True, exist_ok=True)

photos = [
    {
        "filename": "fiat-panda.jpg",
        "commons": "2012 FIAT Panda Easy - 1242cc 1.2 (69PS) Petrol - White - 04-2024, Front.jpg",
        "author": "Harvey Bold",
        "license": "CC BY 4.0",
        "license_url": "https://creativecommons.org/licenses/by/4.0/"
    },
    {
        "filename": "fiat-500x.jpg",
        "commons": '"15 - ITALY - White premium SUV - Fiat 500X Urban in Milan 04.jpg',
        "author": "Pava",
        "license": "CC BY-SA 3.0 IT",
        "license_url": "https://creativecommons.org/licenses/by-sa/3.0/it/"
    },
    {
        "filename": "smart-fortwo.jpg",
        "commons": "2007 Smart fortwo black front.jpg",
        "author": "Matti Blume",
        "license": "CC BY-SA 3.0",
        "license_url": "https://creativecommons.org/licenses/by-sa/3.0/"
    }
]

api = "https://commons.wikimedia.org/w/api.php"

for photo in photos:
    title = "File:" + photo["commons"]

    query = urllib.parse.urlencode({
        "action": "query",
        "titles": title,
        "prop": "imageinfo",
        "iiprop": "url|mime|extmetadata",
        "iiurlwidth": 1400,
        "format": "json"
    })

    request = urllib.request.Request(
        api + "?" + query,
        headers={
            "User-Agent": "LMRentCarWebsite/1.0 (website photo attribution)",
            "Accept": "application/json"
        }
    )

    with urllib.request.urlopen(request, timeout=30) as response:
        data = json.load(response)

    pages = data["query"]["pages"]
    page = next(iter(pages.values()))

    if "imageinfo" not in page:
        raise RuntimeError(f"Immagine non trovata: {title}")

    info = page["imageinfo"][0]

    if not info.get("mime", "").startswith("image/"):
        raise RuntimeError(f"Formato non valido: {title}")

    metadata = info.get("extmetadata", {})
    license_code = metadata.get("LicenseShortName", {}).get("value", "")

    if "CC BY" not in license_code.upper():
        raise RuntimeError(
            f"Licenza inattesa per {title}: {license_code}"
        )

    image_url = info.get("thumburl") or info["url"]

    image_request = urllib.request.Request(
        image_url,
        headers={
            "User-Agent": "LMRentCarWebsite/1.0 (website photo attribution)"
        }
    )

    with urllib.request.urlopen(image_request, timeout=40) as response:
        image_data = response.read()

    if len(image_data) < 10000:
        raise RuntimeError(f"Download incompleto: {title}")

    # Il formato restituito deve essere JPEG.
    if not image_data.startswith(b"\xff\xd8\xff"):
        raise RuntimeError(f"Il file non è JPEG: {title}")

    (folder / photo["filename"]).write_bytes(image_data)

    photo["source_url"] = (
        "https://commons.wikimedia.org/wiki/"
        + urllib.parse.quote(title.replace(" ", "_"))
    )

    print("✅", photo["filename"], "-", license_code)

(folder / "photo-credits.json").write_text(
    json.dumps(photos, ensure_ascii=False, indent=2),
    encoding="utf-8"
)

print("📸 Tutte le immagini scaricate.")
PY

echo "🚘 Aggiornamento catalogo..."

cat > src/data/cars.js <<'EOF'
export const cars = [
  {
    id: 'fiat-panda',
    brand: 'FIAT',
    name: 'Panda',
    category: 'CITY CAR',
    image: '/images/cars/licensed/fiat-panda.jpg',
    description: 'Fiat Panda. Contattaci per informazioni, disponibilità e preventivi.',
    credit: {
      author: 'Harvey Bold',
      license: 'CC BY 4.0',
      source: 'https://commons.wikimedia.org/wiki/File:2012_FIAT_Panda_Easy_-_1242cc_1.2_(69PS)_Petrol_-_White_-_04-2024,_Front.jpg',
      licenseUrl: 'https://creativecommons.org/licenses/by/4.0/'
    }
  },
  {
    id: 'fiat-500x',
    brand: 'FIAT',
    name: '500X',
    category: 'CROSSOVER',
    image: '/images/cars/licensed/fiat-500x.jpg',
    description: 'Fiat 500X. Contattaci per informazioni, disponibilità e preventivi.',
    credit: {
      author: 'Pava',
      license: 'CC BY-SA 3.0 IT',
      source: 'https://commons.wikimedia.org/wiki/File:%2215_-_ITALY_-_White_premium_SUV_-_Fiat_500X_Urban_in_Milan_04.jpg',
      licenseUrl: 'https://creativecommons.org/licenses/by-sa/3.0/it/'
    }
  },
  {
    id: 'smart-fortwo',
    brand: 'SMART',
    name: 'Fortwo',
    category: 'CITY CAR',
    image: '/images/cars/licensed/smart-fortwo.jpg',
    description: 'Smart Fortwo. Contattaci per informazioni, disponibilità e preventivi.',
    credit: {
      author: 'Matti Blume',
      license: 'CC BY-SA 3.0',
      source: 'https://commons.wikimedia.org/wiki/File:2007_Smart_fortwo_black_front.jpg',
      licenseUrl: 'https://creativecommons.org/licenses/by-sa/3.0/'
    }
  }
]
EOF

cat > src/components/CarCard.jsx <<'EOF'
import { Link } from 'react-router-dom'
import { ArrowUpRight } from 'lucide-react'
import { whatsappLink } from '../data/company'

export default function CarCard({ car }) {
  return (
    <article className="real-car-card luxury-car-card">
      <Link to={`/auto/${car.id}`} className="real-car-image">
        <img
          src={car.image}
          alt={`${car.brand} ${car.name} - immagine illustrativa`}
          loading="lazy"
        />
        <span className="car-photo-badge">FOTO ILLUSTRATIVA</span>
      </Link>

      <div className="real-car-info">
        <p className="eyebrow">{car.category}</p>
        <h3>{car.brand} <span>{car.name}</span></h3>
        <p>Disponibilità e condizioni su richiesta.</p>

        <div className="luxury-car-actions">
          <Link to={`/auto/${car.id}`} className="text-link">
            SCOPRI L'AUTO <ArrowUpRight size={17}/>
          </Link>

          <a
            href={whatsappLink(
              `Buongiorno, vorrei un preventivo per ${car.brand} ${car.name}.`
            )}
            target="_blank"
            rel="noopener noreferrer"
            className="luxury-wa-link"
          >
            WHATSAPP ↗
          </a>
        </div>
      </div>
    </article>
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
        <Link to="/flotta" className="btn btn-gold">
          TORNA ALLA FLOTTA
        </Link>
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
            <img
              src={car.image}
              alt={`${car.brand} ${car.name} - foto illustrativa`}
            />
            <p className="photo-disclaimer">
              Immagine illustrativa del modello.
              La vettura effettiva può differire.
            </p>
          </div>

          <div className="car-detail-copy">
            <p className="eyebrow">{car.category}</p>
            <h1>{car.brand}<br/><em>{car.name}</em></h1>
            <p>{car.description}</p>

            <a
              href={whatsappLink(
                `Buongiorno, vorrei informazioni e un preventivo per ${car.brand} ${car.name}.`
              )}
              target="_blank"
              rel="noopener noreferrer"
              className="btn btn-gold"
            >
              RICHIEDI PREVENTIVO <ArrowUpRight size={18}/>
            </a>

            <p className="car-credit">
              Foto: {car.credit.author} · {car.credit.license} ·{' '}
              <a
                href={car.credit.source}
                target="_blank"
                rel="noopener noreferrer"
              >
                Fonte
              </a>
              {' · '}
              <a
                href={car.credit.licenseUrl}
                target="_blank"
                rel="noopener noreferrer"
              >
                Licenza
              </a>
            </p>
          </div>
        </div>
      </section>
    </main>
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
        <p>Scopri i modelli e richiedi un preventivo personalizzato.</p>
      </section>

      <section className="section-pad">
        <div className="cars-grid">
          {cars.map(car => <CarCard key={car.id} car={car}/>)}
        </div>

        <p className="fleet-disclaimer">
          Le fotografie sono illustrative dei modelli e non
          rappresentano necessariamente le vetture disponibili.
          Contattaci per verificare disponibilità e caratteristiche.
        </p>
      </section>

      <section className="showroom-gallery section-pad">
        <p className="eyebrow">IL NOSTRO MONDO</p>
        <h2>IL PARCO AUTO <em>L.M. RENT CAR.</em></h2>

        <div className="showroom-grid">
          <img
            src="/images/cars/wix-01.jpeg"
            alt="Parco auto L.M. Rent Car"
            loading="lazy"
          />
          <img
            src="/images/cars/wix-02.jpeg"
            alt="Esposizione L.M. Rent Car"
            loading="lazy"
          />
          <img
            src="/images/cars/wix-08.jpeg"
            alt="Automobili L.M. Rent Car"
            loading="lazy"
          />
          <img
            src="/images/cars/wix-09.jpeg"
            alt="Galleria L.M. Rent Car"
            loading="lazy"
          />
        </div>

        <a
          href={whatsappLink(
            'Buongiorno, vorrei informazioni sui veicoli disponibili.'
          )}
          target="_blank"
          rel="noopener noreferrer"
          className="btn btn-gold"
        >
          CHIEDI DISPONIBILITÀ <ArrowUpRight size={18}/>
        </a>
      </section>

      <section className="photo-credits-section section-pad">
        <p className="eyebrow">TRASPARENZA</p>
        <h2>CREDITI <em>FOTOGRAFICI.</em></h2>
        <p>
          Le immagini illustrative dei modelli provengono
          da Wikimedia Commons e sono utilizzate secondo
          le rispettive licenze Creative Commons.
        </p>

        <div className="photo-credits-list">
          {cars.map(car => (
            <p key={car.id}>
              <strong>{car.brand} {car.name}</strong>
              {' — '}
              {car.credit.author}
              {' · '}
              <a
                href={car.credit.source}
                target="_blank"
                rel="noopener noreferrer"
              >
                Fotografia originale
              </a>
              {' · '}
              <a
                href={car.credit.licenseUrl}
                target="_blank"
                rel="noopener noreferrer"
              >
                {car.credit.license}
              </a>
              {' · '}
              Ritaglio automatico di visualizzazione.
            </p>
          ))}
        </div>
      </section>
    </main>
  )
}
EOF

cat >> src/styles/global.css <<'EOF'

/* L.M. RENT CAR — CATALOGO 4.0 */

.luxury-car-card {
  background: linear-gradient(155deg, #202020, #111);
}

.luxury-car-card .real-car-image {
  position: relative;
  height: 340px;
}

.luxury-car-card .real-car-image img {
  object-fit: cover;
  object-position: center;
}

.car-photo-badge {
  position: absolute;
  left: 18px;
  bottom: 18px;
  padding: 8px 12px;
  background: rgba(0,0,0,.76);
  color: #eee;
  font-size: 9px;
  letter-spacing: .12em;
}

.luxury-car-card h3 span {
  color: #d7ae62;
}

.luxury-car-actions {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
}

.luxury-wa-link {
  border: 1px solid #d7ae62;
  padding: 11px 14px;
  color: #d7ae62;
  text-decoration: none;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: .08em;
}

.luxury-wa-link:hover {
  background: #d7ae62;
  color: #111;
}

.photo-disclaimer,
.car-credit {
  color: #999;
  font-size: 12px;
  line-height: 1.7;
  margin-top: 15px;
}

.car-credit a,
.photo-credits-list a {
  color: #d7ae62;
}

.photo-credits-section {
  background: #0c0c0c;
}

.photo-credits-section > p:not(.eyebrow) {
  color: #aaa;
  max-width: 700px;
  line-height: 1.8;
  margin: 18px 0 30px;
}

.photo-credits-list {
  border-top: 1px solid #333;
  padding-top: 20px;
}

.photo-credits-list p {
  color: #aaa;
  line-height: 1.8;
  margin-bottom: 12px;
  font-size: 13px;
}

@media(max-width: 800px) {
  .luxury-car-card .real-car-image {
    height: 270px;
  }
}
EOF

echo "🔨 Verifica del sito..."
npm run build

echo ""
echo "✅ CATALOGO 4.0 COMPLETATO!"
echo "🌐 http://localhost:5173/flotta"
