/* 
Draws Pi on a spiral
based on code by -~=Manoylov AC=~- https://www.openprocessing.org/sketch/168364
Pi from http://www.geom.uiuc.edu/~huberty/math5337/groupe/digits.html

Adaped for Redbubble by Rupert Russell
1 July 2018
Code avaiable on Githun at https://github.com/rupertrussell/spiralText_002
Artwork available on Redbubble at: https://github.com/rupertrussell/spiralText_002
*/


float second = 0;
float first = 0;

int counter = 0;
String txt = "3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315588174881520920962829254091715364367892590360011330530548820466521384146951941511609433057270365759591953092186117381932611793105118548074462379962749567351885752724891227938183011949129833673362440656643086021394946395224737190702179860943702770539217176293176752384674818467669405132000568127145263560827785771342757789609173637178721468440901224953430146549585371050792279689258923542019956112129021960864034418159813629774771309960518707211349999998372978049951059731732816096318595024459455346908302642522308253344685035261931188171010003137838752886587533208381420617177669147303598253490428755468731159562863882353787593751957781857780532171226806613001927876611195909216420198938095257201065485863278865936153381827968230301952035301852968995773622599413891249721775283479131515574857242454150695950829533116861727855889075098381754637464939319255060400927701671139009848824012858361603563707660104710181942955596198946767837449448255379774726847104047534646208046684259069491293313677028989152104752162056966024058038150193511253382430035587640247496473263914199272604269922796782354781636009341721641219924586315030286182974555706749838505494588586926995690927210797509302955321165344987202755960236480665499119881834797753566369807426542527862551818417574672890977772793800081647060016145249192173217214772350141441973568548161361157352552133475741849468438523323907394143334547762416862518983569485562099219222184272550254256887671790494601653466804988627232791786085784383827967976681454100953883786360950680064225125205117392984896084128488626945604241965285022210661186306744278622039194945047123713786960956364371917287467764657573962413890865832645995813390478027590099465764078951269468398352595709825822620522489407726719478268482601476990902640136394437455305068203496252451749399651431429809190659250937221696461515709858387410597885959772975498930161753928468138268683868942774155991855925245953959431049972524680845987273644695848653836736222626099124608051243884390451244136549762780797715691435997700129616089441694868555848406353422072225828488648158456028506016842739452267467678895252138522549954666727823986456596116354886230577456498035593634568174324112515076069479451096596094025228879710893145669136867228748940560101503308617928680920874760917824938589009714909675985261365549781893129784821682998948722658804857564014270477555132379641451523746234364542858444795265867821051141354735739523113427166102135969536231442952484937187110145765403590279934403742007310578539062198387447808478489683321445713868751943506430218453191048481005370614680674919278191197939952061419663428754440643745123718192179998391015919561814675142691239748940907186494231961567945208095146550225231603881930142093762137855956638937787083039069792077346722182562599661501421503068038447734549202605414665925201497442850732518666002132434088190710486331734649651453905796268561005508106658796998163574736384052571459102897064140110971206280439039759515677157700420337869936007230558763176359421873125147120532928191826186125867321579198414848829164470609575270695722091756711672291098169091528017350671274858322287183520935396572512108357915136988209144421006751033467110314126711136990865851639831501970165151168517143765761835155650884909989859982387345528331";


float xPos, yPos;
PFont font;
SpiralText txtSp;

void setup() {
  size(2000,2000);
  xPos = width/2;
  yPos = height/2;
  font = createFont("Arial Bold", 35, true);
  txtSp = new SpiralText(xPos, yPos, txt, 20);
  txtSp.setShiftSpirstepSpacestep(-5, 0);
  txtSp.onFrameLimit();
  background(0);
  noLoop();
}

void draw() {
  xPos = width / 2;
  yPos = width / 2;
  background(0);
  textFont(font, 20);
  fill(255); 
  txtSp.setXY(xPos, yPos);
  txtSp.draw();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    counter ++;
    save("Pi" + first + "_" + second + ".png");
    println("saved");
  } else if (mouseButton == RIGHT) {
    first = random(-10, 8);
    second = random(-2, 5);
    txtSp.setShiftSpirstepSpacestep(first, second );
    println("first = " + first);
    println("second = " + second);
  }
  redraw();
}


// helper class by Manoylov AC
// draws text on spiral
// not perfect. WIP.
// correctly works with textAlign(CENTER);
// TODO: fix angleStart logic

class SpiralText {
  private float xPos;
  private float yPos;
  private String spiralText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.";
  private float startRadius = 5;
  private float spiralRingStep;
  private float shiftSpiralRingStep = 0;
  private float shiftSpiralSpaceStep = 0;
  private boolean isFrameLimitMode = false;
  private boolean isClrImageMode = false;
  private PImage spirImg;
  private int borderDistance = -5;
  private float startAngle = 0;

