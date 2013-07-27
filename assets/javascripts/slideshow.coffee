$ ->
  $slideshow = $('.slideshow')
  $counter = $('<span class="counter">')
  $slideshow.prepend($counter)
  $items = $slideshow.children('div')
  total = $items.length
  current = 0

  updateCounter = ->
    $counter.text((current + 1) + "/" + total)

  nextSlide = ->
    next = (current + 1) % total
    $items.eq(next).css({ zIndex: 1 })
    $items.eq(current).css({ zIndex: -1 })
    updateCounter()
    current = next

  timer = setInterval(nextSlide, 5000)
  updateCounter()
