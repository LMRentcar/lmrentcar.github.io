import { whatsappLink } from '../data/company'

const rates = [
  {
    category: 'UTILITARIE',
    min: '30',
    max: '40',
    description: 'Soluzioni pratiche per gli spostamenti di ogni giorno.'
  },
  {
    category: 'SUV',
    min: '50',
    max: '80',
    description: 'Spazio e comfort per ogni tipo di viaggio.'
  },
  {
    category: 'AUTO DI LUSSO',
    min: '100',
    max: '300',
    description: 'Un’esperienza di guida esclusiva.'
  }
]

export default function IndicativeRates() {
  return (
    <section className="lm-rates section-pad" aria-labelledby="lm-rates-title">
      <div className="lm-rates-heading">
        <p className="eyebrow">TRASPARENZA E FLESSIBILITÀ</p>
        <h2 id="lm-rates-title">
          TARIFFE <em>INDICATIVE.</em>
        </h2>
        <p>
          Scopri le nostre fasce di prezzo e richiedi un preventivo
          personalizzato per il tuo prossimo noleggio.
        </p>
      </div>

      <div className="lm-rates-grid">
        {rates.map((rate) => (
          <article className="lm-rate-card" key={rate.category}>
            <span className="lm-rate-label">{rate.category}</span>

            <div className="lm-rate-price">
              <span className="lm-rate-prefix">DA</span>
              <strong>{rate.min} €</strong>
              <span className="lm-rate-suffix">/ giorno</span>
            </div>

            <p className="lm-rate-range">
              Fascia indicativa: {rate.min}–{rate.max} € al giorno
            </p>

            <p className="lm-rate-description">
              {rate.description}
            </p>

            <a
              className="lm-rate-button"
              href={whatsappLink(
                `Buongiorno, vorrei un preventivo per un'auto della categoria ${rate.category}.`
              )}
              target="_blank"
              rel="noopener noreferrer"
            >
              RICHIEDI PREVENTIVO ↗
            </a>
          </article>
        ))}
      </div>

      <p className="lm-rates-disclaimer">
        Prezzi puramente indicativi, non costituiscono un'offerta
        vincolante. Tariffe, disponibilità e condizioni possono variare
        in base al veicolo, al periodo e alla durata del noleggio.
        Il prezzo definitivo viene comunicato tramite preventivo.
      </p>
    </section>
  )
}
