# পাইথন বেস ইমেজ
FROM python:3.11-slim

# FFmpeg এবং অন্যান্য প্রয়োজনীয় টুল ইনস্টল করা
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# কাজের ডিরেক্টরি সেট করা
WORKDIR /app

# ফাইলগুলো কপি করা
COPY . .

# ডিপেন্ডেন্সি ইনস্টল করা
RUN pip install --no-cache-dir fastapi uvicorn yt-dlp sqlmodel pydantic pyyaml a2wsgi flask flask-cors innertube yt-dlp-bonus

# পোর্ট এক্সপোজ করা (FastAPI ডিফল্ট ৮০০০ ব্যবহার করে)
EXPOSE 8000

# সার্ভার চালু করার কমান্ড
CMD ["python", "-m", "fastapi", "run", "app", "--host", "0.0.0.0", "--port", "8000"]
