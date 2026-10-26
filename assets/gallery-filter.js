/* ============================================================================
   Gallery filter — chips for the rhetorical move, a box for everything else.

   PROGRESSIVE ENHANCEMENT, ON PURPOSE. The grid is rendered complete and in
   order by {{< gallery >}}; this file only hides things. With JavaScript off,
   or before this loads, every case is present and readable. Nothing here is
   the way in to the content.

   Matching is done against a data-find string the shortcode builds from the
   name, creator, move and description, lowercased at render time so this never
   has to think about case or about which fields are searchable.
   ========================================================================= */

(function () {
  "use strict";

  var grid = document.getElementById("dsvar-gal-count");
  if (!grid) return;                       // not the gallery page

  var cards   = Array.prototype.slice.call(document.querySelectorAll(".dsvar-ex"));
  var chips   = Array.prototype.slice.call(document.querySelectorAll(".dsvar-chip"));
  var groups  = Array.prototype.slice.call(document.querySelectorAll(".dsvar-galgroup"));
  var box     = document.getElementById("dsvar-gal-q");
  var count   = document.getElementById("dsvar-gal-count");
  var empty   = document.getElementById("dsvar-gal-empty");
  var total   = cards.length;

  var move = "all";
  var query = "";

  function apply() {
    var shown = 0;

    cards.forEach(function (c) {
      var okMove = move === "all" || c.getAttribute("data-move") === move;
      var okText = query === "" ||
                   (c.getAttribute("data-find") || "").indexOf(query) !== -1;
      var show = okMove && okText;
      c.hidden = !show;
      if (show) shown++;
    });

    // A group heading with nothing under it is just noise.
    groups.forEach(function (g) {
      var any = g.querySelector(".dsvar-ex:not([hidden])");
      g.hidden = !any;
    });

    if (empty) empty.hidden = shown !== 0;

    // The noun agrees with the TOTAL, not the count shown: "1 of 23 cases",
    // never "1 of 23 case".
    if (shown === total) {
      count.textContent = total + (total === 1 ? " case" : " cases");
    } else {
      count.textContent = shown + " of " + total + (total === 1 ? " case" : " cases");
    }
  }

  chips.forEach(function (chip) {
    chip.addEventListener("click", function () {
      move = chip.getAttribute("data-filter");
      chips.forEach(function (c) {
        var on = c === chip;
        c.classList.toggle("dsvar-chip--on", on);
        c.setAttribute("aria-pressed", on ? "true" : "false");
      });
      apply();
    });
    chip.setAttribute("aria-pressed",
      chip.classList.contains("dsvar-chip--on") ? "true" : "false");
  });

  // The "show everything" link inside the empty state resets both controls,
  // because a reader who filtered themselves into a corner wants out of both.
  var reset = empty && empty.querySelector("[data-filter='all']");
  if (reset) {
    reset.addEventListener("click", function () {
      move = "all"; query = "";
      if (box) box.value = "";
      chips.forEach(function (c) {
        var on = c.getAttribute("data-filter") === "all";
        c.classList.toggle("dsvar-chip--on", on);
        c.setAttribute("aria-pressed", on ? "true" : "false");
      });
      apply();
      if (box) box.focus();
    });
  }

  if (box) {
    box.addEventListener("input", function () {
      query = box.value.trim().toLowerCase();
      apply();
    });
    // Escape clears, which is what a search box is expected to do.
    box.addEventListener("keydown", function (e) {
      if (e.key === "Escape" && box.value !== "") {
        box.value = ""; query = ""; apply();
      }
    });
  }

  apply();
})();
