# পাইথন বেস ইমেজ
FROM python:3.11-slim

# ভিডিও প্রসেসিং এর জন্য FFmpeg এবং অন্যান্য টুলস ইনস্টল করা
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# কাজের ডিরেক্টরি সেট করা
WORKDIR /app

# সব ফাইল কপি করা
COPY . .

# লাইব্রেরিগুলো ইনস্টল করা
RUN pip install --no-cache-dir fastapi uvicorn yt-dlp sqlmodel pydantic pyyaml a2wsgi flask flask-cors innertube yt-dlp-bonus

# Hugging Face ডিফল্টভাবে ৭৮৬০ পোর্ট ব্যবহার করে
EXPOSE 7860

# সার্ভার চালু করার কমান্ড (অবশ্যই ৭৮৬০ পোর্টে রান করতে হবে)
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]
