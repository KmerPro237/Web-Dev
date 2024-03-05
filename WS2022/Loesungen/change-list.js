function createButton (text) {
  const button = document.createElement('button')
  button.innerText = text
  button.addEventListener('click', changeFirstList)
  document.body.appendChild(button)
}

function changeFirstList () {
  const ul = document.querySelector('ul')
  if (ul) {
    changeList(ul)
  }
}

function changeList (ul) {
  const ol = document.createElement('ol')
  while (ul.firstChild) {
    ol.appendChild(ul.firstChild)
  }
  ul.parentNode.insertBefore(ol, ul)
  ul.parentNode.removeChild(ul)
}

createButton('change ul to ol')
