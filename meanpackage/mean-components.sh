# ng generate component $3-new
# ng generate component $3-list
# ng generate component $3-rate
# ng generate component $3-show
# ng generate component $3-edit
echo ' * Deleting Angular .gitignore file'
rm .gitignore
echo ' * Deleting Angular .git folder'
rm .git
echo ' * Navigating into Project from Project>Client Folder..'
cd ..
echo ' * Initiallizing Git..'
git init
echo ' * Staging all Changes on Git..'
git add .
echo ' * Committing all Changes..'
git commit -m "First Commit"
echo ' * Navigating into Project Folder..'
cd client
echo ' * Setup Completed'
echo ' * Activating Angular Build and Watch..'
ng build --watch
