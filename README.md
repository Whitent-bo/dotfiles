# 🚀 Dotfiles y Configuración del Sistema (Debian + i3wm + Bash)

Repositorio personal con la configuración completa del sistema, gestor de ventanas i3, shell Bash, herramientas de terminal y programas indispensables.

---

## 📦 Componentes Incluidos

### 1. Entorno de Ventanas & Gráfico
- **i3wm** (`config/i3`): Configuración principal del gestor de ventanas, atajos y temas.
- **Picom** (`config/picom`): Compositor de efectos visuales (transparencias, sombras, esquinas redondeadas).
- **Polybar** (`config/polybar`): Barra de estado personalizada.
- **Rofi** (`config/rofi`): Lanzador de aplicaciones y menú de apagado (*Power Menu*).
- **Kitty** (`config/kitty`): Terminal principal acelerada por GPU y atajos.
- **Nitrogen** (`config/nitrogen`): Configuración del fondo de pantalla.
- **.Xresources** (`Xresources`): Parámetros y fuentes de X11.

### 2. Shell & Terminal
- **Bash** (`bash/.bashrc`, `bash/.bash-preexec.sh`): Configuración interactiva, prompt con colores, alias (`batcat`, navegación) y soporte de autocompletado.
- **Fastfetch** (`config/fastfetch`): Información del sistema con formato visual.
- **Btop** (`config/btop`): Monitor de recursos del sistema en terminal y temas.
- **Ranger** (`config/ranger`): Navegador de archivos en terminal.
- **Atuin** (`config/atuin`): Sincronización y búsqueda avanzada del historial de shell.

### 3. Scripts Utilitarios (`scripts/`)
- `adjust-brightness.sh`: Ajuste dinámico de brillo de pantalla.
- `power-menu.sh`: Menú rápido de apagado/reinicio con Rofi.
- `terminal-clock.sh`: Reloj digital en terminal.
- `pmdr`: Temporizador Pomodoro para terminal.

### 4. Paquetes Indispensables
- `packages-apt.txt`: Lista curada de paquetes y dependencias base para instalar en Debian 13 (Trixie) u otros sistemas basados en Debian/Ubuntu.

---

## 🛠️ Instalación y Restauración en un Nuevo Sistema

Cuando instales un sistema operativo nuevo o quieras clonar tu entorno en otra máquina:

### Paso 1: Clonar el Repositorio
```bash
git clone git@github.com:Whitent-bo/dotfiles.git ~/dotfiles
# O por HTTPS si aún no has cargado tu llave SSH:
# git clone https://github.com/Whitent-bo/dotfiles.git ~/dotfiles

cd ~/dotfiles
```

### Paso 2: Ejecutar el Instalador

- **Opción A (Recomendada en instalación limpia - instala paquetes + enlaza configuraciones):**
  ```bash
  ./install.sh --install-packages
  ```

- **Opción B (Solo enlazar configuraciones y scripts, sin reinstalar paquetes):**
  ```bash
  ./install.sh
  ```

El script se encargará de:
1. Instalar las dependencias de `packages-apt.txt` vía `apt` (si se usa `--install-packages`).
2. Crear respaldos automáticos `.bak` de cualquier archivo existente.
3. Crear enlaces simbólicos (*symlinks*) desde `~/dotfiles` hacia `~/.config`, `~/.local/bin` y `$HOME`.
4. Recargar `i3` automáticamente si la sesión gráfica está abierta.

---

## 🤖 Integración con Antigravity / Claude (MCP GitHub)

Este repositorio puede ser sincronizado o gestionado mediante el servidor MCP de GitHub oficial (`@modelcontextprotocol/server-github`).
La configuración se define en `~/.gemini/config/mcp_config.json`:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```
