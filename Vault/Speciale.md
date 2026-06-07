## Maxdepth
Check number of images in top of category folder instead of in images folder
```
find . -maxdepth 2 -type f -iname "*.png"  | wc -l
```

Move all the png images into their images folders
```bash
find . -mindepth 1 -maxdepth 1 -type d -exec sh -c '
for d do
  if ls "$d"/*.png >/dev/null 2>&1; then
    mkdir -p "$d/images"
    mv "$d"/*.png "$d/images/"
  fi
done
' sh {} +
```
