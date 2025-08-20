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

## Сборка в Docker

Есть два сценария: нативная сборка для Linux (Debian) и сборка Windows-артефактов через Wine.

- Docker (Linux/Debian): `docker/Dockerfile.debian`
  - Собирает внутри `docker build` с использованием `uv run`, как в локальных скриптах.
  - Артефакты попадают в корень финального слоя. Рекомендуемый экспорт — через BuildKit `--output`.
  - Аргументы сборки: `--build-arg APP_NAME=pygato --build-arg ENTRY=main.py --build-arg TARGET=pyinstaller|nuitka|both`.
  - Экспорт в директорию:
    - Docker: `docker buildx build -f docker/Dockerfile.debian --build-arg TARGET=both --output type=local,dest=dist/linux .`
    - Podman: `podman build -f docker/Dockerfile.debian --build-arg TARGET=both --output type=local,dest=dist/linux .`
  - Экспорт в tar:
    - Docker: `docker buildx build -f docker/Dockerfile.debian --build-arg TARGET=both --output type=tar,dest=dist/linux.tar .`
    - Podman: `podman build -f docker/Dockerfile.debian --build-arg TARGET=both --output type=tar,dest=dist/linux.tar .`

- Docker (Windows через Wine): `docker/Dockerfile.wine` (на базе `tobix/pywine`)
  - Внутри `docker build` всё выполняется через Wine с Windows `uv.exe`: `uv run pyinstaller/nuitka`.
  - Аргументы сборки: `--build-arg APP_NAME=pygato --build-arg ENTRY=main.py --build-arg TARGET=pyinstaller|nuitka|both --build-arg PYWINE_TAG=3.13`.
  - Экспорт в директорию:
    - Docker: `docker buildx build -f docker/Dockerfile.wine --build-arg TARGET=pyinstaller --build-arg PYWINE_TAG=3.13 --output type=local,dest=dist/windows .`
    - Podman: `podman build -f docker/Dockerfile.wine --build-arg TARGET=pyinstaller --build-arg PYWINE_TAG=3.13 --output type=local,dest=dist/windows .`
  - Экспорт в tar:
    - Docker: `docker buildx build -f docker/Dockerfile.wine --build-arg TARGET=pyinstaller --build-arg PYWINE_TAG=3.13 --output type=tar,dest=dist/windows.tar .`
    - Podman: `podman build -f docker/Dockerfile.wine --build-arg TARGET=pyinstaller --build-arg PYWINE_TAG=3.13 --output type=tar,dest=dist/windows.tar .`

Содержимое экспорта:
- Linux: `pyinstaller/` и/или `nuitka/` с бинарниками.
- Windows: `windows/pyinstaller/` и/или `windows/nuitka/`.

Оба Dockerfile повторяют подход локальных билдов: используется `uv run` для запуска PyInstaller/Nuitka; под Windows всё запускается через Wine и `uv.exe`.
