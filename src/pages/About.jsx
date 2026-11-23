import { ArrowUpRight, ShieldCheck, CarFront, HeartHandshake } from 'lucide-react'
import { whatsappLink } from '../data/company'

const values = [
  {
    icon: CarFront,
    title: 'PER OGNI ESIGENZA',
    description: 'Dalle city car economiche alle vetture di lusso, troviamo la soluzione più adatta al tuo viaggio.'
  },
  {
    icon: ShieldCheck,
    title: 'FLESSIBILITÀ',
    description: 'Noleggio a breve, mensile e lungo termine, con soluzioni personalizzate.'
  },
  {
    icon: HeartHandshake,
    title: 'AL TUO FIANCO',
    description: 'Ti aiutiamo a scegliere il veicolo e la formula di noleggio più adatti alle tue necessità.'
  }
]

export default function About() {
  return (
    <main className="inner-page">
      <section className="page-heading">
        <p className="eyebrow">IL NOSTRO MONDO</p>
        <h1>QUESTA È <em>L.M. RENT CAR.</em></h1>
        <p>La tua strada, il tuo stile. Scopri un nuovo modo di vivere la mobilità.</p>
      </section>

      <section className="about-real section-pad">
        <div className="about-real-photo">
          <img
            src="/images/cars/wix-13.jpeg"
            alt="L.M. Rent Car"
            loading="lazy"
          />
        </div>

        <div className="about-real-copy">
          <p className="eyebrow">CHI SIAMO</p>
          <h2>LA TUA STRADA.<br/><em>LA NOSTRA PASSIONE.</em></h2>

          <p>
            L.M. RENT CAR offre soluzioni di noleggio auto pensate
            per chi cerca libertà, comfort e flessibilità.
          </p>

          <p>
            Dalle auto economiche, ideali per gli spostamenti quotidiani,
            alle vetture di lusso, perfette per occasioni speciali,
            ti aiutiamo a trovare l'auto giusta per ogni esigenza.
          </p>

          <p>
            Offriamo noleggi a breve, mensile e lungo termine,
            consegna a domicilio e soluzioni dedicate anche
            ai neopatentati, secondo le condizioni previste.
          </p>

          <a
            href={whatsappLink('Buongiorno, vorrei informazioni sui servizi L.M. RENT CAR.')}
            target="_blank"
            rel="noopener noreferrer"
            className="btn btn-gold"
          >
            PARLA CON NOI <ArrowUpRight size={18} color="#c9a45c"/>
          </a>
        </div>
      </section>

      <section className="lm-about-values section-pad">
        <div className="section-heading">
          <div>
            <p className="eyebrow">PERCHÉ SCEGLIERCI</p>
            <h2>LA MOBILITÀ <em>SU MISURA.</em></h2>
          </div>
        </div>

        <div className="lm-values-grid">
          {values.map(({ icon: Icon, title, description }) => (
            <article className="lm-value-card" key={title}>
              <Icon size={32} strokeWidth={1.5}/>
              <h3>{title}</h3>
              <p>{description}</p>
            </article>
          ))}
        </div>
      </section>
    </main>
  )
}
