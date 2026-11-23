import { useState as useInstallGuideState } from 'react'
import InstallAppGuide from './InstallAppGuide'
import { useState } from 'react'
import { Link, NavLink } from 'react-router-dom'
import { Menu, X, ArrowUpRight } from 'lucide-react'
import Logo from './Logo'
import { whatsappLink } from '../data/company'

export default function Navbar() {
  const [lmInstallGuideOpen, setLmInstallGuideOpen] = useInstallGuideState(false)

  const [open, setOpen] = useState(false)

  const links = [
    ['/', 'Home'],
    ['/flotta', 'La Flotta'],
    ['/servizi', 'Servizi'],
    ['/chi-siamo', 'Chi Siamo'],
    ['/contatti', 'Contatti']
  ]

  const whatsapp = whatsappLink(
    'Buongiorno, vorrei ricevere informazioni sui servizi di L.M. Rent Car.'
  )

  return (
    <>

    <header className="navbar">
      <Logo />

      <nav className={open ? 'nav-links open' : 'nav-links'}>
        {links.map(([path, label]) => (
          <NavLink
            key={path}
            to={path}
            end={path === '/'}
            onClick={() => setOpen(false)}
          >
            {label}
          </NavLink>
        ))}

        <a
          className="nav-mobile-cta"
          href={whatsapp}
          target="_blank"
          rel="noopener noreferrer"
          onClick={() => setOpen(false)}
        >
          Richiedi preventivo
        </a>
      
          <button
            type="button"
            className="lm-install-menu-link"
            onClick={() => setLmInstallGuideOpen(true)}
          >
            <span aria-hidden="true">↓</span> SCARICA APP
          </button>
</nav>

      <a
        href={whatsapp}
        target="_blank"
        rel="noopener noreferrer"
        className="nav-cta"
      >
        WHATSAPP <ArrowUpRight size={16}/>
      </a>

      <button
        className="menu-toggle"
        onClick={() => setOpen(!open)}
        aria-label={open ? 'Chiudi menu' : 'Apri menu'}
        aria-expanded={open}
      >
        {open ? <X/> : <Menu/>}
      </button>
    </header>
  
      <InstallAppGuide
        open={lmInstallGuideOpen}
        onClose={() => setLmInstallGuideOpen(false)}
      />
    </>
)
}
