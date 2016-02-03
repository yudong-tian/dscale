
for id in 29935 6856 20209 29645 10374; do 
 `wget ftp://128.117.82.212/pub/download/data/yudon$id/*.Z`
 ./move-data.sh
done
