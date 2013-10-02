## Lonely Planet public facing technical blog

A blog for Lonely Planet technical staff to share their technical encounters, for the purpose of increasing awareness of LP's technical prowess, capabilities and interesting technical challenges.

### Writing a post

Write your drafts under the `_drafts` folder with a filename like `2013-08-05-agile-evaluations.md`
When you're ready to publish a post move it into the `_posts` folder.

### Deployment

`git push`

Our blog is setup with just the `gh-pages` branch so anything you do in this branch will be displayed on our site on push. (It can take up to 10 minutes to be reflected)

### Development

Run the following line from within the project and make your changes.

`bundle exec jekyll serve --watch --baseurl ""`

Jekyll will automatically update as you updated the blog. If you want to know more, this [Using Jekyll](https://help.github.com/articles/using-jekyll-with-pages) page is wonderfully basic.
