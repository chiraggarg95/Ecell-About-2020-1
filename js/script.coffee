active = 1
active1 = 1

$('#nav-button').click ->
  $('#main-menu').css('display')
  $('#main-menu').css('display', 'block')
  $('#main-menu').css('opacity')
  $('#main-menu').css('opacity', '1')
  $('#nav-button-exit').css('opacity')
  $('#nav-button-exit').css('opacity', '1')
  $('#ecell-logo').css('filter')
  count = 0
  $('#main-menu li a').each ->
    count++
    $t = $(this)
    fun = () ->
      $t.css('opacity')
      $t.css('transform')
      $t.css('opacity', '1')
      $t.css('transform', 'none')
    setTimeout(fun, count * 150)

$('#nav-button-exit').click ->
  count = 0
  $('#main-menu li a').each ->
    $t = $(this)
    fun = () ->
      $t.css('opacity')
      $t.css('transform')
      $t.css('opacity', '0')
      $t.css('transform', 'scale(0.5)')
    setTimeout(fun, count * 150)
    count++

  fun = () ->
    $('#main-menu').css('opacity')
    $('#main-menu').css('opacity', '0')
    $('#nav-button-exit').css('opacity')
    $('#nav-button-exit').css('opacity', '0')

  fun2 = () ->
    $('#main-menu').css('display', 'none')

  setTimeout(fun, (count - 5) * 150)
  setTimeout(fun2, count * 150)

$('.navlink').hover(
  ->
    n = parseInt($(this).attr('id').slice(-1))
    n1 = if n >= active then active else n
    n2 = n + active - n1
    left = $('#navlink' + n1.toString()).offset().left
    right = $('#navlink' + n2.toString()).offset().left + parseInt($('#navlink' + n2.toString()).css('width'))
    width = right - left
    if $(window).width() > 750
      $('#underline').css('left', left.toString() + 'px').css('width', width.toString() + 'px');
  ->
    left = $('#navlink' + active.toString()).offset().left
    width = $('#navlink' + active.toString()).css('width');
    $('#underline').css('left', left.toString() + 'px').css('width', width);
)

transit_up = () ->
  $('#plane1, #plane2, #plane3').css('top', 'calc(100vh + 20px)')
  $('#plane1').animate({
    top: (-$(window).height() - 80).toString() + 'px'
  }, 1000, 'swing')
  $('#plane2').animate({
    top: (-$(window).height() - 80).toString() + 'px'
  }, 1500, 'swing')
  $('#plane3').animate({
    top: (-$(window).height() - 80).toString() + 'px'
  }, 2000, 'swing')

transit_down = () ->
  $('#plane1, #plane2, #plane3').css('top', '-100vh')
  $('#plane1').animate({
    top: ($(window).height() + 80).toString() + 'px'
  }, 1000, 'swing')
  $('#plane2').animate({
    top: ($(window).height() + 80).toString() + 'px'
  }, 1500, 'swing')
  $('#plane3').animate({
    top: ($(window).height() + 80).toString() + 'px'
  }, 2000, 'swing')

#tries = 0
#top = $('#section1').offset().top
#bottom = top + parseInt($('#section1').css('height')) - $(window).height() + 50
#
#$(document).scrollTop($('#section1').offset().top)
#
#$(document).on('scroll'
#->
#  if tries > 50
#    $('#navlink2').trigger('click')
#  else if $(document).scrollTop() > bottom
#    $(document).scrollTop(bottom)
#    tries++
#)
#
$('#section' + active.toString()).css('display', 'block').css('opacity', '1')
if ($(window).width() < 750)
  $('.navlink').parent().css('display', 'none')
  $('#navlink' + active.toString()).css('display', 'block').parent().css('display', 'table-cell')
else
  $('.navlink').css('display', 'block')

$(window).resize ->
  if ($(window).width() < 750)
    $('.navlink').parent().css('display', 'none')
    $('#navlink' + active.toString()).css('display', 'block').parent().css('display', 'table-cell')
  else
    $('.navlink').css('display', 'block')
#
#prv = Math.min(active - 1, 1)
#nxt = Math.max(active + 1, 4)

#limit_scroll = () ->
#  top = $('#section' + active.toString()).offset().top - 300
#  bottom = top + parseInt($('#section' + active.toString()).css('height')) - $(window).height() + 340
#  $(document).scrollTop(top)
#  $(document).on('scroll'
#  ->
#    if $(document).scrollTop() < top
#      $('#navlink2').trigger('click');
#    else if $(document).scrollTop() > bottom
#      $('#navlink1').trigger('click');
#  )
#
#limit_scroll()

nxt = active + 1
prv = active - 1
try1 = 0
try2 = 0

