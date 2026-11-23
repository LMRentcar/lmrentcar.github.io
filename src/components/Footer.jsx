import { Link } from 'react-router-dom'
import { ArrowUpRight, Phone, Mail, MapPin } from 'lucide-react'
import Logo from './Logo'
import { company, whatsappLink } from '../data/company'

export default function Footer() {
  return (
    <footer className="footer">
      <div className="footer-top">
        <div className="lm-footer-brand">
          <Logo/>
          <p>Noleggio auto economiche e di lusso.</p>
          <p><MapPin size={15}/> {company.address}</p>
        </div>

        <div className="footer-links">
          <Link to="/">Home</Link>
          <Link to="/flotta">La Flotta</Link>
          <Link to="/servizi">Servizi</Link>
          <Link to="/chi-siamo">Chi Siamo</Link>
          <Link to="/contatti">Contatti</Link>
        </div>

        <div className="lm-footer-contact">
          <a href={`tel:${company.phone.replace(/\s/g, '')}`}>
            <Phone size={16}/> {company.phone}
          </a>
          <a href={`mailto:${company.email}`}>
            <Mail size={16}/> {company.email}
          </a>
          <a
            href={whatsappLink('Buongiorno, vorrei informazioni.')}
            target="_blank"
            rel="noopener noreferrer"
            className="footer-contact"
          >
            CONTATTACI <ArrowUpRight size={22} color="#c9a45c"/>
          </a>
        </div>
      </div>

      <div className="footer-bottom">
        <span>© {new Date().getFullYear()} {company.legalName}</span>
        <span>P. IVA {company.vat}</span>
        <span>{company.email}</span>
      </div>
    
      <div className="gifra-developer-credit">
        <span>DESIGNED &amp; DEVELOPED BY</span>
        <strong>GIFRA</strong>
        <span>© 2026</span>
      </div>
</footer>
  )
}
