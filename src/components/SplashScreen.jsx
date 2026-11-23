import { useEffect, useState } from 'react'

export default function SplashScreen() {
  const [visible, setVisible] = useState(() => {
    return (
      window.matchMedia('(display-mode: standalone)').matches ||
      window.navigator.standalone === true
    )
  })

  const [closing, setClosing] = useState(false)

  useEffect(() => {
    if (!visible) return

    const fadeTimer = window.setTimeout(() => {
      setClosing(true)
    }, 2000)

    const removeTimer = window.setTimeout(() => {
      setVisible(false)
    }, 2600)

    return () => {
      window.clearTimeout(fadeTimer)
      window.clearTimeout(removeTimer)
    }
  }, [])

  if (!visible) return null

  return (
    <div
      className={`lm-splash ${closing ? 'lm-splash-closing' : ''}`}
      aria-label="Caricamento L.M. RENT CAR"
    >
      <div className="lm-splash-content">
        <img
          src="/lm-rent-car-app-512.png"
          alt="L.M. RENT CAR"
          className="lm-splash-logo"
        />
      </div>
    </div>
  )
}
