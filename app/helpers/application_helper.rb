module ApplicationHelper

  def class_if(condition, klass)
    condition ? klass : ''
  end

  def percentage_for_star(model, field, star)
    [0, ((model.send(field) + 1 - star) * 100).to_i].max
  end

  def color_for_rating(rating)
    case rating
    when 0
      '#BB0F0F'
    when 1
      '#cd7335'
    when 2
      '#367642'
    end
  end

  def color_for_bool(bool)
    bool ? '#367642' : '#BB0F0F'
  end

  def icon(icon_name, icon_color: '#fff', width: 16, height: 16)
    case icon_name
    when 'wifi'
      %{
        <svg width='#{ width }' height='#{ height }' viewBox="0 0 16 16" fill='#{ icon_color }'><rect x="1" y="8" width="3" height="6" rx="1"></rect><rect x="6" y="5" width="3" height="9" rx="1" fill-opacity=""></rect><rect x="11" y="2" width="3" height="12" rx="1" fill-opacity=""></rect></svg>
      }.html_safe

      %{
        

        <svg data-slide-over-target='wifi' xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width='#{ width }' height='#{ height }' fill='#{ icon_color }'>
          <path fill-rule="evenodd" d="M1.371 8.143c5.858-5.857 15.356-5.857 21.213 0a.75.75 0 010 1.061l-.53.53a.75.75 0 01-1.06 0c-4.98-4.979-13.053-4.979-18.032 0a.75.75 0 01-1.06 0l-.53-.53a.75.75 0 010-1.06zm3.182 3.182c4.1-4.1 10.749-4.1 14.85 0a.75.75 0 010 1.061l-.53.53a.75.75 0 01-1.062 0 8.25 8.25 0 00-11.667 0 .75.75 0 01-1.06 0l-.53-.53a.75.75 0 010-1.06zm3.204 3.182a6 6 0 018.486 0 .75.75 0 010 1.061l-.53.53a.75.75 0 01-1.061 0 3.75 3.75 0 00-5.304 0 .75.75 0 01-1.06 0l-.53-.53a.75.75 0 010-1.06zm3.182 3.182a1.5 1.5 0 012.122 0 .75.75 0 010 1.061l-.53.53a.75.75 0 01-1.061 0l-.53-.53a.75.75 0 010-1.06z" clip-rule="evenodd" />
        </svg>

      }.html_safe
    when 'coffee'
      %{
        <svg data-slide-over-target='coffee' xmlns="http://www.w3.org/2000/svg" width='#{ width }' height='#{ height }' fill='#{ icon_color }' viewBox="0 0 512 512"><!-- Font Awesome Pro 5.15.4 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) --><path d="M428,175,480,32H88A88,88,0,0,0,0,120v88a16,16,0,0,0,16,16H32a16,16,0,0,0,16-16V120A40,40,0,0,1,88,80h25.46l34.73,95.53C96.92,215.22,64,276.16,64,344.62c0,51.47,18.62,84.77,49.64,117.71A57.18,57.18,0,0,0,155.17,480H420.84a57.08,57.08,0,0,0,41.45-17.6c31-32.95,49.69-66.24,49.71-117.72C512,276.86,480,215.07,428,175ZM411.47,80l-29.09,80H193.62L164.53,80ZM114.09,320c7.11-46.22,34.2-85.91,72.12-112H392.07c37.25,26.13,63,66.23,69.84,112Z"/></svg>
      }.html_safe
    when 'plugs'
      %{
        <svg data-slide-over-target='plugs' xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512" width='#{ width }' height='#{ height }' fill='#{ icon_color }'><!-- Font Awesome Pro 5.15.4 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) --><path d="M352,128H304V16a16,16,0,0,0-32,0V128H112V16a16,16,0,0,0-32,0V128H32A32,32,0,0,0,0,160v32a32,32,0,0,0,32,32v32c0,82.75,63.37,150.22,144,158.38V512h32V414.38c80.63-8.16,144-75.63,144-158.38V224a32,32,0,0,0,32-32V160A32,32,0,0,0,352,128ZM320,256a128,128,0,0,1-256,0V224H320Zm32-64H32V160H352Z"/></svg>
      }.html_safe
    when 'download'
      %{
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width='#{ width }' height='#{ height }' fill='#{ icon_color }'>
          <path fill-rule="evenodd" d="M12 2.25a.75.75 0 01.75.75v11.69l3.22-3.22a.75.75 0 111.06 1.06l-4.5 4.5a.75.75 0 01-1.06 0l-4.5-4.5a.75.75 0 111.06-1.06l3.22 3.22V3a.75.75 0 01.75-.75zm-9 13.5a.75.75 0 01.75.75v2.25a1.5 1.5 0 001.5 1.5h13.5a1.5 1.5 0 001.5-1.5V16.5a.75.75 0 011.5 0v2.25a3 3 0 01-3 3H5.25a3 3 0 01-3-3V16.5a.75.75 0 01.75-.75z" clip-rule="evenodd" />
        </svg>
      }.html_safe
    when 'upload'
      %{
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width='#{ width }' height='#{ height }' fill='#{ icon_color }'>
          <path fill-rule="evenodd" d="M11.47 2.47a.75.75 0 011.06 0l4.5 4.5a.75.75 0 01-1.06 1.06l-3.22-3.22V16.5a.75.75 0 01-1.5 0V4.81L8.03 8.03a.75.75 0 01-1.06-1.06l4.5-4.5zM3 15.75a.75.75 0 01.75.75v2.25a1.5 1.5 0 001.5 1.5h13.5a1.5 1.5 0 001.5-1.5V16.5a.75.75 0 011.5 0v2.25a3 3 0 01-3 3H5.25a3 3 0 01-3-3V16.5a.75.75 0 01.75-.75z" clip-rule="evenodd" />
        </svg>
      }.html_safe
    end
  end
end
