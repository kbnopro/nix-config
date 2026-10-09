{ pkgs, ... }:

{
  services.easyeffects = {
    enable = true;

    # Auto-load the preset on startup
    preset.output = "custom-preset";

    # Define the preset structure directly
    extraPresets = {
      custom-preset = {
        output = {
          blocklist = [ ];
          plugins_order = [
            "equalizer#0"
            "loudness#0"
            "compressor#0"
            "limiter#0"
          ];

          "compressor#0" = {
            attack = 5.0;
            boost-amount = 6.0;
            boost-threshold = -72.0;
            bypass = false;
            dry = -80.01;
            hpf-frequency = 10.0;
            hpf-mode = "Off";
            input-gain = 15.0;
            input-to-link = -80.01;
            input-to-sidechain = -80.01;
            knee = -6.0;
            link-to-input = -80.01;
            link-to-sidechain = -80.01;
            lpf-frequency = 20000.0;
            lpf-mode = "Off";
            makeup = 0.0;
            mode = "Downward";
            output-gain = 0.0;
            ratio = 4.0;
            release = 100.0;
            release-threshold = -80.01;
            sidechain = {
              lookahead = 0.0;
              mode = "Peak";
              preamp = 0.0;
              reactivity = 10.0;
              source = "Middle";
              stereo-split-source = "Left/Right";
              type = "Feed-forward";
            };
            sidechain-to-input = -80.01;
            sidechain-to-link = -80.01;
            stereo-split = false;
            threshold = -6.0;
            wet = 0.0;
          };

          "equalizer#0" = {
            balance = -0.1;
            bypass = false;
            decramp = "Off";
            input-gain = -18.0;
            mode = "IIR";
            num-bands = 10;
            output-gain = 11.0;
            pitch-left = 0.0;
            pitch-right = 0.0;
            split-channels = false;

            left = {
              band0 = {
                frequency = 29.95;
                gain = -15.44;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band1 = {
                frequency = 59.76;
                gain = -4.02;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band2 = {
                frequency = 119.24;
                gain = 11.23;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band3 = {
                frequency = 237.92;
                gain = -5.33;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band4 = {
                frequency = 474.72;
                gain = -13.7;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band5 = {
                frequency = 947.19;
                gain = -9.07;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band6 = {
                frequency = 1889.88;
                gain = -17.6;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band7 = {
                frequency = 3770.81;
                gain = -18.44;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band8 = {
                frequency = 7523.76;
                gain = -1.54;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band9 = {
                frequency = 15011.87;
                gain = -3.81;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
            };

            right = {
              band0 = {
                frequency = 29.95;
                gain = -15.44;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band1 = {
                frequency = 59.76;
                gain = -4.02;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band2 = {
                frequency = 119.24;
                gain = 11.23;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band3 = {
                frequency = 237.92;
                gain = -5.33;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band4 = {
                frequency = 474.72;
                gain = -13.7;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band5 = {
                frequency = 947.19;
                gain = -9.07;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band6 = {
                frequency = 1889.88;
                gain = -17.6;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band7 = {
                frequency = 3770.81;
                gain = -18.44;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band8 = {
                frequency = 7523.76;
                gain = -1.54;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band9 = {
                frequency = 15011.87;
                gain = -3.81;
                mode = "APO (DR)";
                mute = false;
                q = 1.50476;
                slope = "x1";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
            };
          };

          "limiter#0" = {
            alr = false;
            alr-attack = 5.0;
            alr-knee = 0.0;
            alr-knee-smooth = -5.0;
            alr-release = 50.0;
            attack = 5.0;
            bypass = false;
            dithering = "None";
            gain-boost = true;
            input-gain = 0.0;
            input-to-link = -80.01;
            input-to-sidechain = -80.01;
            link-to-input = -80.01;
            link-to-sidechain = -80.01;
            lookahead = 5.0;
            mode = "Line Wide";
            output-gain = 0.0;
            oversampling = "None";
            release = 5.0;
            sidechain-preamp = 0.0;
            sidechain-to-input = -80.01;
            sidechain-to-link = -80.01;
            sidechain-type = "Internal";
            stereo-link = 100.0;
            threshold = 0.0;
          };

          "loudness#0" = {
            bypass = false;
            clipping = false;
            clipping-range = 6.0;
            fft = "256";
            iir-approximation = "Normal";
            input-gain = 0.0;
            mode = "FFT";
            output-gain = 0.0;
            std = "ISO226-2023";
            volume = 7.0;
          };
        };
      };
    };
  };
}
