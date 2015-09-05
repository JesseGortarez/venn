(function() {
  var allSets, allSetsLength, calculateSimilarity, compareArrays, count, ctx, data, drawCircle, endHTML, firstHTML, i, k, middleVertical, moveLeft, moveRight, myFills, mybackgroundColor, radius, secondHTML, setA, setAB, setB, sim, start, thirdHTML, title, totalHeight, totalWidth, v, venn, x, _i, _j, _k, _len, _len1, _len2, _ref, _ref1;

  data = [
    {
      'title': 'Set A',
      'genes': ['COL1A1', 'MT-ND5', 'MT-ND4', 'MT-ND6', 'COL6A3', 'MT-RNR1', 'RMRP', 'EEF2', 'MIR3648', 'FLNA', 'MT-CYB', 'TSIX', 'MT-ND1', 'MT-RNR2', 'COL3A1', 'SRRM2', 'MALAT1', 'MT-COI', 'AHNAK', 'LRP1', 'ACTB', 'MYH9', 'COL1A2', 'RPPH1', 'SCARNA2', 'XIST', 'NEAT1']
    }, {
      'title': 'Set B',
      'genes': ['TRPS1', 'FN1', 'TNS1', 'SPARC', 'MT-ND6', 'TIMP3', 'MT-ND2', 'COL6A3', 'DDX17', 'PLEC', 'RNF213', 'MT-ATP6', 'EEF2', 'HSPG2', 'IGF2', 'FLNA', 'ZFP36L1', 'IGFBP5', 'KCNQ1OT1', 'TSIX', 'FASN', 'MT-CO3', 'SPTBN1', 'LRP1', 'ACTB', 'MYH9', 'PSAP', 'HNRNPA2B1']
    }
  ];

  setA = [];

  setB = [];

  setAB = [];

  allSets = {};

  for (_i = 0, _len = data.length; _i < _len; _i++) {
    x = data[_i];
    title = x.title;
    if (title === "Set A") {
      setA.push(title);
      _ref = x.genes;
      for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
        i = _ref[_j];
        setA.push(i);
        allSets.setA = setA;
      }
    } else if (title === "Set B") {
      setB.push(title);
      _ref1 = x.genes;
      for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
        i = _ref1[_k];
        setB.push(i);
        allSets.setB = setB;
      }
    }
  }

  (compareArrays = function(a, b) {
    var n, y, _l, _len3, _results;
    setAB.push("Set AB");
    _results = [];
    for (_l = 0, _len3 = a.length; _l < _len3; _l++) {
      n = a[_l];
      _results.push((function() {
        var _len4, _m, _results1;
        _results1 = [];
        for (_m = 0, _len4 = b.length; _m < _len4; _m++) {
          y = b[_m];
          if (n === y) {
            _results1.push(setAB.push(n));
          } else {
            _results1.push(void 0);
          }
        }
        return _results1;
      })());
    }
    return _results;
  })(setA, setB);

  allSets.setAB = setAB;

  allSetsLength = (setA.length + setB.length + setAB.length) - 3;

  myFills = ["rgb(0, 255, 0)", "rgb(255, 255, 0)", "rgb(255, 0, 0)"];

  count = -1;

  for (k in allSets) {
    v = allSets[k];
    count++;
    mybackgroundColor = myFills[count];
    firstHTML = '<tr><td style="width: 30px; background:';
    secondHTML = ';"></td><td>';
    thirdHTML = '</td><td>';
    endHTML = '</td></tr>';
    $('#diagram table').append(firstHTML + mybackgroundColor + secondHTML + v[0] + thirdHTML + (v.length - 1) + endHTML);
  }

  $('#diagram table').append('<tr><td colspan="2">Selected</td><td>' + allSetsLength + '</td></tr>');

  totalWidth = $('.wrapper canvas').attr('width');

  totalHeight = $('.wrapper canvas').attr('height');

  middleVertical = totalHeight / 2;

  start = totalWidth / 2;

  radius = start / 2;

  sim = 0;

  (calculateSimilarity = function(a, b, ab) {
    a = a.length;
    b = b.length;
    ab = ab.length;
    sim = (ab * 100) / (a + b);
    return sim;
  })(setA, setB, setAB);

  moveLeft = start - (radius - ((sim / 100) * start));

  moveRight = start + (radius - ((sim / 100) * start));

  venn = document.getElementById('venn');

  ctx = venn.getContext('2d');

  drawCircle = function(color, move) {
    ctx.beginPath();
    ctx.globalCompositeOperation = "difference";
    ctx.fillStyle = color;
    ctx.arc(move, middleVertical, radius, 0, 2 * Math.PI);
    return ctx.fill();
  };

  drawCircle(myFills[0], moveLeft);

  drawCircle(myFills[1], moveRight);

}).call(this);
