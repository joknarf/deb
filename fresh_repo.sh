# remove git history
rm -rf .git
git init

# commit current state
git add .
git commit -m "squash history"

# force push
git branch -M main   # or master
git remote add origin git@github.com:joknarf/deb
git push -f origin main
