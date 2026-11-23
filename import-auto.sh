#!/bin/bash
set -e

echo "🏎️ IMPORTAZIONE FOTOGRAFIE L.M. RENT CAR"

mkdir -p public/images/cars
mkdir -p public/images/showroom
mkdir -p backups/import-3

cp src/data/cars.js backups/import-3/cars.js
cp src/pages/Fleet.jsx backups/import-3/Fleet.jsx
cp src/components/CarCard.jsx backups/import-3/CarCard.jsx
cp src/pages/CarDetails.jsx backups/import-3/CarDetails.jsx

python3 - <<'PY'
import urllib.request
import re
import html
import json
import os

url = "https://lmrentcar.wixsite.com/lm-rent-car"

print("🌐 Collegamento al vecchio sito...")

req = urllib.request.Request(
    url,
    headers={"User-Agent": "Mozilla/5.0"}
)

with urllib.request.urlopen(req, timeout=30) as response:
    page = response.read().decode("utf-8", errors="ignore")

# Individua gli identificativi delle immagini Wix
matches = re.findall(
    r'(?:https?:)?(?:\\?/\\?/|//)static\.wixstatic\.com/media/([^"\'\s<>?\\]+)',
    page
)

# Ricerca alternativa negli URL incorporati
matches += re.findall(
    r'(f4f510_[a-zA-Z0-9]+~mv2\.(?:jpg|jpeg|png|webp))',
    page
)

unique = []

for item in matches:
    item = html.unescape(item)
    item = item.split("/")[0]
    item = item.replace("\\/", "/")

    if item not in unique and "~mv2." in item:
        unique.append(item)

print(f"📸 Immagini individuate: {len(unique)}")

os.makedirs("public/images/cars", exist_ok=True)

downloaded = []

for index, filename in enumerate(unique, 1):
    image_url = f"https://static.wixstatic.com/media/{filename}"
    extension = filename.split(".")[-1].lower()

    if extension not in ("jpg", "jpeg", "png", "webp"):
        continue

    destination = f"public/images/cars/wix-{index:02d}.{extension}"

    try:
        request = urllib.request.Request(
            image_url,
            headers={"User-Agent": "Mozilla/5.0"}
        )

        with urllib.request.urlopen(request, timeout=25) as response:
            data = response.read()

        if len(data) < 5000:
            continue

        with open(destination, "wb") as output:
            output.write(data)

        downloaded.append({
            "file": destination,
            "image": "/" + destination.replace("public/", "")
        })

        print(f"✅ Scaricata immagine {index}")

    except Exception as error:
        print(f"⚠️ Immagine {index}: {error}")

with open("public/images/cars/import-report.json", "w") as output:
    json.dump(downloaded, output, indent=2)

print(f"\n✅ Fotografie scaricate: {len(downloaded)}")
PY

echo ""
echo "📸 Controllo fotografie..."

find public/images/cars -type f

echo ""
echo "✅ IMPORTAZIONE TERMINATA"
