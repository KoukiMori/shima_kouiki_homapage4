'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "09de874346eb07647a5752f9db9f0c83",
"version.json": "d9d175e79d83907d600380ff50817091",
"index.html": "0ec8b496b4acdc551ca06aece296e79a",
"/": "0ec8b496b4acdc551ca06aece296e79a",
"main.dart.js": "8ef1bbb9be141fe956e5c72de640b7c5",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "5608ac10b9dae3a3eb9447d8d916e8c5",
"assets/AssetManifest.json": "140a80161468e192761c9dcf1662f118",
"assets/NOTICES": "ca9efe2e8c1bdc30330d86e2d27b5131",
"assets/FontManifest.json": "dfff7983972389520f46b424f9c55844",
"assets/AssetManifest.bin.json": "7e70d8bb1d52674d7c924dd548b09397",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "b079baffe0fcf00ba202ed284efda414",
"assets/fonts/NotoSansJP-Bold.ttf": "485e5ded4ecbe334b90b239f662c968b",
"assets/fonts/NotoSerifJP-Regular.ttf": "dbd50dd8eeb84428bd905845f4937e53",
"assets/fonts/NotoSerifJP-Bold.ttf": "886d5a999ea329c1f3d0bd24a2884f00",
"assets/fonts/NotoSansJP-Regular.ttf": "d7b3c0ac56050de4c152bd8394a16c9a",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/fonts/Biryani-SemiBold.ttf": "ac266aa76a0a86d25e7e233942b76481",
"assets/fonts/Fascinate-Regular.ttf": "618b096a0dc09f62319ff3eb70ed0c61",
"assets/assets/tomoyama_bay.jpg": "f9acfb7763ffe8337a9706047ffa2744",
"assets/assets/map.png": "4a889ec5f11e96728a19b3b6e39a14ae",
"assets/assets/car_chair.png": "7daa1aa119a551707cc1fc0b0b3ef5b2",
"assets/assets/logo.png": "a06b8157c600267ba07c075cc7e72060",
"assets/assets/Google_Maps_Logo_2020.svg.png": "b0f689c6ae56695dc2308b728ed6b58d",
"assets/assets/shima_ago_bay.jpg": "53d3075979e2c974e58f2ace638a1d7b",
"canvaskit/skwasm.js": "bb7f9a4f8e1315e306e274ee39c92280",
"canvaskit/skwasm_heavy.js": "ff62b0ccde0d87bb610723a5276bfcfc",
"canvaskit/skwasm.js.symbols": "c37eb3c2a27b871f736b6ad6c5775af3",
"canvaskit/canvaskit.js.symbols": "b9fd91de63115c85d6d718fa54940d5d",
"canvaskit/skwasm_heavy.js.symbols": "7796a7b188709b3a483a471911e3d566",
"canvaskit/skwasm.wasm": "a9650da48c9f89f0700934224a7552a3",
"canvaskit/chromium/canvaskit.js.symbols": "71f9bf3e56a622d8d06e76211dc0cc90",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "44846e7f02698e2f6d9ace08d12e88c8",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "7a68d18e4c0a8ce2e2af4aa9148d6eb9",
"canvaskit/skwasm_heavy.wasm": "3b844ebf2432c40b467b51d24ab8454f"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
