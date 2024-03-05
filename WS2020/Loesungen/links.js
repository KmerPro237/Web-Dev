window.onload = () => {
  createLinkList(links)
}

const links = [
  {
    text: 'Google',
    url: 'https://www.google.de/'
  },
  {
    text: 'htw saar',
    url: 'https://www.htwsaar.de/'
  }
]

function createLinkItem(link) {
  const li = document.createElement('li')
  const a = document.createElement('a')
  a.href = link.url
  // oder
  // a.setAttribute('href', link.url)
  a.textContent = link.text
  li.appendChild(a)
  return li
}

function createLinkList(links) {
  const body = document.body
  const ul = document.createElement('ul')
  body.appendChild(ul)
  links.forEach(link => {
    ul.append(createLinkItem(link))
  })
}