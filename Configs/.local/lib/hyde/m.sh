#!/bin/bash


# Yerel müzik klasörü dizini
mDIR="$HOME/Müzik/"

# Müzik dizininden ve alt dizinlerden yerel_muzik dizisini doldur
populate_local_music() {
  local_music=()
  filenames=()
  
  # Dizinin var olduğundan emin olalım
  if [[ ! -d "$mDIR" ]]; then
    echo "Hata: Müzik dizini bulunamadı: $mDIR"
    exit 1
  fi

  # find komutunu daha güvenli hale getirelim
  while IFS= read -r -d $'\0' file; do
    [[ -f "$file" ]] || continue
    local_music+=("$file")
    filenames+=("$(basename "$file")")
  done < <(find "$mDIR" -type f -regextype posix-extended -regex ".*\.(mp3|opus|flac|wav|ogg|mp4|m4a|aac|wma|alac|ape|aiff|webm|mpc|mka|dsf|dff|wv)$" -print0)

  # Dosya bulunamadıysa hata ver
  if [ ${#local_music[@]} -eq 0 ]; then
    echo "Hata: Müzik dosyası bulunamadı: $mDIR dizininde"
    exit 1
  fi
}

# Yerel müzik çalmak için ana fonksiyon
play_local_music() {
  populate_local_music

  echo "Müzik dizini: $mDIR"
  echo "Bulunan şarkı sayısı: ${#filenames[@]}"
  
  choice=$(printf '%s\n' "${filenames[@]}" |rofi -dmenu -theme ~/.local/share/hyde/rofi/themes/style_10.rasi "Local Music")
  
  if [ -z "$choice" ]; then
    echo "Hiçbir şarkı seçilmedi"
    exit 1
  fi
  
  found=0
  for (( i=0; i<"${#filenames[@]}"; ++i )); do
    if [[ "$choice" == "${filenames[$i]}" ]]; then
      found=1
      mpv --playlist-start="$i" --loop-playlist --vid=no "${local_music[@]}"
      return
    fi
  done

  if [[ $found -eq 0 ]]; then
    echo "Hata: Seçilen şarkı bulunamadı: $choice"
  fi
}

# Yerel müziği karıştırmak için ana fonksiyon
shuffle_local_music() {
  echo "Yerel müzik karışık çalınıyor"
  mpv --shuffle --loop-playlist --vid=no "$mDIR"
}

# Çalışan bir mpv işlemi varsa kontrol et ve sonlandır, yoksa müzik çal
pkill mpv && echo "Müzik durduruldu" || {

# Kullanıcıya seçim sun
user_choice=$(printf "Müzik Klasöründen Karışık Çal\nMüzik Klasöründen Çal" | rofi -dmenu -theme ~/.local/share/hyde/rofi/themes/style_10.rasi "Müzik kaynağı seçin")

  case "$user_choice" in
    "Müzik Klasöründen Karışık Çal")
      shuffle_local_music
      ;;
    "Müzik Klasöründen Çal")
      play_local_music
      ;;
    *)
      echo "Geçersiz seçim"
      ;;
  esac
}
