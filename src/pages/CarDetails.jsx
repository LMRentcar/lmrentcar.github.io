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
          <ArrowLeft size={18} color="#c9a45c"/> TORNA ALLA FLOTTA
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
              RICHIEDI PREVENTIVO <ArrowUpRight size={18} color="#c9a45c"/>
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
