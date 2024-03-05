var fruit = ['Apfel', 'Blaubeere', 'Orange', 'Kiwi', 'Banane']

var f1 = fruit.filter(f => f.length <= 5).map(f => f.length)
var f2 = fruit.reduce((r, v) => r + v[0], '')
var f3 = fruit.reduce((r, v, i) => r + v[i], '')
var f4 = fruit.filter(f => /n/.test(f))
    .reduce((r, v) => r + v.length, 0)


console.log(f1)
console.log(f2)
console.log(f3)
console.log(f4)

// [5, 4]
// ABOKB
// Alain
// 12