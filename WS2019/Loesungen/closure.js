function div(factor) {
  return value => value / factor
}

const d3 = div(3)
const d4 = div(4)

r1 = d3(120)
r2 = d4(120)
r3 = div(div(2)(10))(120)

console.log(`${r1} ${r2} ${r3}`)

let i
for (i = 0; i < 3; i++) {
  const log = () => {
    console.log(i)
  }
  setTimeout(log, 100)
}