/* ============================================================================
   Field guide — tabs for the kind of data, a popup for each form.

   PROGRESSIVE ENHANCEMENT, ON PURPOSE, like the gallery filter. The shortcode
   renders every section and every form in full, and every leaf is a plain
   link to its form's anchor. With JavaScript off that is a complete reference
   page. This file only rearranges it: sections become tabs, and the forms move
   into one <dialog> that shows a single form at a time.

   DEEP LINKS work both ways, so a lab page can point at a form:
     field-guide.html#form-scatter   opens the scatterplot, in its tab
     field-guide.html#ch-time        opens the Time tab
   ========================================================================= */

(function () {
  "use strict";

  var root = document.querySelector("[data-chooser]");
  if (!root || typeof HTMLDialogElement === "undefined") return;

  var nav    = root.querySelector(".dsvar-ch__tabs");
  var tabs   = Array.prototype.slice.call(nav.querySelectorAll("[data-tab]"));
  var panels = Array.prototype.slice.call(root.querySelectorAll(".dsvar-ch__panel"));
  var list   = root.querySelector(".dsvar-forms");
  var forms  = Array.prototype.slice.call(root.querySelectorAll(".dsvar-form"));

  root.classList.add("dsvar-ch--js");

  // ---- tabs --------------------------------------------------------------
  nav.setAttribute("role", "tablist");
  tabs.forEach(function (t) {
    var id = t.getAttribute("data-tab");
    var panel = document.getElementById("ch-" + id);
    t.setAttribute("role", "tab");
    t.setAttribute("aria-controls", "ch-" + id);
    panel.setAttribute("role", "tabpanel");
    panel.setAttribute("aria-labelledby", t.id);
  });

  var currentTab = null;

  function showTab(id, focus) {
    currentTab = id;
    tabs.forEach(function (t) {
      var on = t.getAttribute("data-tab") === id;
      t.classList.toggle("dsvar-chip--on", on);
      t.setAttribute("aria-selected", on ? "true" : "false");
      t.setAttribute("tabindex", on ? "0" : "-1");
      if (on && focus) t.focus();
    });
    panels.forEach(function (p) { p.hidden = p.id !== "ch-" + id; });
  }

  tabs.forEach(function (t, i) {
    t.addEventListener("click", function (e) {
      e.preventDefault();
      showTab(t.getAttribute("data-tab"));
      history.replaceState(null, "", "#ch-" + t.getAttribute("data-tab"));
    });
    t.addEventListener("keydown", function (e) {
      var j = null;
      if (e.key === "ArrowRight") j = (i + 1) % tabs.length;
      if (e.key === "ArrowLeft")  j = (i - 1 + tabs.length) % tabs.length;
      if (e.key === "Home") j = 0;
      if (e.key === "End")  j = tabs.length - 1;
      if (j === null) return;
      e.preventDefault();
      showTab(tabs[j].getAttribute("data-tab"), true);
      history.replaceState(null, "", "#ch-" + tabs[j].getAttribute("data-tab"));
    });
  });

  // ---- the popup -----------------------------------------------------------
  var dlg = document.createElement("dialog");
  dlg.className = "dsvar-ch__dialog";
  dlg.innerHTML =
    '<button type="button" class="dsvar-ch__close" aria-label="Close">' +
      '<svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" ' +
      'stroke-width="2.2" stroke-linecap="round" aria-hidden="true"><path d="M6 6l12 12M18 6L6 18"/></svg>' +
    '</button>' +
    '<div class="dsvar-ch__dialogbody"></div>' +
    '<div class="dsvar-ch__step">' +
      '<button type="button" class="dsvar-ch__prev"></button>' +
      '<button type="button" class="dsvar-ch__next"></button>' +
    '</div>';
  root.appendChild(dlg);

  var body = dlg.querySelector(".dsvar-ch__dialogbody");
  var prev = dlg.querySelector(".dsvar-ch__prev");
  var next = dlg.querySelector(".dsvar-ch__next");

  forms.forEach(function (f) { f.hidden = true; body.appendChild(f); });
  if (list) list.hidden = true;

  // The forms of a tab, in the order its tree shows them, each once.
  function sequence(tabId) {
    var seen = {}, out = [];
    var panel = document.getElementById("ch-" + tabId);
    if (!panel) return out;
    panel.querySelectorAll("[data-form]").forEach(function (a) {
      var id = a.getAttribute("data-form");
      if (!seen[id]) { seen[id] = true; out.push(id); }
    });
    return out;
  }

  function nameOf(id) {
    var h = document.getElementById("form-" + id + "-name");
    return h ? h.textContent : id;
  }

  var opener = null, currentForm = null;

  function openForm(id, from) {
    var f = document.getElementById("form-" + id);
    if (!f) return;
    currentForm = id;
    if (from) opener = from;
    forms.forEach(function (x) { x.hidden = x !== f; });
    dlg.setAttribute("aria-labelledby", "form-" + id + "-name");

    var seq = sequence(currentTab), k = seq.indexOf(id);
    var p = k > 0 ? seq[k - 1] : null, n = k >= 0 && k < seq.length - 1 ? seq[k + 1] : null;
    prev.hidden = !p; next.hidden = !n;
    if (p) { prev.textContent = "← " + nameOf(p); prev.dataset.form = p; }
    if (n) { next.textContent = nameOf(n) + " →"; next.dataset.form = n; }

    if (!dlg.open) dlg.showModal();
    body.scrollTop = 0;
    history.replaceState(null, "", "#form-" + id);
  }

  root.addEventListener("click", function (e) {
    var a = e.target.closest && e.target.closest(".dsvar-leaf[data-form]");
    if (!a) return;
    e.preventDefault();
    openForm(a.getAttribute("data-form"), a);
  });

  prev.addEventListener("click", function () { openForm(prev.dataset.form); });
  next.addEventListener("click", function () { openForm(next.dataset.form); });
  dlg.querySelector(".dsvar-ch__close").addEventListener("click", function () { dlg.close(); });

  // A click on the backdrop lands on the dialog element itself.
  dlg.addEventListener("click", function (e) { if (e.target === dlg) dlg.close(); });

  dlg.addEventListener("close", function () {
    history.replaceState(null, "", "#ch-" + currentTab);
    // Return focus to the leaf that opened it, if it is in the visible tab.
    var back = root.querySelector('#ch-' + currentTab + ' .dsvar-leaf[data-form="' + currentForm + '"]');
    (back || opener || tabs[0]).focus();
    opener = null;
  });

  // ---- where to start ------------------------------------------------------
  function fromHash() {
    var h = decodeURIComponent(location.hash.slice(1));
    if (h.indexOf("form-") === 0) {
      var id = h.slice(5);
      var leaf = root.querySelector('.dsvar-ch__panel .dsvar-leaf[data-form="' + id + '"]');
      var panel = leaf && leaf.closest(".dsvar-ch__panel");
      showTab(panel ? panel.id.slice(3) : tabs[0].getAttribute("data-tab"));
      openForm(id, leaf);
      return;
    }
    if (h.indexOf("ch-") === 0 && document.getElementById(h)) { showTab(h.slice(3)); return; }
    showTab(tabs[0].getAttribute("data-tab"));
  }

  fromHash();
  window.addEventListener("hashchange", fromHash);
  requestAnimationFrame(function () { root.classList.add("dsvar-ch--ready"); });
})();
