// Code adapted from one of Kath's behavior 
// habituation arduino scipts

void setup(){
  Serial.begin(9600);

  Serial.println("testing");
  
  // Wait for matlab to send specific character to arduino
  char a = 'b';
  while (a != 'a')
  {
    a = Serial.read();
  }

  // Send signal that arduino setup has finished
  Serial.println("start");
}

void loop() {
  // put your main code here, to run repeatedly:

}
