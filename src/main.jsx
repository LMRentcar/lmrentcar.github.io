import QuoteWidget from './components/QuoteWidget'
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.jsx'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <><App /><QuoteWidget /></>
  </StrictMode>,
)


requestAnimationFrame(() => {
  requestAnimationFrame(() => {
    document.getElementById('lm-boot-screen')?.remove()
  })
})
