# FROM python:3.10-slim
# WORKDIR /python-docker
# COPY requirements.txt requirements.txt
# RUN apt-get update && apt-get install git -y
# RUN pip3 install -r requirements.txt
# RUN pip3 install "git+https://github.com/openai/whisper.git" 
# RUN apt-get update && apt-get install -y ffmpeg
# COPY . .
# EXPOSE 8000
# CMD ["uvicorn", "fastapi_app:app", "--host", "0.0.0.0", "--port", "8000"]


FROM python:3.10-slim

WORKDIR /code

COPY requirements.txt ./

# RUN pip3 install "git+https://github.com/openai/whisper.git" 

RUN apt-get update && apt-get install -y ffmpeg

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

RUN useradd -m -u 1000 user

USER user

ENV HOME=/home/user \
	PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

COPY --chown=user . $HOME/app/

CMD ["uvicorn", "fastapi_app:app", "--host", "0.0.0.0", "--port", "7860"]