func1 = (e) ->
  if $(document).data('scrolling') == '1'
    return
  if typeof e.originalEvent.detail == 'number' && e.originalEvent.detail != 0
    if e.originalEvent.detail > 0
      try2 += 1
      try1 = 0
    else if e.originalEvent.detail < 0
      try1 += 1
      try2 = 0
  else if (typeof e.originalEvent.wheelDelta == 'number')
    if e.originalEvent.wheelDelta < 0
      try2 += 1
      try1 = 0
    else if e.originalEvent.wheelDelta > 0
      try1 += 1
      try2 = 0
  if try1 >= 2 && active > 1
    $('#navlink' + (active - 1).toString()).trigger('click')
  if try2 >= 2 && active < 4
    $('#navlink' + (active + 1).toString()).trigger('click')

$('body').on('wheel'
func1)

tsY = 0
teY = 0
tsX = 0
teX = 0
$(document).bind('touchstart'
  (e) ->
    tsY = e.originalEvent.touches[0].clientY
    tsX = e.originalEvent.touches[0].clientX
)

$(document).bind('touchend'
  (e) ->
    if $(document).data('scrolling') == '1'
      return
    teY = e.originalEvent.changedTouches[0].clientY
    teX = e.originalEvent.changedTouches[0].clientX
    if (tsY > teY+70) && active < 4
      $('#navlink' + (active + 1).toString()).trigger('click')
    else if(tsY < teY-70) && active > 1
      $('#navlink' + (active - 1).toString()).trigger('click')
    else
      if (tsX > teX+70)
        $('#right').trigger('click')
      else if(tsX < teX-70)
        $('#left').trigger('click')
)

$(window).bind('keydown'
  (e) ->
    e = e || window.event
    console.log('A key pressed')
    if (e.keyCode == 37)
      console.log('left')
      $('#left').trigger('click')
    else if (e.keyCode == 39)
      $('#right').trigger('click')
      console.log('right')
    else
      if $(document).data('scrolling') == '1'
        return
      if (e.keyCode == 40) && active < 4
        $('#navlink' + (active + 1).toString()).trigger('click')
      else if(e.keyCode == 38) && active > 1
        $('#navlink' + (active - 1).toString()).trigger('click')
)

#$(document).on('wheel'
#  (e) ->
#    if $(document).data('scrolling') == '1'
#      return
#    s = $(document).scrollTop()
#    if try1 <= 49 && s <= top
#      try1 += 1
#      $(document).scrollTop(top)
#    else if try2 <= 49 && s >= bottom
#      try2 += 1
#      $(document).scrollTop(bottom)
#
#    if (try2 >= 50)
#      $('#navlink' + (Math.min(4, nxt)).toString()).trigger('click')
#    else if (try1 >= 50)
#      $('#navlink' + (Math.max(0, prv)).toString()).trigger('click')
#)
#

$('.content').css('height', 'calc(90% - ' + $('.title').css('height') + ')')

$('body').on('mousewheel'
  (e) ->
    if typeof e.originalEvent.detail == 'number' && e.originalEvent.detail != 0
      if e.originalEvent.detail > 0
        console.log('Down')
      else if e.originalEvent.detail < 0
        console.log('Up')
    else if (typeof e.originalEvent.wheelDelta == 'number')
      if e.originalEvent.wheelDelta < 0
        console.log('Down')
      else if e.originalEvent.wheelDelta > 0
        console.log('Up')
)

$('.navlink').click (e) ->
  e.preventDefault()
  if $(document).data('scrolling') == '1'
    return
  $('.card').css('transition', '1s all')
  $(document).data('scrolling', '1')
  $('.navlink').css('cursor', 'default')
  id = parseInt($(this).attr('id').slice(-1))
  if (id != active)
    direction = if id > active then 1 else -1
    d = direction * 200
    $('#section' + active.toString()).find('.card').css('opacity', '0').css('transform', 'translateY(' + (-d).toString() + 'px)')
    $('#section' + id.toString()).find('.card').css('transform')
    $('#section' + id.toString()).find('.card').css('opacity')
    $('#section' + id.toString()).find('.card').css('opacity', '0')
    $('#section' + id.toString()).find('.card').css('transform', 'translateY(' + d.toString() + 'px)')

    prv = active

    setTimeout(->
        $('html, body').scrollTop(0)
        $('#section' + id.toString()).find('.card').css('opacity')
        $('#section' + id.toString()).find('.card').css('opacity', '0')
        $('#section' + id.toString()).find('.card').css('transform')
        $('#section' + id.toString()).find('.card').css('transform', 'none')
        $('#section' + active.toString()).find('.card').css('transform')
        $('#section' + active.toString()).find('.card').css('transform', 'none')
        $('#section' + id.toString()).find('.card1').css('opacity')
        $('#section' + id.toString()).find('.card1').css('opacity', '1')
        active1 = 1
        $('#background').attr('class', 'b' + $('#section' + id.toString()).find('.card:nth-of-type(' + active1.toString() + ')').find('.title').attr('class').slice(-1))
    1000)
    setTimeout(->
      if ($(window).width() < 750)
        $('.navlink').parent().css('display', 'none')
        $('#navlink' + id.toString()).css('display', 'block').parent().css('display', 'table-cell')
      else
        $('.navlink').css('display', 'block')
    1000)
    setTimeout(->
      nxt = active + 1
      prv = active - 1
      try1 = 0
      try2 = 0
      $(document).data('scrolling', '0')
      $('.navlink').css('cursor', 'pointer')
    2000)

    if id > active
      transit_up()
    else
      transit_down()

    active = id
    left = $('#navlink' + active.toString()).offset().left
    width = $('#navlink' + active.toString()).css('width')
    if $(window).width() < 750
      left = 0
      width = $(window).width() * active / 4
    $('#underline').css('left', left.toString() + 'px').css('width', width)

