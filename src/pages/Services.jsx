import { Link } from 'react-router-dom'
import {
  ArrowUpRight, Clock3, CalendarDays, CalendarRange,
  Truck, CreditCard, UserRoundCheck, Gem
} from 'lucide-react'
import { whatsappLink } from '../data/company'

const services = [
  {
    icon: Clock3,
    title: 'Noleggio a breve termine',
    description: 'La soluzione ideale per viaggi, weekend e spostamenti quotidiani.'
  },
  {
    icon: CalendarRange,
    title: 'Noleggio a lungo termine',
    description: 'Soluzioni flessibili per chi desidera un’auto per periodi prolungati.'
  },
  {
    icon: CalendarDays,
    title: 'Noleggio mensile',
    description: 'La libertà di utilizzare un’auto per uno o più mesi.'
  },
  {
    icon: Truck,
    title: 'Consegna a domicilio',
    description: 'Richiedi la consegna della vettura direttamente all’indirizzo concordato.'
  },
  {
    icon: CreditCard,
    title: 'Noleggio senza carta di credito',
    description: 'Possibilità di noleggio senza carta di credito, secondo le condizioni previste.'
  },
  {
    icon: UserRoundCheck,
    title: 'Noleggio per neopatentati',
    description: 'Soluzioni dedicate ai neopatentati, con vetture idonee e condizioni da verificare.'
  },
  {
    icon: Gem,
    title: 'Matrimoni ed eventi',
    description: 'Vetture eleganti per rendere ancora più speciali le occasioni importanti.'
  }
]

export default function Services() {
  return (
    <main className="services-page">
      <section className="lm-services-hero">
        <p className="eyebrow">L.M. RENT CAR · I NOSTRI SERVIZI</p>
        <h1>LA TUA MOBILITÀ.<br/><span>SENZA COMPROMESSI.</span></h1>
        <p>
          Dalle city car alle vetture di lusso, offriamo soluzioni
          di noleggio pensate per ogni esigenza.
        </p>
      </section>

      <section className="lm-services-section">
        <div className="lm-services-grid">
          {services.map(({ icon: Icon, title, description }) => (
            <article className="lm-service-card" key={title}>
              <Icon size={32} strokeWidth={1.5} />
              <h2>{title}</h2>
              <p>{description}</p>
              <a
                href={whatsappLink(`Ciao, vorrei informazioni sul servizio: ${title}`)}
                target="_blank"
                rel="noopener noreferrer"
              >
                RICHIEDI INFORMAZIONI <ArrowUpRight size={16} color="#c9a45c"/>
              </a>
            </article>
          ))}
        </div>
      </section>

      <section className="lm-services-cta">
        <h2>PRONTO A PARTIRE?</h2>
        <p>Contattaci per trovare la soluzione di noleggio più adatta a te.</p>
        <Link to="/flotta" className="lm-gold-button">
          SCOPRI LA FLOTTA <ArrowUpRight size={18} color="#c9a45c"/>
        </Link>
      </section>
    </main>
  )
}
