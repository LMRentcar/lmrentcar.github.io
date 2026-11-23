import { useState } from 'react'
import {
  Phone, Mail, MapPin, MessageCircle,
  ArrowUpRight, CalendarDays
} from 'lucide-react'
import { company, whatsappLink } from '../data/company'

export default function Contact() {
  const [form, setForm] = useState({
    name: '',
    car: '',
    start: '',
    end: '',
    message: ''
  })

  const update = (event) => {
    const { name, value } = event.target
    setForm(previous => ({ ...previous, [name]: value }))
  }

  const submit = (event) => {
    event.preventDefault()

    const message = [
      'Buongiorno L.M. RENT CAR, vorrei richiedere un preventivo.',
      '',
      `Nome: ${form.name}`,
      `Auto desiderata: ${form.car || 'Da consigliare'}`,
      `Data inizio: ${form.start || 'Da concordare'}`,
      `Data fine: ${form.end || 'Da concordare'}`,
      `Messaggio: ${form.message || 'Nessuna nota aggiuntiva'}`
    ].join('\n')

    window.open(whatsappLink(message), '_blank', 'noopener,noreferrer')
  }

  return (
    <main className="inner-page">
      <section className="page-heading">
        <p className="eyebrow">LET'S TALK</p>
        <h1>INIZIA IL TUO <em>VIAGGIO.</em></h1>
        <p>Contattaci per informazioni, disponibilità e preventivi personalizzati.</p>
      </section>

      <section className="contact-layout section-pad">
        <div>
          <p className="eyebrow">L.M. RENT CAR</p>
          <h2>IL TUO PROSSIMO<br/><em>VIAGGIO INIZIA QUI.</em></h2>

          <p className="contact-description">
            Cerchi un'auto economica o una vettura di lusso?
            Raccontaci le tue esigenze e ti aiuteremo
            a trovare la soluzione di noleggio ideale.
          </p>

          <a
            href={whatsappLink('Buongiorno, vorrei informazioni sul noleggio auto.')}
            target="_blank"
            rel="noopener noreferrer"
            className="btn btn-gold"
          >
            SCRIVICI SU WHATSAPP <ArrowUpRight size={18}/>
          </a>
        </div>

        <div className="contact-card">
          <a
            className="contact-row"
            href={whatsappLink('Buongiorno, vorrei informazioni.')}
            target="_blank"
            rel="noopener noreferrer"
          >
            <MessageCircle/>
            <div><strong>WHATSAPP</strong><p>{company.phone}</p></div>
          </a>

          <a className="contact-row" href={`tel:${company.phone.replace(/\s/g, '')}`}>
            <Phone/>
            <div><strong>TELEFONO</strong><p>{company.phone}</p></div>
          </a>

          <a className="contact-row" href={`mailto:${company.email}`}>
            <Mail/>
            <div><strong>EMAIL</strong><p>{company.email}</p></div>
          </a>

          <div className="contact-row">
            <MapPin/>
            <div><strong>SEDE</strong><p>{company.address}</p></div>
          </div>
        </div>
      </section>

      <section className="lm-quote-section section-pad">
        <div className="lm-quote-intro">
          <p className="eyebrow">PREVENTIVO PERSONALIZZATO</p>
          <h2>RICHIEDI LA TUA <em>AUTO.</em></h2>
          <p>
            Compila il modulo e invia la richiesta direttamente
            su WhatsApp. Ti risponderemo per verificare
            disponibilità e condizioni.
          </p>
        </div>

        <form className="lm-quote-form" onSubmit={submit}>
          <label>
            NOME E COGNOME *
            <input
              name="name"
              value={form.name}
              onChange={update}
              placeholder="Il tuo nome"
              required
              maxLength={100}
            />
          </label>

          <label>
            AUTO DESIDERATA
            <input
              name="car"
              value={form.car}
              onChange={update}
              placeholder="Es. Fiat Panda, Porsche..."
              maxLength={100}
            />
          </label>

          <div className="lm-form-dates">
            <label>
              <CalendarDays size={16}/> DATA INIZIO
              <input
                type="date"
                name="start"
                value={form.start}
                onChange={update}
                min={new Date().toLocaleDateString('en-CA')}
              />
            </label>

            <label>
              <CalendarDays size={16}/> DATA FINE
              <input
                type="date"
                name="end"
                value={form.end}
                onChange={update}
                min={form.start || new Date().toLocaleDateString('en-CA')}
              />
            </label>
          </div>

          <label>
            MESSAGGIO AGGIUNTIVO
            <textarea
              name="message"
              value={form.message}
              onChange={update}
              rows={4}
              maxLength={1000}
              placeholder="Scrivi eventuali richieste particolari..."
            />
          </label>

          <button type="submit" className="btn btn-gold">
            INVIA RICHIESTA SU WHATSAPP <ArrowUpRight size={18}/>
          </button>

          <p className="lm-form-note">
            Il modulo apre WhatsApp con un messaggio precompilato.
            La richiesta viene inviata solo dopo la tua conferma su WhatsApp.
          </p>
        </form>
      </section>

      <section className="maps-section">
        <div className="section-heading">
          <div>
            <p className="eyebrow">DOVE SIAMO</p>
            <h2>VIENI A <em>TROVARCI.</em></h2>
          </div>
        </div>

        <iframe
          title="Mappa sede L.M. Rent Car"
          src="https://www.google.com/maps?q=Via%20Ferrari%2049%2C%20Palma%20Campania&output=embed"
          width="100%"
          height="400"
          style={{border:0}}
          loading="lazy"
          referrerPolicy="no-referrer-when-downgrade"
        />
      </section>
    </main>
  )
}
