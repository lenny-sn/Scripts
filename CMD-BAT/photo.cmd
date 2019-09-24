chcp 1251
Set Source=C:\Users\tav\Desktop\фотографии выездов
forfiles /p "%Source%" /m "*.jpg" /s /c "cmd /c if @fsize gtr 1500000 C:\inst\Photo\nconvert.exe -overwrite -ratio -resize 50%% 0 @file"

