# 🚀 Mi Configuración de i3 (Dotfiles)

Repositorio personal con la configuración completa de mi entorno de escritorio i3wm.

## 📦 Componentes incluidos

- **i3wm** (`config/i3`): Configuración principal del gestor de ventanas, atajos de teclado y temas (Dracula).
- **Picom** (`config/picom`): Compositor de efectos visuales (transparencia, sombras, esquinas redondeadas).
- **Polybar** (`config/polybar`): Barra de estado personalizada.
- **Rofi** (`config/rofi`): Lanzador de aplicaciones y menú de apagado (*Power Menu*).
- **Kitty** (`config/kitty`): Configuración de la terminal.
- **Nitrogen** (`config/nitrogen`): Configuración del fondo de pantalla.
- **Scripts** (`scripts/`): Scripts personalizados (`adjust-brightness.sh`, `power-menu.sh`).
- **.Xresources** (`Xresources`): Configuración de recursos de X11.

---

## 🛠️ Instalación / Restauración en un nuevo sistema

1. **Clonar este repositorio** en tu directorio personal:
   ```bash
   git clone https://github.com/TU_USUARIO/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Dar permisos y ejecutar el script de instalación**:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

El script creará automáticamente los enlaces simbólicos (*symlinks*) desde `~/dotfiles` hacia `~/.config` y `~/.local/bin`.

---

## 💾 Crear un respaldo en repositorio remoto (GitHub / GitLab)

Para guardar tus dotfiles en GitHub o GitLab:

```bash
cd ~/dotfiles
git remote add origin https://github.com/TU_USUARIO/dotfiles.git
git branch -M main
git push -u origin main
```

---

## 📦 Crear un archivo comprimido de respaldo (Backup `.tar.gz`)

Si prefieres guardarlo como archivo comprimido en una memoria USB o la nube:

```bash
tar -czvf ~/i3-dotfiles-backup.tar.gz -C ~ dotfiles
```

Para restaurar desde el `.tar.gz`:

```bash
tar -xzvf i3-dotfiles-backup.tar.gz -C ~
cd ~/dotfiles && ./install.sh
```
