export const company = {
  name: 'L.M. RENT CAR',
  legalName: 'LM RENT CAR SRLS',
  vat: '11068671210',
  phone: '+39 380 639 3306',
  whatsapp: '393806393306',
  email: 'lmrentcar@outlook.it',
  address: 'Via Ferrari 49, 80036 Palma Campania (NA)',
  tagline: 'Noleggio auto economiche e di lusso'
}

export function whatsappLink(message) {
  return `https://wa.me/${company.whatsapp}?text=${encodeURIComponent(message)}`
}
