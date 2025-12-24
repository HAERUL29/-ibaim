#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/HAERUL29/-ibaim.git"
BRANCH="main"

if [ ! -d "-ibaim" ]; then
  git clone "$REPO_URL"
fi
cd -ibaim

git fetch origin
if git show-ref --verify --quiet refs/heads/$BRANCH; then
  git checkout $BRANCH
  git pull origin $BRANCH
else
  git checkout -b $BRANCH
fi

cat > README.md <<'EOF'
# -ibaim

Deskripsi singkat
- -ibaim adalah repositori placeholder untuk memulai proyek Anda. Gunakan README ini sebagai template dan sesuaikan isi sesuai tujuan proyek.

Fitur
- Ringkasan fitur/tujuan singkat proyek.
- Contoh: dokumentasi, skrip build sederhana, template CI.

Status
- Status: awal / inisialisasi
- Bahasa utama: (sesuaikan)

Instalasi
1. Clone repository:
   git clone https://github.com/HAERUL29/-ibaim.git
2. Masuk ke direktori:
   cd -ibaim
3. Ikuti instruksi spesifik bahasa/ruang lingkup proyek (lihat bagian Usage atau CONTRIBUTING).

Contoh penggunaan
- Jalankan perintah contoh di sini (ganti sesuai stack):
  - Node: `npm install` lalu `npm start`
  - Python: `python -m venv venv && source venv/bin/activate && pip install -r requirements.txt`

Struktur direktori (contoh)
- src/        - kode sumber
- tests/      - unit/integration tests
- .github/    - workflow CI/CD

Contributing
1. Fork repository ini.
2. Buat branch fitur: `git checkout -b feature/nama-fitur`
3. Commit perubahan: `git commit -m "Tambah fitur: ..."`
4. Push ke fork dan buat Pull Request.

License
This project is licensed under the MIT License - lihat file LICENSE untuk detail.

Kontak
- Pemilik: HAERUL29
- URL repo: https://github.com/HAERUL29/-ibaim

---
README skeleton dibuat untuk memudahkan memulai; silakan edit sesuai kebutuhan.
EOF

cat > LICENSE <<'EOF'
MIT License

Copyright (c) 2025 HAERUL29

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

cat > .gitignore <<'EOF'
# General
.DS_Store
Thumbs.db
*.log
.env

# Node
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Python
__pycache__/
*.py[cod]
venv/
.env

# Build
dist/
build/

# IDEs
.vscode/
.idea/

# OS
Thumbs.db
Desktop.ini
EOF

mkdir -p .github/workflows
cat > .github/workflows/ci.yml <<'EOF'
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v4

    - name: Set up Node.js (optional)
      uses: actions/setup-node@v4
      with:
        node-version: '16'

    - name: Install dependencies (if package.json exists)
      run: |
        if [ -f package.json ]; then npm ci; else echo "No package.json, skipping install"; fi

    - name: Run tests (if defined)
      run: |
        if [ -f package.json ] && grep -q "\"test\"" package.json; then npm test; else echo "No tests defined, skipping"; fi

    - name: Lint (example)
      run: |
        echo "Add lint steps relevant to your project (eslint, flake8, etc.)"
EOF

git add README.md LICENSE .gitignore .github/workflows/ci.yml
if git diff --staged --quiet; then
  echo "No changes to commit."
else
  git commit -m "Add README, LICENSE, .gitignore, and CI workflow"
  git push origin $BRANCH
  echo "Files pushed to $BRANCH."
fi