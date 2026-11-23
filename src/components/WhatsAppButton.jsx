import { MessageCircle } from 'lucide-react'
import { whatsappLink } from '../data/company'

export default function WhatsAppButton() {
  return (
    <a
      className="whatsapp-floating"
      href={whatsappLink(
        'Buongiorno, vorrei ricevere informazioni da L.M. Rent Car.'
      )}
      target="_blank"
      rel="noopener noreferrer"
      aria-label="Contatta L.M. Rent Car su WhatsApp"
      title="Scrivici su WhatsApp"
    >
      <MessageCircle size={27}/>
    </a>
  )
}