interval = setInterval(
  ->
    if $(document).data('scrolling') == '1'
      return
    $('#right').trigger('click')
  60000)

$('#left').click ->
  if $(this).prop('disabled')
    return
  clearInterval(interval)
  $('.card').css('transition', '0.25s all')
  n = $('#section' + active.toString()).find('.card').length
  id1 = (active1 + n - 2) % n + 1
  $('#left').prop('disabled', 'true');
  $('#right').prop('disabled', 'true');
  $('#section' + active.toString()).find('.card:nth-of-type(' + active1.toString() + ')').css('opacity', '0').css('transform', 'translateX(50%)')
  $('#section' + active.toString()).find('.card:nth-of-type(' + id1.toString() + ')').css('transform', 'translateX(-50%)')
  setTimeout(->
    $('#section' + active.toString()).find('.card:nth-of-type(' + active1.toString() + ')').css('opacity', '0').css('transform', 'none')
    $('#section' + active.toString()).find('.card:nth-of-type(' + id1.toString() + ')').css('opacity', '1')
    $('#left').removeAttr('disabled')
    $('#right').removeAttr('disabled')
  400)
  active1 = id1
  $('#background').attr('class', 'b' + $('#section' + active.toString()).find('.card:nth-of-type(' + active1.toString() + ')').find('.title').attr('class').slice(-1))
  interval = setInterval(
    ->
      if $(document).data('scrolling') == '1'
        return
      $('#right').trigger('click')
  60000)

$('#right').click ->
  if $(this).prop('disabled')
    return
  clearInterval(interval)
  $('.card').css('transition', '0.25s all')
  n = $('#section' + active.toString()).find('.card').length
  id1 = 1 + active1 % n
  $('#left').prop('disabled', 'true');
  $('#right').prop('disabled', 'true');
  $('#section' + active.toString()).find('.card').css('opacity', '0').css('transform', 'translateX(-50%)')
  $('#section' + active.toString()).find('.card:nth-of-type(' + id1.toString() + ')').css('transform', 'translateX(50%)')
  setTimeout(->
    $('#section' + active.toString()).find('.card').css('opacity', '0').css('transform', 'none')
    $('#section' + active.toString()).find('.card:nth-of-type(' + id1.toString() + ')').css('opacity', '1')
    $('#left').removeAttr('disabled')
    $('#right').removeAttr('disabled')
  400)
  active1 = id1
  $('#background').attr('class', 'b' + $('#section' + active.toString()).find('.card:nth-of-type(' + active1.toString() + ')').find('.title').attr('class').slice(-1))
  interval = setInterval(
    ->
      if $(document).data('scrolling') == '1'
        return
      $('#right').trigger('click')
  60000)

if $(window).width() > 750
  $('#underline').css('top', $('.navlink').offset().top - $(document).scrollTop() + parseInt($('.navlink').css('height'))).css('left', $('#navlink' + active.toString()).offset().left).css('width', $('#navlink' + active.toString()).css('width')).css('opacity', '1')
else
  $('#underline').css('top', (80 - parseInt($('#underline').css('height'))).toString() + 'px').css('width', ($(window).width() / 4).toString() + 'px').css('opacity', '1').css('left', '0')
$(window).resize ->
  if $(window).width() > 750
    $('#underline').css('top', $('.navlink').offset().top - $(document).scrollTop() + parseInt($('.navlink').css('height'))).css('left', $('#navlink' + active.toString()).offset().left).css('width', $('#navlink' + active.toString()).css('width')).css('opacity', '1')
  else
    $('#underline').css('top', (80 - parseInt($('#underline').css('height'))).toString() + 'px').css('width', ($(window).width() / 4 * active).toString() + 'px').css('opacity', '1').css('left', '0')

if $(window).width() <= 900
  setTimeout(
    ->
      $('#splash').animate({
        opacity: 0
      }, 1000)
  2500)

  setTimeout(
    ->
      $('#splash').css('display', 'none')
  3500)