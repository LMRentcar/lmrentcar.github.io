import { useState, useEffect } from 'react'
import { Link, useParams } from 'react-router-dom'
import { ArrowLeft, ArrowUpRight, ChevronLeft, ChevronRight } from 'lucide-react'
import { cars } from '../data/cars'
import { whatsappLink } from '../data/company'

export default function CarDetails() {
  const { id } = useParams()
  const car = cars.find(item => item.id === id)
  const [photoIndex, setPhotoIndex] = useState(0)
  const photos = car?.images?.length ? car.images : car?.image ? [car.image] : []

  useEffect(() => {
    setPhotoIndex(0)
  }, [id])

  if (!car) {
    return (
      <main className="inner-page section-pad">
        <h1>Veicolo non trovato</h1>
        <Link to="/flotta" className="btn btn-gold">
          TORNA ALLA FLOTTA
        </Link>
      </main>
    )
  }

  return (
    <main className="inner-page">
      <section className="car-detail-real section-pad">
        <Link to="/flotta" className="text-link">
          <ArrowLeft size={18} color="#c9a45c"/> TORNA ALLA FLOTTA
        </Link>

        <div className="car-detail-grid">
          <div className="car-detail-photo">
            <div style={{ position: 'relative' }}>
              <img
                src={photos[photoIndex]}
                alt={`${car.brand} ${car.name} - foto ${photoIndex + 1}`}
              />

              {photos.length > 1 && (
                <>
                  <button
                    type="button"
                    aria-label="Foto precedente"
                    onClick={() => setPhotoIndex(i => (i - 1 + photos.length) % photos.length)}
                    style={{ position: 'absolute', left: 12, top: '45%', width: 34, height: 34, display: 'flex', alignItems: 'center', justifyContent: 'center', padding: 0, borderRadius: 8, background: 'rgba(15,15,15,0.55)', color: '#e4c68c', border: '1px solid rgba(201,164,92,0.45)', cursor: 'pointer', backdropFilter: 'blur(4px)' }}
                  >
                    <ChevronLeft size={17} strokeWidth={1.5} />
                  </button>

                  <button
                    type="button"
                    aria-label="Foto successiva"
                    onClick={() => setPhotoIndex(i => (i + 1) % photos.length)}
                    style={{ position: 'absolute', right: 12, top: '45%', width: 34, height: 34, display: 'flex', alignItems: 'center', justifyContent: 'center', padding: 0, borderRadius: 8, background: 'rgba(15,15,15,0.55)', color: '#e4c68c', border: '1px solid rgba(201,164,92,0.45)', cursor: 'pointer', backdropFilter: 'blur(4px)' }}
                  >
                    <ChevronRight size={17} strokeWidth={1.5} />
                  </button>

                  <div style={{ textAlign: 'center', marginTop: 10 }}>
                    {photoIndex + 1} / {photos.length}
                  </div>
                </>
              )}
            </div>
            <p className="photo-disclaimer">
              Immagine illustrativa del modello.
              La vettura effettiva può differire.
            </p>
          </div>

          <div className="car-detail-copy">
            <p className="eyebrow">{car.category}</p>
            <h1>{car.brand}<br/><em>{car.name}</em></h1>
            <p>{car.description}</p>

            <a
              href={whatsappLink(
                `Buongiorno, vorrei informazioni e un preventivo per ${car.brand} ${car.name}.`
              )}
              target="_blank"
              rel="noopener noreferrer"
              className="btn btn-gold"
            >
              RICHIEDI PREVENTIVO <ArrowUpRight size={18} color="#c9a45c"/>
            </a>

            <p className="car-credit">
              Foto: {car.credit?.author || "Foto L.M. Rent Car"} · {car.credit?.license || "Foto del veicolo"} ·{' '}
              <a
                href={car.credit?.source || "#"}
                target="_blank"
                rel="noopener noreferrer"
              >
                Fonte
              </a>
              {' · '}
              <a
                href={car.credit?.licenseUrl || "#"}
                target="_blank"
                rel="noopener noreferrer"
              >
                Licenza
              </a>
            </p>
          </div>
        </div>
      </section>
    </main>
  )
}
