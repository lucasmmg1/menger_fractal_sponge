int numberOfHoles;
PVector rotationAngle;
ArrayList<PVector> positions, scales;

void setup() {
  size(800, 750, P3D);
  rotationAngle = new PVector(0, 0, 0);
  positions = new ArrayList<PVector>();
  scales = new ArrayList<PVector>();
  
  // Adiciona a primeira caixa no início
  positions.add(new PVector(0, 0, 0));
  scales.add(new PVector(200, 200, 200));
}

void draw() {
  background(51);
  lights();

  textSize(20);
  fill(225, 175, 60);
  text("Menger Fractal Sponge", 10, 30);
  fill(225);
  text("Wikipedia Link: ", 10, 60);
  fill(0, 105, 205);
  text("https://en.wikipedia.org/wiki/Menger_sponge", 15 + textWidth("Wikipedia Link: "), 60);
  fill(225);
  text("Number of holes: ", 10, 90);
  fill(225, 0, 0);
  text(numberOfHoles, 15 + textWidth("Number of holes: "), 90.5f);

  translate(width / 2, height / 2 + 100);
  rotateX(rotationAngle.x);
  rotateY(rotationAngle.y);
  rotateZ(rotationAngle.z);

  // Atualiza e desenha todas as caixas
  for (int i = 0; i < positions.size(); i++) {
    updateBox(i);
  }

  rotationAngle = new PVector(rotationAngle.x + 0.01f, rotationAngle.y + 0.01f, rotationAngle.z + 0.01f);
}

void mousePressed() {
  ArrayList<PVector> newPositions = new ArrayList<PVector>();
  ArrayList<PVector> newScales = new ArrayList<PVector>();

  // Cria novas caixas a partir das caixas existentes
  for (int i = 0; i < positions.size(); i++) {
    ArrayList<PVector[]> newBoxes = onBoxClicked(i);
    for (PVector[] boxData : newBoxes) {
      newPositions.add(boxData[0]);  // Posição
      newScales.add(boxData[1]);     // Escala
    }
  }

  positions = newPositions;
  scales = newScales;
}

void updateBox(int index) {
  noStroke();
  fill(255);
  
  pushMatrix();
  translate(positions.get(index).x, positions.get(index).y, positions.get(index).z);
  box(scales.get(index).x, scales.get(index).y, scales.get(index).z);
  popMatrix();
}

// Método que cria novas caixas quando a caixa original é clicada
ArrayList<PVector[]> onBoxClicked(int index) {
  ArrayList<PVector[]> newBoxes = new ArrayList<PVector[]>();

  // Divida a caixa atual em 27 menores caixas
  PVector position = positions.get(index);
  PVector scale = scales.get(index);

  for (int x = -1; x < 2; x++) {
    for (int y = -1; y < 2; y++) {
      for (int z = -1; z < 2; z++) {
        int sum = abs(x) + abs(y) + abs(z);
        if (sum <= 1) {
          numberOfHoles++;  // Incrementa o número de buracos (caixas removidas)
          continue;
        }

        // Cria uma nova caixa pequena
        PVector newScale = new PVector(scale.x / 3, scale.y / 3, scale.z / 3);
        PVector newPosition = new PVector(position.x + x * newScale.x, position.y + y * newScale.y, position.z + z * newScale.z);
        newBoxes.add(new PVector[] { newPosition, newScale });
      }
    }
  }

  return newBoxes;
}
