import { useEffect, useState } from 'react'

export default function InstallAppGuide({ open, onClose }) {
  const [device, setDevice] = useState('iphone')

  useEffect(() => {
    if (!open) return

    const closeOnEscape = (event) => {
      if (event.key === 'Escape') onClose()
    }

    document.addEventListener('keydown', closeOnEscape)
    document.body.style.overflow = 'hidden'

    return () => {
      document.removeEventListener('keydown', closeOnEscape)
      document.body.style.overflow = ''
    }
  }, [open, onClose])

  if (!open) return null

  return (
    <div
      className="lm-install-overlay"
      onMouseDown={(event) => {
        if (event.target === event.currentTarget) onClose()
      }}
    >
      <section
        className="lm-install-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="lm-install-title"
      >
        <button
          type="button"
          className="lm-install-close"
          onClick={onClose}
          aria-label="Chiudi"
        >
          ×
        </button>

        <div className="lm-install-icon">↗</div>

        <p className="lm-install-eyebrow">L.M. RENT CAR</p>

        <h2 id="lm-install-title">
          PORTACI SEMPRE <span>CON TE.</span>
        </h2>

        <p className="lm-install-intro">
          Aggiungi L.M. RENT CAR alla schermata Home
          del tuo smartphone e aprici con un solo tocco.
        </p>

        <div className="lm-install-tabs">
          <button
            type="button"
            className={device === 'iphone' ? 'active' : ''}
            onClick={() => setDevice('iphone')}
          >
            🍎 iPHONE
          </button>

          <button
            type="button"
            className={device === 'android' ? 'active' : ''}
            onClick={() => setDevice('android')}
          >
            🤖 ANDROID
          </button>
        </div>

        {device === 'iphone' ? (
          <div className="lm-install-steps">
            <p className="lm-install-device">ISTRUZIONI PER iPHONE</p>

            <div><b>01</b><p>Apri questo sito con <strong>Safari</strong>.</p></div>

            <div>
              <b>02</b>
              <p>
                Tocca <strong>Condividi</strong> (quadrato con
                freccia verso l'alto). Se necessario, scorri
                verso l'alto il menu.
              </p>
            </div>

            <div>
              <b>03</b>
              <p>Seleziona <strong>Aggiungi alla schermata Home</strong>.</p>
            </div>

            <div>
              <b>04</b>
              <p>Tocca <strong>Aggiungi</strong>. Troverai l'icona sul telefono.</p>
            </div>
          </div>
        ) : (
          <div className="lm-install-steps">
            <p className="lm-install-device">ISTRUZIONI PER ANDROID</p>

            <div><b>01</b><p>Apri questo sito con <strong>Chrome</strong>.</p></div>

            <div>
              <b>02</b>
              <p>Tocca il menu con i <strong>tre puntini ⋮</strong>.</p>
            </div>

            <div>
              <b>03</b>
              <p>
                Seleziona <strong>Aggiungi a schermata Home</strong>
                oppure <strong>Installa app</strong>, se disponibile.
              </p>
            </div>

            <div>
              <b>04</b>
              <p>Conferma per aggiungere l'icona al telefono.</p>
            </div>
          </div>
        )}

        <p className="lm-install-note">
          Non serve scaricare nulla dagli store.
          È un collegamento al sito: per utilizzarlo
          è necessaria una connessione al sito stesso.
        </p>

        <button
          type="button"
          className="lm-install-done"
          onClick={onClose}
        >
          HO CAPITO ✓
        </button>
      </section>
    </div>
  )
}
