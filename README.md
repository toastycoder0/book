# 📚 book — Sistema de notas académicas portable

Este repositorio contiene mi sistema personalizado de gestión de notas académicas para la universidad. Está diseñado para ser **rápido, físico, flexible y automatizable**, combinando el poder del markdown, `fzf` y plantillas reutilizables.

## 🗂️ Estructura del repositorio

```
book/
├── templates/
│   ├── daily-template.md       # Plantilla diaria
│   └── note-template.md        # Plantilla de nota general
├── days/
│   ├── 27-06-2025/
│   │   ├── daily.md
│   │   └── note-xxxxx.md
│   └── ...
├── scripts/
│   └── manager.sh               # Script CLI para gestionar notas
└── README.md
```

## 🔧 Requisitos

- GNU/Linux (probado en Arch) o MacOS
- `fzf`, `bash`, `date`, `shuf`
- Neovim (opcional para edición rápida)

---

## ✍️ ¿Cómo uso este sistema?

### 1. Crear o acceder a un día

```bash
./scripts/manager.sh newday
```

- Crea una nueva carpeta en `days/` con la fecha actual (`DD-MM-AAAA`)
- Si ya existe, entra directamente

### 2. Crear una nueva nota general

```bash
./scripts/manager.sh newnote
```

- Genera una nueva nota general con nombre aleatorio
- Basada en la plantilla `note-template.md`

### 3. Navegar entre días

```bash
./scripts/manager.sh days
```

- Lista todos los días registrados y navega con `fzf` a cualquiera

---

## 🛠️ TODOs futuros

- [x] Integración con Git para versionar notas
- [ ] Sincronización con un servidor personal
- [ ] Script para exportar/respaldar toda la carpeta como PDF/ZIP
