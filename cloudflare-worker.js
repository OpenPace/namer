addEventListener('fetch', event => {
  event.respondWith(handleResponse(event.request));
});

async function handleResponse(request) {
  let url = new URL(request.url);
  const pathname = url.pathname;

  // Remove trailing slash for any url except /
  if (pathname.length > 1 && pathname.endsWith('/')) {
    url.pathname = pathname.substring(0, pathname.length - 1);
    return Response.redirect(url, 301);
  }

  // default to webflow for most pages
  url.hostname = 'openpace.webflow.io';

  // Handle anything that is under the /namer/ path
  if (/^\/namer\/.+$/.test(pathname)) {
    url.pathname = url.pathname.replace('/namer', '');
    url.hostname = 'activity-namer.herokuapp.com';
  }

  // Synthetic response for robots.txt
  if (url.pathname === '/robots.txt') {
    return new Response("Sitemap: https://www.openpace.co/sitemap.xml", {
      headers: { "Content-Type": "text/plain" },
      status: 200,
    });
  }

  return fetch(new Request(url, request));
}
