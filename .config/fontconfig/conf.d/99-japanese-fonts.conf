<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">

<!--
For font consistency, all applications should be set to use the serif,
sans-serif, and monospace aliases, which are mapped to particular fonts by
fontconfig.

This fonts.conf specifies a default font for the Japanese locale (ja_JP)
and keeps western style fonts for Latin letters.

https://tatsumoto.neocities.org/blog/japanese-fonts.html
https://wiki.archlinux.org/index.php/Font_configuration/Examples#Japanese
https://wiki.archlinux.org/index.php/Metric-compatible_fonts
https://www.freedesktop.org/software/fontconfig/fontconfig-user.html
-->

<fontconfig>
    <match target="font">
        <edit name="embeddedbitmap" mode="assign">
            <bool>true</bool>
        </edit>
    </match>

    <!-- Default font (no fc-match pattern) -->
    <match>
        <edit name="family" mode="append">
            <string>Noto Sans CJK JP</string>
        </edit>
        <edit name="family" mode="append">
            <string>Noto Sans</string>
        </edit>
    </match>

    <!-- Default font for the ja_JP locale (no fc-match pattern) -->
    <match>
        <test compare="contains" name="lang">
            <string>ja</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Noto Sans CJK JP</string>
        </edit>
    </match>

    <!-- Default serif fonts -->
    <match>
        <test qual="any" name="family">
            <string>serif</string>
        </test>
        <edit name="family" mode="prepend" binding="strong">
            <string>Noto Serif</string>
        </edit>
        <edit name="family" mode="prepend" binding="strong">
            <string>Noto Serif CJK JP</string>
        </edit>
        <edit name="family" mode="prepend" binding="strong">
            <string>IPAPMincho</string>
        </edit>
        <edit name="family" mode="prepend" binding="strong">
            <string>HanaMinA</string>
        </edit>
        <edit name="family" mode="prepend" binding="strong">
            <string>HanaMinB</string>
        </edit>
    </match>

    <!-- Default sans-serif fonts -->
    <match target="pattern">
        <test qual="any" name="family">
            <string>sans-serif</string>
        </test>
        <edit name="family" mode="prepend" binding="strong">
            <string>Noto Sans</string>
        </edit>
        <edit name="family" mode="prepend" binding="strong">
            <string>Noto Sans CJK JP</string>
        </edit>
        <edit name="family" mode="prepend" binding="strong">
            <string>IPAPGothic</string>
        </edit>
    </match>

    <!-- Default monospace fonts -->
    <match target="pattern">
        <test qual="any" name="family">
            <string>monospace</string>
        </test>
        <edit name="family" mode="prepend" binding="strong">
            <string>Noto Sans Mono</string>
        </edit>
        <edit name="family" mode="prepend" binding="strong">
            <string>Noto Sans Mono CJK JP</string>
        </edit>
    </match>

    <!-- Japanese -->
    <match>
        <test name="lang" compare="contains">
            <string>ja</string>
        </test>
        <test name="family">
            <string>serif</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Noto Serif CJK JP</string>
        </edit>
    </match>
    <match>
        <test name="lang" compare="contains">
            <string>ja</string>
        </test>
        <test name="family">
            <string>sans-serif</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Noto Sans CJK JP</string>
        </edit>
    </match>
    <match>
        <test name="lang" compare="contains">
            <string>ja</string>
        </test>
        <test name="family">
            <string>monospace</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Noto Sans Mono CJK JP</string>
        </edit>
    </match>

    <!-- Chinese -->
    <match>
        <test name="lang" compare="contains">
            <string>zh</string>
        </test>
        <test name="family">
            <string>serif</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Noto Serif CJK SC</string>
        </edit>
    </match>
    <match>
        <test name="lang" compare="contains">
            <string>zh</string>
        </test>
        <test name="family">
            <string>sans-serif</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Noto Sans CJK SC</string>
        </edit>
    </match>
    <match>
        <test name="lang" compare="contains">
            <string>zh</string>
        </test>
        <test name="family">
            <string>monospace</string>
        </test>
        <edit name="family" mode="prepend">
            <string>Noto Sans Mono CJK SC</string>
        </edit>
    </match>

    <!-- WenQuanYi Zen Hei -> WenQuanYi Micro Hei -->
    <match target="pattern">
        <test qual="any" name="family">
            <string>WenQuanYi Zen Hei</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>WenQuanYi Micro Hei</string>
        </edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family">
            <string>WenQuanYi Zen Hei Lite</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>WenQuanYi Micro Hei Lite</string>
        </edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family">
            <string>WenQuanYi Zen Hei Mono</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>WenQuanYi Micro Hei Mono</string>
        </edit>
    </match>

    <!-- Microsoft YaHei, SimHei, SimSun -> WenQuanYi Micro Hei -->
    <match target="pattern">
        <test qual="any" name="family">
            <string>Microsoft YaHei</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>WenQuanYi Micro Hei</string>
        </edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family">
            <string>SimHei</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>WenQuanYi Micro Hei</string>
        </edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family">
            <string>SimSun</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>WenQuanYi Micro Hei</string>
        </edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family">
            <string>SimSun-18030</string>
        </test>
        <edit name="family" mode="assign" binding="same">
            <string>WenQuanYi Micro Hei</string>
        </edit>
    </match>

    <!-- Fallback fonts preference order -->
    <alias>
        <family>sans-serif</family>
        <prefer>
            <family>Noto Sans</family>
            <family>Noto Sans CJK JP</family>
            <family>Open Sans</family>
            <family>Droid Sans</family>
            <family>Ubuntu</family>
            <family>Roboto</family>
            <family>Source Han Sans JP</family>
            <family>IPAPGothic</family>
            <family>VL PGothic</family>
            <family>Koruri</family>
        </prefer>
    </alias>

    <alias>
        <family>serif</family>
        <prefer>
            <family>Noto Serif</family>
            <family>Noto Serif CJK JP</family>
            <family>Droid Serif</family>
            <family>Roboto Slab</family>
            <family>IPAPMincho</family>
            <family>HanaMinA</family>
            <family>HanaMinB</family>
        </prefer>
    </alias>

    <alias>
        <family>monospace</family>
        <prefer>
            <family>Noto Sans Mono</family>
            <family>Noto Sans Mono CJK JP</family>
            <family>Inconsolatazi4</family>
            <family>Ubuntu Mono</family>
            <family>Droid Sans Mono</family>
            <family>Roboto Mono</family>
            <family>IPAPGothic</family>
        </prefer>
    </alias>
</fontconfig>
