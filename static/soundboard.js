const regexp = new RegExp("(https://www\\.youtube\\.com/watch\\?v=|https://youtu\\.be/)(\\w+)(\\?t=(\\d+))?");

// Save the video to local storage
function save(id, start) {
    let soundboard = JSON.parse(window.localStorage.getItem("soundboard"));
    if(!soundboard) {
        soundboard = [];
    }
    soundboard.push({"id": id, "start": start});
    window.localStorage.setItem("soundboard", JSON.stringify(soundboard));
}

// Append the video to the page
function create(id, start) {
    let embed = `<iframe width="320" height="180" src="https://www.youtube-nocookie.com/embed/${id}?controls=0&amp;start=${start}" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>`
    let soundboard = document.getElementById("soundboard");
    let container = document.createElement("span");
    container.innerHTML = embed;
    soundboard.appendChild(container);
}

// Button handler for add button
function add() {
    let input = document.getElementById("input").value;
    let match = input.match(regexp);
    if(match) {
        let id = match[2];
        let start = match[4];
        console.log(id);
        console.log(start);
        create(id, start);
        save(id, start);
    }
}

// Restore videos from local storage
function restore() {
    let soundboard = JSON.parse(window.localStorage.getItem("soundboard"));
    if(soundboard) {
        soundboard.forEach(item => create(item.id, item.start));
    }
}

window.addEventListener('load', () => {
    restore();
    document.getElementById("button").onclick = add; 
});
