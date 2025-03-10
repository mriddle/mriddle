---
layout: page
title: Resources
---

<div class="resources">
  {% for resource in site.resources %}
    <article class="resource">
      <div class="resource-header" onclick="window.location.href='{{ resource.url }}';" style="cursor: pointer;">
        <div class="resource-metadata">
          <time datetime="{{ resource.date | date_to_xmlschema }}">{{ resource.date | date: "%Y-%m-%d" }}</time>
        </div>
        <h2><a class="resource-link" href="{{ resource.url }}">{{ resource.title }}</a></h2>
        {% if resource.tags %}
          <p class="resource-tags">
            {% for tag in resource.tags %}
              <a href="/tag/{{tag}}">#{{tag}}</a>{% unless forloop.last %} {% endunless %}
            {% endfor %}
          </p>
        {% endif %}
      </div>
      <div class="resource-content">
        {{ resource.content | markdownify }}
      </div>
    </article>
  {% endfor %}
</div>
