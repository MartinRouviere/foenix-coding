import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  const bounds = new mapboxgl.LngLatBounds();
  bounds.extend([ -0.54864, 51.39261 ]);

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/ifeodugbesan/ckvfctdyig8il14o8gl44ivva'
    });

    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('/assets/marker.png')`;
    element.style.backgroundSize = 'contain';
    element.style.backgroundPosition = 'center';
    element.style.backgroundRepeat = 'no-repeat';
    element.style.width = '40px';
    element.style.height = '40px';

    new mapboxgl.Marker(element)
      .setLngLat([ -0.54864, 51.39261 ])
      .addTo(map);

    map.fitBounds(bounds, { padding: 70, maxZoom: 7, duration: 0 });
  }
};

export { initMapbox };
