## Сборка

Скрипты для сборки находятся в `scripts/`.

- PyInstaller: `scripts/build_pyinstaller.sh`
- Nuitka: `scripts/build_nuitka.sh`

По умолчанию собирается из `main.py` в один исполняемый файл с именем `pygato`.

Перед сборкой убедитесь, что зависимости установлены (например, через `uv` или `pip`).

### Примеры

- PyInstaller:
  - `bash scripts/build_pyinstaller.sh`
  - Переменные окружения (необязательно): `APP_NAME=pygato ENTRY=main.py`

- Nuitka:
  - `bash scripts/build_nuitka.sh`
  - Переменные окружения (необязательно): `APP_NAME=pygato ENTRY=main.py`

Если используется локальное виртуальное окружение `.venv`, скрипты автоматически возьмут инструменты из него.
