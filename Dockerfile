# পাইথন বেস ইমেজ
FROM python:3.11-slim

# প্রয়োজনীয় সিস্টেম ডিপেন্ডেন্সি ইনস্টল করা (gcc এবং অন্যান্য বিল্ড টুলস সহ)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    gcc \
    python3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# কাজের ডিরেক্টরি
WORKDIR /app

# ফাইলগুলো কপি করা
COPY . .

# সরাসরি ডিপেন্ডেন্সিগুলো ইনস্টল করা
RUN pip install --no-cache-dir \
    fastapi \
    "uvicorn[standard]" \
    yt-dlp \
    sqlmodel \
    pydantic \
    pyyaml \
    a2wsgi \
    flask \
    flask-cors \
    innertube \
    yt-dlp-bonus

# রেন্ডার পোর্টের জন্য এনভায়রনমেন্ট ভ্যারিয়েবল (Render ডিফল্ট ১০০০০ ব্যবহার করে)
ENV PORT=10000

# সার্ভার চালু করার কমান্ড
# এখানে 'app:app' মানে app ফোল্ডারের ভেতর __init__.py থেকে 'app' অবজেক্টটি রান হবে
CMD ["python", "-m", "fastapi", "run", "app", "--host", "0.0.0.0", "--port", "10000"]
