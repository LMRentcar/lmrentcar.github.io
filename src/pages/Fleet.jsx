import IndicativeRates from '../components/IndicativeRates'
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
      <IndicativeRates />
    </main>
  )
}
