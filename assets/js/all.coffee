data = [
  {
    'title': 'Set A'
    'genes': [
      'COL1A1'
      'MT-ND5'
      'MT-ND4'
      'MT-ND6'
      'COL6A3'
      'MT-RNR1'
      'RMRP'
      'EEF2'
      'MIR3648'
      'FLNA'
      'MT-CYB'
      'TSIX'
      'MT-ND1'
      'MT-RNR2'
      'COL3A1'
      'SRRM2'
      'MALAT1'
      'MT-COI'
      'AHNAK'
      'LRP1'
      'ACTB'
      'MYH9'
      'COL1A2'
      'RPPH1'
      'SCARNA2'
      'XIST'
      'NEAT1'
    ]
  }
  {
    'title': 'Set B'
    'genes': [
      'TRPS1'
      'FN1'
      'TNS1'
      'SPARC'
      'MT-ND6'
      'TIMP3'
      'MT-ND2'
      'COL6A3'
      'DDX17'
      'PLEC'
      'RNF213'
      'MT-ATP6'
      'EEF2'
      'HSPG2'
      'IGF2'
      'FLNA'
      'ZFP36L1'
      'IGFBP5'
      'KCNQ1OT1'
      'TSIX'
      'FASN'
      'MT-CO3'
      'SPTBN1'
      'LRP1'
      'ACTB'
      'MYH9'
      'PSAP'
      'HNRNPA2B1'
    ]
  }
]

setA = []
setB = []
setAB = []
allSets = {}

# Adds items to their respective sets + adds cleaner title for retrieval later
for x in data
  title = x.title
  if title == "Set A"
    setA.push(title)
    for i in x.genes
      setA.push(i)
      allSets.setA = setA
  else if title == "Set B"
    setB.push(title)
    for i in x.genes
      setB.push(i)
      allSets.setB = setB

# Finds the duplicate values in each set and pushes them to new set
(compareArrays = (a, b)->
  setAB.push("Set AB")
  for n in a
    for y in b
      if n == y
        setAB.push(n)
)(setA, setB)

allSets.setAB = setAB

# Removing 1 count per item to account for titles in data
allSetsLength = (setA.length + setB.length + setAB.length) - 3

fills = [
  "rgb(0, 255, 0)"
  "rgb(255, 255, 0)"
  "rgb(255, 0, 0)"
]

# Loop through each object and append a table row and cell to the legend for that object's data
count = -1
for k, v of allSets
  count++
  mybackgroundColor = fills[count]
  firstHTML = '<tr><td style="width: 30px; background:'
  secondHTML = ';"></td><td>'
  thirdHTML = '</td><td>'
  endHTML = '</td></tr>'
  $('#legend table').append( firstHTML + mybackgroundColor + secondHTML + v[0] + thirdHTML + (v.length - 1) + endHTML )

# Add the final row with total count
$('#legend table').append( '<tr><td colspan="2">Selected</td><td>' + allSetsLength + '</td></tr>' )


venn = document.createElementNS("http://www.w3.org/2000/svg", "svg");
venn.setAttribute("height",400)
venn.setAttribute("width",800)
venn.setAttribute("id", "venn")
$('.wrapper').prepend(venn)


totalWidth = $('.wrapper svg').attr('width')
totalHeight = $('.wrapper svg').attr('height')
middleVertical = totalHeight / 2
start = totalWidth / 2
radius = start / 2
sim = 0

# Get the value for the intersecting items as a percentage of the whole
(calculateSimilarity = (a, b , ab)->
  a = a.length
  b = b.length
  ab = ab.length
  sim = (ab * 100) / (a + b)
  return sim
)(setA, setB, setAB)

# Start off each circle with 'zero' similarity (sim = 0) and adjust their x values based on the newly calculated value of sim
moveLeft = (start - ( radius - ( (sim/100) * start ) ) )
moveRight = (start + ( radius - ( (sim/100) * start ) ) )


# Draw our diagram and add fills
# drawCircle = (color, move)->
#   ctx.beginPath()
#   ctx.globalCompositeOperation = "difference";
#   ctx.fillStyle = color
#   ctx.arc(move, middleVertical, radius, 0, 2*Math.PI)
#   ctx.fill()


drawCircle = (color, move, id)->
  circles = document.createElementNS("http://www.w3.org/2000/svg", "circle")
  circles.setAttribute("cx", move)
  circles.setAttribute("cy", middleVertical)
  circles.setAttribute("r", radius)
  circles.setAttribute("fill", color)
  circles.setAttribute("id", id)
  circles.setAttribute("fill-rule", "evenodd")
  venn.appendChild(circles)

drawCircle(fills[0], moveLeft, "setA")
drawCircle(fills[1], moveRight, "setB")

$('svg circle').click ->
  toLog = $(this).attr('id')
  console.log toLog
