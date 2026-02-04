FROM node:22-alpine

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Install serve to serve static files
RUN npm install -g serve

# Start script that uses PORT env var
CMD sh -c "serve -s dist -l $PORT"
