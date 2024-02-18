FROM node:21-alpine as build

WORKDIR /app

COPY package.json ./

RUN npm i

COPY . .

RUN npm run build

# ------------Create a prod image----------------

FROM node:21-alpine
WORKDIR /app
COPY --from=build /app/package.json ./
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public
COPY --from=build /app/node_modules ./node_modules
ENV NODE_ENV=production
Expose 3000
CMD ["npm", "start"]