  SpiralText (float in_posX, float in_posY, String in_txt, float in_spiralStep) {
    setParam(in_posX, in_posY, in_txt, in_spiralStep);
  }

  void setText(String in_txt) {
    if (in_txt.length() > 0) {
      this.spiralText = in_txt;
    }
  }

  void setBorderDistance(int in_brdrDistance) {
    this.borderDistance = in_brdrDistance;
  }

  void setXY(float in_posX, float in_posY) {
    this.xPos = in_posX;
    this.yPos = in_posY;
  }

  void shiftXY(float in_posX, float in_posY) {
    this.xPos += in_posX;
    this.yPos += in_posY;
  }

  void setParam(float in_posX, float in_posY, String in_txt, float in_spiralStep) {
    setXY(in_posX, in_posY);
    setText(in_txt);
    setSpiralStep (in_spiralStep);
  }

  void setShiftSpirstepSpacestep (float in_shiftSpirStep, float int_shiftSpirSpaceStep) {
    this.shiftSpiralRingStep = in_shiftSpirStep;
    this.shiftSpiralSpaceStep = int_shiftSpirSpaceStep;
  }

  void setSpiralStep (float in_spiralStep) {
    this.spiralRingStep = in_spiralStep;
  }

  void setStartRadius (float in_startRadius) {
    if (0 >= in_startRadius ) {
      this.startRadius = 5;
    }
    this.startRadius = in_startRadius;
  }

  void setStartAngleRadian(float in_startAngle) {
    this.startAngle = degrees(in_startAngle);
  }
  void setStartAngleDegree(float in_startAngle) {
    this.startAngle = in_startAngle;
  }

  void onFrameLimit() {
    this.isFrameLimitMode = true;
  }    

  void offFrameLimit() {
    this.isFrameLimitMode = false;
  }    

  void onImgClrMode(PImage in_img) {
    this.spirImg = in_img;
    this.isClrImageMode = true;
    if (this.spirImg.width < width || this.spirImg.height < height || this.spirImg.width > width || this.spirImg.height > height) {
      this.spirImg.resize(width, height);
    }
  }

  void offImgClrMode() {
    this.isClrImageMode = false;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////

  void draw() {
    textAlign(CENTER);
    int iterCharPos = 0;
    char currSymbol;
    float angle = startAngle;
    float currRadius = startRadius;
    float spiralSpaceStep = 0;
    float xx = 0;
    float yy = 0;
    float angleStep = 0;
    float radiusStep = 0;
    float countOfsymb;
    float currSymbolWidth;

    while (iterCharPos < this.spiralText.length ()) {
      currSymbol = this.spiralText.charAt(this.spiralText.length() - iterCharPos - 1);
      currSymbolWidth = textWidth(currSymbol);
      spiralSpaceStep = currSymbolWidth + this.shiftSpiralSpaceStep;
      countOfsymb = TWO_PI*currRadius / spiralSpaceStep;
      radiusStep = (this.spiralRingStep + this.shiftSpiralRingStep)/countOfsymb;
      currRadius += radiusStep;

      angleStep += currSymbolWidth / 2 + this.shiftSpiralSpaceStep/2;
      angle += angleStep / currRadius ;  
      angleStep = currSymbolWidth / 2 + this.shiftSpiralSpaceStep/2;

      xx = cos(angle) * currRadius + xPos;
      yy = sin(angle) * currRadius + yPos;

      if (this.isFrameLimitMode && (xx-10 < 0 || xx+10 > width || yy-10 < 0 || yy+10 > height)) {
        break;
      } else if (!( xx < this.borderDistance || xx> width - this.borderDistance || yy < this.borderDistance || yy > height -this.borderDistance)) {
        if (this.isClrImageMode) { 
          fill(this.spirImg.get((int)xx, (int)yy));
        }
        pushMatrix();
        translate(xx, yy);
        rotate(PI/2 - angle );  // was + angle!


        textFont(font, 2 + angle /4);
        text(currSymbol, 0, 0 );  // put out character ****************************************

        popMatrix();
      } else if (dist(xx, yy, this.xPos, this.yPos) > dist(this.xPos, this.yPos, borderDistance, borderDistance)
        && dist(xx, yy, this.xPos, this.yPos) > dist(this.xPos, this.yPos, width - this.borderDistance, this.borderDistance)
        && dist(xx, yy, this.xPos, this.yPos) > dist(this.xPos, this.yPos, width - this.borderDistance, height - this.borderDistance)
        && dist(xx, yy, this.xPos, this.yPos) > dist(this.xPos, this.yPos, this.borderDistance, height - this.borderDistance)
        ) {
        break;
      }
      iterCharPos++;
    }
  }
}

void keyPressed() {
  counter ++;
  save("Pi" + counter + ".png");
  println("saved");
}
