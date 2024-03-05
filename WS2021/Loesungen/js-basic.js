const f = (g, x) => g(g(g(x)))
const h = x => x + 5
const r1 = f(h, 1)

const cities = ['Berlin', 'Hamburg', 'Trier', 'Saarlouis', 'Bamberg']

const r2 = cities.slice(1, 3).map(v => v.length)
const r3 = cities.filter(v => /a[b-n]/.test(v)).reduce((r, v) => r + v.length, 0)
cities.pop()
cities.shift()
const r4 = cities.map(v => v[0]).join('=')

console.log(`r1 = ${r1}`)
console.log(`r2 = ${r2}`)
console.log(`r3 = ${r3}`)
console.log(`r4 = ${r4}`)

// r1 = 16
// r2 = [7,5]
// r3 = 14
// r4 = H=T=S
