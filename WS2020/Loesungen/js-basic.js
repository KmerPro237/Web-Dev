let f = (g, x) => g(g(x))
let h = x => 2 * x
let r1 = f(h, 3)

let cities = ['Berlin', 'Hamburg', 'Trier', 'Saarlouis', 'Bamberg']

let r2 = cities.slice(2, 4).map(v => v.length)
let r3 = cities.filter(v => /i[d-r]/.test(v)).reduce((r, v) => r + v.length, 0)
cities.shift()
cities.pop()
let r4 = cities.map(v => v[0]).join('+')

console.log(r1)
console.log(r2)
console.log(r3)
console.log(r4)

// 12
// [5, 9]
// 11
// H+T+S

let word = 'eine Feier'
let count
count = word.match(/e/g).length

// count = word.split(/e/).length - 1
// count = [...word].filter(c => c === 'e').length
// count = [...word].filter(f => /e/.test(f)).length
// count = [...word.matchAll(/e/g)].length

console.log(count)