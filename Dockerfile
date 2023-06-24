FROM python:3.11-bookworm as pre-build

ENV POETRY_HOME=/opt/poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

FROM pre-build as build

WORKDIR /app

COPY ./pyproject.toml ./
COPY ./poetry.lock ./

RUN $POETRY_HOME/bin/poetry install

COPY ./mkdocs.yml ./
COPY ./docs ./docs
COPY ./README.md ./docs/README.md

RUN $POETRY_HOME/bin/poetry run mkdocs build


FROM python:3.11-alpine as runtime

WORKDIR /app

COPY --from=build ./app/site ./

ENTRYPOINT [ "python3" ]
CMD [ "-m", "http.server", "8000" ]