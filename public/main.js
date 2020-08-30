// Initial data passed to Elm (should match `Flags` defined in `Shared.elm`)
// https://guide.elm-lang.org/interop/flags.html
var flags = null

// Start our Elm application
var app = Elm.Main.init({ flags: flags })

// Ports go here
// https://guide.elm-lang.org/interop/ports.html

document.addEventListener('clipboard-copy', function (event) {
    const orig = event.target.innerHTML
    event.target.innerHTML = orig.replace(/\>.+\</, '>copied!<')
    setTimeout(function () {
        event.target.innerHTML = orig
    }, 3000)
})
