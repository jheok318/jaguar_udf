# 베이스 이미지 설정
FROM node:14 as build-stage
LABEL authors="jheok"

# 앱 디렉토리 생성 및 작업 디렉토리로 설정
WORKDIR /app

# 앱 종속성 설치
COPY package*.json ./
RUN npm install

# 소스 코드 복사
COPY . .

# 앱 빌드
RUN npm run build

# 프로덕션 환경을 위한 베이스 이미지 설정
FROM nginx:1.21

# Nginx 설정 파일 복사
COPY src/nginx.conf /etc/nginx/conf.d/default.conf

# 빌드된 앱 파일 복사
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Nginx 서버 실행
CMD ["nginx", "-g", "daemon off;"]