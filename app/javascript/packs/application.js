// import "trix";
import "bootstrap";
import "./cookie_bar"
import AOS from 'aos';
import 'aos/dist/aos.css';
import simpleParallax from 'simple-parallax-js';
import { initMapbox } from '../plugins/init_mapbox';


initMapbox();
AOS.init();

document.querySelector('.bar-close').addEventListener('click', () => {
  document.querySelector('.top-bar').remove();
})

const image = document.querySelectorAll('.parallax-img');
new simpleParallax(image, {
  scale: 1.3,
  overflow: true
});
