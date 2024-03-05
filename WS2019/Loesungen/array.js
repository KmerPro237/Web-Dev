let numbers = [1, 2, 3]
numbers.push(6)
numbers.shift()
let n = numbers.join('-')

let cities = ['Berlin', 'Hamburg', 'Trier', 'Saarlouis', 'Bamberg']

let r1 = cities.filter(v => v.length > 6).map(v => v.length)
let r2 = cities.reduce((r, v) => r + v[v.length - 1], '')
let r3 = cities.filter(v => /b/i.test(v)).map(v => v[3]).join('')

console.log(n)
console.log(r1)
console.log(r2)
console.log(r3)

// 2-3-6
// [7, 9, 7]
// ngrsg
// lbb

let words = ['hello', 'sun', '!', 'tomorrow']
words.sort((a, b) => a.length - b.length)
console.log(words)

/* falsch */
words = ['hello', 'sun', '!', 'tomorrow']
words.sort((a, b) => a.length <= b.length)
console.log(words)

/* falsch */
words = ['hello', 'sun', '!', 'tomorrow']
words.sort((a, b) => a.length > b.length)
console.log(words)

/* richtig */
words = ['hello', 'sun', '!', 'tomorrow']
words.sort((a, b) => a.length <= b.length ? -1 : 1)
console.log(words)