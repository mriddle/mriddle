---
layout: page
title: Posts
---

<div class="posts">
  {% for post in site.posts %}
    <article class="post">
      <div class="post-header" onclick="window.location.href='{{ post.url }}';" style="cursor: pointer;">
        <div class="post-metadata">
          <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%Y-%m-%d" }}</time>
        </div>
        <h2><a class="post-link" href="{{ post.url }}">{{ post.title }}</a></h2>
        {% if post.tags %}
          <p class="post-tags">
            {% for tag in post.tags %}
              <a href="/tag/{{tag}}">#{{tag}}</a>{% unless forloop.last %} {% endunless %}
            {% endfor %}
          </p>
        {% endif %}
      </div>
      <div class="post-content">
        {{ post.content | markdownify }}
      </div>
    </article>
  {% endfor %}
</div>
