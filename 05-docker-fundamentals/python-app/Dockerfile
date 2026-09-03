FROM python:3.12-slim

WORKDIR /app

# deps before code, so editing app.py doesn't re-run pip install
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py ./

EXPOSE 5000

CMD ["python", "app.py"]
