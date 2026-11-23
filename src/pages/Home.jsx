import IndicativeRates from '../components/IndicativeRates'
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
            <h2>LA NOSTRA <em>FLOTTA.</em></h2>
          </div>
          <Link to="/flotta" className="text-link">
            VEDI TUTTE LE AUTO <ArrowUpRight size={18}/>
          </Link>
        </div>

        <p className="demo-notice">
          Fotografie dalla galleria L.M. Rent Car. Disponibilità e caratteristiche su richiesta.
        </p>

        <div className="cars-grid">
          {['fiat-500', 'smart-fortwo', 'audi-q3']
            .map(id => cars.find(car => car.id === id))
            .filter(Boolean)
            .map(car => <CarCard key={car.id} car={car}/>)}
        </div>
      </section>

            <IndicativeRates />

<section className="experience-banner">
        <div className="experience-overlay"/>
        <div className="experience-content">
          <p className="eyebrow">BEYOND THE ORDINARY</p>
          <h2 className="lm-experience-title"><span className="lm-title-words"><span>IL</span><span>LUSSO</span><span>DI</span></span><br/><em>ANDARE OLTRE.</em></h2>
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
