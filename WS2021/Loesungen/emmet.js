function createEmmetElement (elementSpecification) {
  // elementSpecification is a string of the form
  // elementName or elementName{textContent}
  const reElement = /^(?<name>\w+)(\{(?<text>.*)\})?/
  const match = elementSpecification.match(reElement)
  const element = document.createElement(match.groups.name)
  if (match.groups.text) {
    element.textContent = match.groups.text
  }
  return element
}

function createEmmet (element, emmet) {
  const elements = emmet.split('>').map(createEmmetElement)
  createDescendants(element, elements)
}

function createDescendants (element, descendants) {
  if (descendants.length > 0) {
    element.appendChild(descendants[0])
    createDescendants(descendants[0], descendants.slice(1))
  }
}

createEmmet(document.body, 'p{para}')
createEmmet(document.body, 'div{hello}>ul>li{world}')

// example for the use of match
// cf. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/match
const paragraph = 'The quick brown fox jumps over the lazy dog.'
const capturingRegex = /(?<animal>fox|cat) jumps over/
const found = paragraph.match(capturingRegex)
console.log(found.groups.animal) // 'fox'
