# Sandwich Shop

This is a simple Flutter app that allows users to order sandwiches.
The app is built using Flutter and Dart, and it is designed primarily to be run in a web
browser.

## Install the essential tools

1. **Terminal**:

    - **macOS** – use the built-in Terminal app by pressing **⌘ + Space**, typing **Terminal**, and pressing **Return**.
    - **Windows** – open the start menu using the **Windows** key. Then enter **cmd** to open the **Command Prompt**. Alternatively, you can use **Windows PowerShell** or **Windows Terminal**.

2. **Git** – verify that you have `git` installed by entering `git --version`, in the terminal.
    If this is missing, download the installer from [Git's official site](https://git-scm.com/downloads?utm_source=chatgpt.com).

3. **Package managers**:

    - **Homebrew** (macOS) – verify that you have `brew` installed with `brew --version`; if missing, follow the instructions on the [Homebrew installation page](https://brew.sh/).
    - **Chocolatey** (Windows) – verify that you have `choco` installed with `choco --version`; if missing, follow the instructions on the [Chocolatey installation page](https://chocolatey.org/install).

4. **Flutter SDK** – verify that you have `flutter` installed and it is working with `flutter doctor`; if missing, install it using your package manager:

    - **macOS**: `brew install --cask flutter`
    - **Windows**: `choco install flutter`

5. **Visual Studio Code** – verify that you have `code` installed with `code --version`; if missing, use your package manager to install it:

    - **macOS**: `brew install --cask visual-studio-code`
    - **Windows**: `choco install vscode`

## Get the code

### If this is your first time working on this project

Enter the following commands in your terminal to clone the repository and
open it in Visual Studio Code.
You may want to change directory (`cd`) to the directory where you want to clone the
repository first.

```bash
git clone --branch 8 https://github.com/manighahrmani/sandwich_shop
cd sandwich_shop
code .
```

### If you have already cloned the repository

Enter the following commands in your terminal to switch to the correct branch.
Remember to `cd` to the directory where you cloned the repository first.

```bash
git fetch origin
git checkout 8
```

## Run the app

Open the integrated terminal in Visual Studio Code by first opening the Command
Palette with **⌘ + Shift + P** (macOS) or **Ctrl + Shift + P** (Windows) and
typing **Terminal: Create New Terminal** then pressing **Enter**.

In the terminal, run the following commands to install the dependencies and run
the app in your web browser:

```bash
flutter pub get
flutter run
```

## Web Release Build

To build a production (release) version of the app for the web and serve it locally, use the Flutter tool and a simple static server. From the project root run the following PowerShell commands:

```powershell
Set-Location -Path .\sandwich_shop
flutter clean
flutter pub get
flutter build web --release
# Serve the built files locally (simple Python server shown below). Change to the build output folder:
Set-Location -Path .\build\web
# If you have Python installed, run:
python -m http.server 8000
# Or use PowerShell's built-in web server (PowerShell 5.1):
# (starts an HTTP listener on port 8000)
# Add-Type -AssemblyName System.Net.HttpListener; $listener = New-Object System.Net.HttpListener; $listener.Prefixes.Add('http://*:8000/'); $listener.Start(); Write-Host 'Serving on http://localhost:8000'; while ($listener.IsListening) { $ctx = $listener.GetContext(); $resp = $ctx.Response; $path = $ctx.Request.RawUrl.TrimStart('/') -replace '\\','/'; if ([string]::IsNullOrEmpty($path)) { $path = 'index.html' }; $file = Join-Path (Get-Location) $path; if (Test-Path $file) { $bytes = [System.IO.File]::ReadAllBytes($file); $resp.ContentLength64 = $bytes.Length; $resp.OutputStream.Write($bytes,0,$bytes.Length) } else { $resp.StatusCode = 404 }; $resp.Close() }

```

Notes:
- `flutter build web --release` outputs optimized static files to `./build/web/`.
- Use `python -m http.server` (Python 3) for a quick local server, or any static file server (nginx, Caddy, http-server from npm, etc.).
- Serving files directly from the `build/web` directory simulates how the app will behave when deployed to a static host (GitHub Pages, Netlify, Firebase Hosting, S3 + CloudFront, etc.).
- When deploying, upload the contents of `build/web/` to your hosting provider and configure the host for single-page-app (SPA) routing if needed (redirect unknown routes to `index.html`).

## Get support

Use [the dedicated Discord channel](https://discord.com/channels/760155974467059762/1370633732779933806)
to ask your questions and get help from the community.
Please provide as much context as possible, including the error messages you are seeing and
screenshots (you can open Discord in your web browser).
