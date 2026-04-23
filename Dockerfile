# পাইথন বেস ইমেজ
FROM python:3.11-slim

# প্রয়োজনীয় সিস্টেম টুলস ইনস্টল করা
RUN apt-get update && apt-get install -y \
    ffmpeg \
    gcc \
    python3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# কাজের ডিরেক্টরি
WORKDIR /app

# সব ফাইল কপি করা
COPY . .

# ডিপেন্ডেন্সিগুলো ইনস্টল করা (standard সহ)
RUN pip install --no-cache-dir \
    "fastapi[standard]" \
    uvicorn \
    yt-dlp \
    sqlmodel \
    pydantic \
    pyyaml \
    a2wsgi \
    flask \
    flask-cors \
    innertube \
    yt-dlp-bonus

# রেন্ডারের ডিফল্ট পোর্ট ১০০০০
EXPOSE 10000

# ইউভিকর্ন (Uvicorn) দিয়ে সরাসরি রান করা
# এখানে 'app:app' মানে app ফোল্ডারের ভেতরের __init__.py ফাইলে থাকা app অবজেক্ট
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "10000"]
