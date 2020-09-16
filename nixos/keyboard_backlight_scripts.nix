  { pkgs, ... }:
  
  let
    keyboardBlOff = pkgs.writeScriptBin "keyboardBlOff" ''
      #!${pkgs.stdenv.shell}
      echo 0 > /sys/class/leds/tpacpi::kbd_backlight/brightness
      '';
    keyboardBlLow = pkgs.writeScriptBin "keyboardBlLow" ''
      #!${pkgs.stdenv.shell}
      echo 1 > /sys/class/leds/tpacpi::kbd_backlight/brightness
    '';
    keyboardBlHigh = pkgs.writeScriptBin "keyboardBlHigh" ''
      #!${pkgs.stdenv.shell}
      echo 2 > /sys/class/leds/tpacpi::kbd_backlight/brightness
    '';
  
  in {
    environment.systemPackages = [ keyboardBlHigh keyboardBlLow keyboardBlOff ];
  }
    
