import { useEffect, useState } from 'react'
import { cars } from '../data/cars'
import { whatsappLink } from '../data/company'
import './QuoteWidget.css'

function isMonthly(car) {
  return Boolean(
    car?.priceLabel?.toLowerCase().includes('/mese')
  )
}

function getCurrentCar() {
  const match = window.location.pathname.match(/^\/auto\/([^/]+)/)
  if (!match) return null

  try {
    const id = decodeURIComponent(match[1])
    return cars.find(car => String(car.id) === id) || null
  } catch {
    return null
  }
}

export default function QuoteWidget() {
  const [open, setOpen] = useState(false)
  const [selectedId, setSelectedId] = useState('')
  const [startDate, setStartDate] = useState('')
  const [endDate, setEndDate] = useState('')
  const [location, setLocation] = useState('')
  const [duration, setDuration] = useState('48')
  const [mileage, setMileage] = useState('')
  const [notes, setNotes] = useState('')
  const [error, setError] = useState('')

  const selectedCar = cars.find(
    car => String(car.id) === selectedId
  )

  const monthly = isMonthly(selectedCar)

  const today = new Date()
  const todayString = [
    today.getFullYear(),
    String(today.getMonth() + 1).padStart(2, '0'),
    String(today.getDate()).padStart(2, '0')
  ].join('-')

  function showModal() {
    const current = getCurrentCar()
    if (current) setSelectedId(String(current.id))
    setError('')
    setOpen(true)
  }

  function closeModal() {
    setOpen(false)
    setError('')
  }

  useEffect(() => {
    if (!open) return

    function handleEscape(event) {
      if (event.key === 'Escape') closeModal()
    }

    document.addEventListener('keydown', handleEscape)

    const oldOverflow = document.body.style.overflow
    document.body.style.overflow = 'hidden'

    return () => {
      document.removeEventListener('keydown', handleEscape)
      document.body.style.overflow = oldOverflow
    }
  }, [open])

  function sendQuote(event) {
    event.preventDefault()
    setError('')

    if (!selectedCar) {
      setError('Seleziona un veicolo.')
      return
    }

    if (!monthly) {
      if (!startDate || !endDate) {
        setError('Inserisci entrambe le date.')
        return
      }

      if (startDate < todayString) {
        setError('La data di ritiro non può essere nel passato.')
        return
      }

      if (endDate < startDate) {
        setError('La riconsegna non può precedere il ritiro.')
        return
      }
    }

    if (monthly && (!duration || Number(duration) <= 0)) {
      setError('Inserisci una durata valida.')
      return
    }

    const vehicleName = [
      selectedCar.brand,
      selectedCar.name
    ].filter(Boolean).join(' ')

    const lines = [
      'Buongiorno LM RENT CAR,',
      'vorrei richiedere un preventivo.',
      '',
      'VEICOLO: ' + vehicleName,
      'TIPO: ' + (
        monthly
          ? 'Noleggio a lungo termine'
          : 'Noleggio giornaliero'
      ),
      'PREZZO INDICATIVO: ' + (
        selectedCar.priceLabel ||
        (
          'A partire da ' +
          selectedCar.priceFrom +
          (monthly ? ' €/mese' : ' €/giorno')
        )
      )
    ]

    if (monthly) {
      lines.push('DURATA RICHIESTA: ' + duration + ' mesi')
      if (mileage.trim()) {
        lines.push('CHILOMETRI TOTALI RICHIESTI: ' + mileage.trim())
      }
    } else {
      lines.push('DATA RITIRO: ' + startDate)
      lines.push('DATA RICONSEGNA: ' + endDate)

      if (location.trim()) {
        lines.push('LUOGO RITIRO: ' + location.trim())
      }
    }

    if (notes.trim()) {
      lines.push('NOTE: ' + notes.trim())
    }

    lines.push(
      '',
      'Vorrei conoscere disponibilità, condizioni e preventivo finale.',
      'Grazie.'
    )

    const url = whatsappLink(lines.join('\n'))

    if (!url) {
      setError('Collegamento WhatsApp non disponibile.')
      return
    }

    const opened = window.open(
      url,
      '_blank',
      'noopener,noreferrer'
    )

    if (!opened) {
      window.location.href = url
    }

    closeModal()
  }

  return (
    <>


      {open && (
        <div
          className="lm-quote-overlay"
          onMouseDown={event => {
            if (event.target === event.currentTarget) {
              closeModal()
            }
          }}
        >
          <section
            className="lm-quote-modal"
            role="dialog"
            aria-modal="true"
            aria-labelledby="lm-quote-title"
          >
            <div className="lm-quote-header">
              <div>
                <p>LM RENT CAR</p>
                <h2 id="lm-quote-title">
                  RICHIEDI <em>PREVENTIVO.</em>
                </h2>
              </div>

              <button
                type="button"
                className="lm-quote-close"
                onClick={closeModal}
                aria-label="Chiudi"
              >
                ×
              </button>
            </div>

            <p className="lm-quote-intro">
              Seleziona il veicolo e inviaci la tua richiesta
              direttamente su WhatsApp.
            </p>

            <form onSubmit={sendQuote}>
              <label htmlFor="lm-quote-car">
                VEICOLO DESIDERATO
              </label>

              <select
                id="lm-quote-car"
                value={selectedId}
                onChange={event => {
                  setSelectedId(event.target.value)
                  setError('')
                }}
                required
              >
                <option value="">Seleziona un veicolo</option>

                {cars.map(car => (
                  <option key={car.id} value={String(car.id)}>
                    {car.brand} {car.name}
                    {' — '}
                    {car.priceLabel ||
                      `Da ${car.priceFrom} €`}
                  </option>
                ))}
              </select>

              {selectedCar && (
                <div className="lm-quote-selected">
                  <strong>
                    {selectedCar.brand} {selectedCar.name}
                  </strong>
                  <span>
                    {selectedCar.priceLabel ||
                      `A partire da ${selectedCar.priceFrom} €`}
                  </span>
                  <small>
                    Prezzo indicativo, soggetto a preventivo.
                  </small>
                </div>
              )}

              {monthly ? (
                <div className="lm-quote-fields">
                  <div>
                    <label htmlFor="lm-quote-duration">
                      DURATA IN MESI
                    </label>
                    <input
                      id="lm-quote-duration"
                      type="number"
                      min="1"
                      max="120"
                      value={duration}
                      onChange={event =>
                        setDuration(event.target.value)
                      }
                      required
                    />
                  </div>

                  <div>
                    <label htmlFor="lm-quote-km">
                      CHILOMETRI TOTALI
                    </label>
                    <input
                      id="lm-quote-km"
                      type="number"
                      min="0"
                      max="1000000"
                      placeholder="Es. 40000"
                      value={mileage}
                      onChange={event =>
                        setMileage(event.target.value)
                      }
                    />
                  </div>
                </div>
              ) : (
                <>
                  <div className="lm-quote-fields">
                    <div>
                      <label htmlFor="lm-quote-start">
                        DATA RITIRO
                      </label>
                      <input
                        id="lm-quote-start"
                        type="date"
                        min={todayString}
                        value={startDate}
                        onChange={event =>
                          setStartDate(event.target.value)
                        }
                        required
                      />
                    </div>

                    <div>
                      <label htmlFor="lm-quote-end">
                        DATA RICONSEGNA
                      </label>
                      <input
                        id="lm-quote-end"
                        type="date"
                        min={startDate || todayString}
                        value={endDate}
                        onChange={event =>
                          setEndDate(event.target.value)
                        }
                        required
                      />
                    </div>
                  </div>

                  <label htmlFor="lm-quote-location">
                    LUOGO DI RITIRO
                  </label>
                  <input
                    id="lm-quote-location"
                    type="text"
                    maxLength="120"
                    placeholder="Dove desideri ritirare l'auto?"
                    value={location}
                    onChange={event =>
                      setLocation(event.target.value)
                    }
                  />
                </>
              )}

              <label htmlFor="lm-quote-notes">
                RICHIESTE AGGIUNTIVE
              </label>

              <textarea
                id="lm-quote-notes"
                rows="3"
                maxLength="1000"
                placeholder="Scrivi eventuali richieste..."
                value={notes}
                onChange={event =>
                  setNotes(event.target.value)
                }
              />

              {error && (
                <p className="lm-quote-error" role="alert">
                  {error}
                </p>
              )}

              <button
                type="submit"
                className="lm-quote-submit"
              >
                INVIA RICHIESTA SU WHATSAPP
                <span aria-hidden="true">↗</span>
              </button>

              <p className="lm-quote-disclaimer">
                La richiesta non costituisce una prenotazione.
                Prezzi e disponibilità saranno confermati
                da LM RENT CAR.
              </p>
            </form>
          </section>
        </div>
      )}
    </>
  )
}
