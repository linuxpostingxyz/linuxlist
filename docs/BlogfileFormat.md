# Blogfile Formatting

The blogfile is written in yaml.

It has:

- blogs: an attribute set/hashmap
  - the keys are `url`s, and the values are `blog`s

## blogs

A `blog` has the following properties:

- name: the name of the blog
- birthday: when the blog was created (YYYY-MM-DD)
- url: the blog's `url`
- prop: the blog's submitted propaganda
- about: (optional) some info about what this software/distro is.
- icon: a link to an icon (relative to website root)
- parents: a list of blogs that heirarchically are above it (eg. ubuntu above debian, retropi above raspbian, c above linux kernel)
  - list of `url`
- children: parents, but below rather than above (make sure these cross refference eachother) 

## url

a url is a string that references a page `tumblr.com/{url}`.
(eg. `steamos-official` -> `tumblr.com/steamos-official`)
