
FROM python:3.7

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV YOUR_NAME=David

EXPOSE 5000

CMD ["python", "app.py"]
