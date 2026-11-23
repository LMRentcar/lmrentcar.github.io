import { Link } from 'react-router-dom'

export default function Logo() {
  return (
    <Link to="/" className="luxury-logo" aria-label="L.M. Rent Car - Home">
      <span className="luxury-logo-script">L.M.</span>
      <span className="luxury-logo-name">RENT CAR</span>
      <span className="luxury-logo-tagline">Noleggio e Vendita Auto</span>
    </Link>
  )
}
