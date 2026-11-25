import { Link } from 'react-router-dom'
import { ArrowUpRight } from 'lucide-react'

export default function CarCard({ car }) {
  return (
    <article className="real-car-card luxury-car-card lm-premium-car">
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
        <div className="lm-car-price">
          <span className="lm-car-price-label">A PARTIRE DA</span>
          <div className="lm-car-price-amount">
            <strong>
              {car.priceFrom ?? 30} €
            </strong>
            <span>{car.priceLabel?.includes('/mese') ? '/ MESE' : '/ GIORNO'}</span>
          </div>
          <p>Prezzo indicativo · Preventivo personalizzato</p>
        </div>

        <div className="luxury-car-actions">
          <Link to={`/auto/${car.id}`} className="text-link">
            SCOPRI L'AUTO <ArrowUpRight size={17} color="#c9a45c"/>
          </Link>


        </div>
      </div>
    </article>
  )
}
