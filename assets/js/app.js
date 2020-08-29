import 'jquery/dist/jquery.slim.min';
import 'moment/moment';
import 'popper.js/dist/popper.min';
import 'fuse.js/dist/fuse';
import 'bootstrap/dist/js/bootstrap.min';
import 'bootstrap-select-dropdown/dist/bootstrap-select-dropdown.min';
import "phoenix_html"
import "tempusdominus-bootstrap-4/build/js/tempusdominus-bootstrap-4.min";


import "mdn-polyfills/Object.assign"
import "mdn-polyfills/CustomEvent"
import "mdn-polyfills/String.prototype.startsWith"
import "mdn-polyfills/Array.from"
import "mdn-polyfills/NodeList.prototype.forEach"
import "mdn-polyfills/Element.prototype.closest"
import "mdn-polyfills/Element.prototype.matches"
import "mdn-polyfills/Node.prototype.remove"
import "child-replace-with-polyfill"
import "url-search-params-polyfill"
import "formdata-polyfill"
import "classlist-polyfill"
import "@webcomponents/template"
import "shim-keyboard-event-key"

import NProgress from "nprogress"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

$(document).ready(function(){
  if(document.URL.match("daily_reports/new")) {
    let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
    let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})
    // Show progress bar on live navigation and form submits
    window.addEventListener("phx:page-loading-start", info => NProgress.start())
    window.addEventListener("phx:page-loading-stop", info => NProgress.done())
    // connect if there are any LiveViews on the page
    liveSocket.connect()
    // expose liveSocket on window for web console debug logs and latency simulation:
    // >> liveSocket.enableDebug()
    // >> liveSocket.enableLatencySim(1000)
    window.liveSocket = liveSocket
    $('#reporting_date').datetimepicker({
      format: 'YYYY-MM-DD',
      locale: 'ja',
      dayViewHeaderFormat: 'YYYY年 MMM',
    });
  }
});
