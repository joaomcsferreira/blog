const btnMobile = document.getElementsByClassName('btn-mobile')[0]

function toggleMenu() {
    const nav = document.getElementsByClassName('nav')[0]
    nav.classList.toggle('active')
}

btnMobile.addEventListener('click', toggleMenu)
