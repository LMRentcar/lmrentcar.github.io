import { useState } from 'react'
import './FleetFilters.css'
import IndicativeRates from '../components/IndicativeRates'
import CarCard from '../components/CarCard'
import { cars } from '../data/cars'
import { whatsappLink } from '../data/company'
import { ArrowUpRight } from 'lucide-react'

export default function Fleet() {
  const [category, setCategory] = useState('TUTTE')

  const isMonthly = car =>
    String(car.priceLabel || '').toLowerCase().includes('/mese')

  function getCategory(car) {
    const original = String(car.category || '').toUpperCase()
    const brand = String(car.brand || '').toUpperCase()
    const name = String(car.name || '').toUpperCase()

    if (name.includes('AVENGER') || name.includes('500X')) {
      return 'CITY CAR'
    }

    if (original.includes('SCOOTER') || brand === 'HONDA') {
      return 'SCOOTER'
    }

    if (brand.includes('MERCEDES')) {
      return 'PREMIUM'
    }

    if (
      original.includes('SUV') ||
      brand === 'JEEP' ||
      brand === 'JAECOO' ||
      name.includes('AVENGER') ||
      name.includes('500X') ||
      name.includes('TONALE')
    ) {
      return 'SUV'
    }

    if (original.includes('CITY') || brand === 'TOYOTA') {
      return 'CITY CAR'
    }

    if (original.includes('PREMIUM')) {
      return 'PREMIUM'
    }

    return 'ALTRI'
  }

  const filteredByRental = cars

  const availableCategories = [
    'TUTTE',
    ...['CITY CAR', 'SUV', 'PREMIUM', 'SCOOTER', 'ALTRI'].filter(
      item => filteredByRental.some(
        car => getCategory(car) === item
      )
    )
  ]

  const visibleCars = filteredByRental.filter(car =>
    category === 'TUTTE' || getCategory(car) === category
  )

  return (
    <main className="inner-page">
      <section className="page-heading">
        <p className="eyebrow">L.M. RENT CAR</p>
        <h1>LA NOSTRA <em>FLOTTA.</em></h1>
        <p>Scopri i modelli e richiedi un preventivo personalizzato.</p>
      </section>

      <section className="section-pad">
        <div className="lm-fleet-filters">
          <p className="lm-filter-label">
            ESPLORA LA NOSTRA FLOTTA
          </p>

          <div className="lm-category-filters">
            {availableCategories.map(item => (
              <button
                type="button"
                key={item}
                className={category === item ? 'active' : ''}
                aria-pressed={category === item}
                onClick={() => setCategory(item)}
              >
                {item}
              </button>
            ))}
          </div>

          <p className="lm-fleet-count" aria-live="polite">
            {visibleCars.length}
            {visibleCars.length === 1
              ? ' VEICOLO DISPONIBILE NEL CATALOGO'
              : ' VEICOLI NEL CATALOGO'}
          </p>
        </div>

        <div className="cars-grid">
          {visibleCars.map(car => (
            <CarCard key={car.id} car={car}/>
          ))}
        </div>

        {visibleCars.length === 0 && (
          <p className="lm-fleet-empty">
            Nessun veicolo in questa categoria.
          </p>
        )}

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
          CHIEDI DISPONIBILITÀ <ArrowUpRight size={18} color="#c9a45c"/>
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
              {car.credit?.author || "Foto L.M. Rent Car"}
              {' · '}
              <a
                href={car.credit?.source || "#"}
                target="_blank"
                rel="noopener noreferrer"
              >
                Fotografia originale
              </a>
              {' · '}
              <a
                href={car.credit?.licenseUrl || "#"}
                target="_blank"
                rel="noopener noreferrer"
              >
                {car.credit?.license || "Foto del veicolo"}
              </a>
              {' · '}
              Ritaglio automatico di visualizzazione.
            </p>
          ))}
        </div>
      </section>
      <IndicativeRates />
    </main>
  )
}
