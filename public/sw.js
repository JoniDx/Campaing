const CACHE_OFFLINE = "campania-cache-v1";
var urlsToCache = [
  "/"
];

self.addEventListener("install", event => {
  event.waitUntil(
    caches.open(CACHE_OFFLINE).then(cache => {
      return cache.addAll(urlsToCache);
    })
  );

  self.skipWaiting();
});

self.addEventListener('fetch', event => {
  const offlineResp = caches.open(CACHE_OFFLINE).then(cache => cache.match('/'));
  const resp = fetch(event.request)
    .catch(() => offlineResp);

  event.respondWith(resp);
});

// Escuchar PUSH
self.addEventListener('push', e => {
  const data = JSON.parse(e.data.text());

  const title = data.title;
  const options = {
    body: data.body,
    icon: data.icon,
    badge: data.badge,
    data: {
      url: data.url
    }
  };

  e.waitUntil(self.registration.showNotification(title, options));
});