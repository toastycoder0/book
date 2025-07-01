#!/bin/bash

BOOK_DIR="$HOME/Documents/book"
DAYS_DIR="$BOOK_DIR/days"
TEMPLATES_DIR="$BOOK_DIR/templates"

DATE=$(date +%d-%m-%Y)

function list_days() {
  cd "$DAYS_DIR" || exit 1
  DAY=$(ls -1 | fzf --prompt="📅 Selecciona un día: ")
  [ -n "$DAY" ] && cd "$DAYS_DIR/$DAY" && exec $SHELL
}

function new_day() {
  TARGET="$DAYS_DIR/$DATE"

  if [ -d "$TARGET" ]; then
    echo "📁 Ya existe el día $DATE, abriendo..."
    cd "$TARGET" && exec $SHELL
  else
    mkdir -p "$TARGET"
    TEMPLATE_FILE="$TEMPLATES_DIR/daily_note.md"
    OUTPUT_FILE="$TARGET/daily.md"

    if [ -f "$TEMPLATE_FILE" ]; then
      sed "s/DD-MM-AAAA/$DATE/g" "$TEMPLATE_FILE" >"$OUTPUT_FILE"
    else
      echo "# 🗓️ Fecha: $DATE" >"$OUTPUT_FILE"
    fi

    echo "📁 Día $DATE creado en $TARGET"
    cd "$TARGET" && exec $SHELL
  fi
}

function new_note() {
  TARGET="$DAYS_DIR/$DATE"

  if [ ! -d "$TARGET" ]; then
    echo "❌ El día $DATE no existe. Ejecuta primero: book newday"
    exit 1
  fi

  HASH=$(openssl rand -hex 4)
  FILENAME="note-$HASH.md"
  TEMPLATE_FILE="$TEMPLATES_DIR/general_note.md"

  if [ -f "$TEMPLATE_FILE" ]; then
    sed "s/DD-MM-AAAA/$DATE/g" "$TEMPLATE_FILE" >"$TARGET/$FILENAME"
  else
    echo "# 📚 Asignatura: [Materia] — $DATE" >"$TARGET/$FILENAME"
  fi

  echo "📝 Nota creada: $TARGET/$FILENAME"
}

# Comandos
case "$1" in
days)
  list_days
  ;;
newday)
  new_day
  ;;
newnote)
  new_note
  ;;
*)
  echo "Uso: book [days | newday | newnote]"
  ;;
esac
