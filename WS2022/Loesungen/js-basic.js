const f = (g, x) => x * g(x)
const h = x => x + 2
const r1 = f(h, 3)

const cities = ['Konz', 'Hamburg', 'Trier', 'Saarlouis', 'Bern']

const r2 = cities
  .slice(-2).map(v => v.length)
const r3 = cities
  .filter(v => /[m-t][m-n]/.test(v))
  .reduce((r, v) => r * v.length, 1)
const r4 = cities
  .map(v => ({ n: v, l: v.length }))
  .sort((a, b) => b.l - a.l)[0].n

console.log(`r1 = ${r1}`)
console.log(`r2 = ${r2}`)
console.log(`r3 = ${r3}`)
console.log(`r4 = ${r4}`)

// r1 = 15
// r2 = 9,4
// r3 = 16
// r4 = Saarlouis
