FROM python:3.12-slim AS python-base
ENV UV_COMPILE_BYTECODE=1 \
    \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"
ENV PATH="$VENV_PATH/bin:$PATH"


FROM python-base AS builder-base
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        build-essential \
        curl \
        ca-certificates 
WORKDIR $PYSETUP_PATH
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

COPY uv.lock pyproject.toml ./
RUN uv sync --frozen --no-install-project --no-dev

# [Experimental] Remove unused nicegui libs
ENV NICEGUI_LIB_PATH="$VENV_PATH/lib/python3.12/site-packages/nicegui/elements/lib"
RUN rm -rf "$NICEGUI_LIB_PATH/mermaid/"
RUN rm -rf "$NICEGUI_LIB_PATH/plotly/"
RUN rm -rf "$NICEGUI_LIB_PATH/vanilla-jsoneditor/"


FROM python-base AS production
COPY --from=builder-base $PYSETUP_PATH $PYSETUP_PATH

RUN addgroup --gid 65534 nonroot && \
    adduser --uid 65534 --gid 65534 --disabled-password --gecos "" nonroot
USER nonroot

WORKDIR /app
COPY start.sh .
COPY beaverhabits ./beaverhabits
COPY statics ./statics
RUN chmod -R g+w /app && \
    chown -R nonroot /app
USER nonroot

CMD ["sh", "start.sh", "prd"]
