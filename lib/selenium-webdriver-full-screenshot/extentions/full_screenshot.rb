module Selenium
  module WebDriver
    module DriverExtensions
       module FullScreenshot
         def full_screenshot(filename)
           imgs = []
           (page_height.to_f / widnow_inner_height).ceil.times do |cnt|
             scroll_to(0, widnow_inner_height * cnt)
             sleep 1
             scroll_height = widnow_inner_height * cnt
             crop_height = scroll_height + widnow_inner_height - page_height
             crop_height = crop_height ? crop_height : 0
             # puts "#{scroll_height}, #{crop_height}"
             if crop_height < widnow_inner_height
               imgs << {
                 img: ChunkyPNG::Image.from_blob(@bridge.screenshot.unpack('m')[0]),
                 crop_height: crop_height,
                 window_height: widnow_inner_height,
                 window_width: widnow_inner_width
               }
             end
           end
           full_screenshot_png(imgs, filename)
         end

         def full_screenshot_png(imgs, filename)
           png_height = imgs.map{|img| img[:img].height}.inject { |sum, i| sum + i }
           compose_height = 0
           png_width = imgs.first[:img].width
           window_width = imgs.first[:window_width]
           retina = png_width > window_width ? 2 : 1
           last_img = imgs.pop
           last_crop_pos_y = last_img[:crop_height] * retina
           png_height -= last_crop_pos_y
           # binding.pry
           imgs << {
             img: last_img[:img].crop(0, last_crop_pos_y, last_img[:img].width, last_img[:img].height - last_crop_pos_y)
           }
           png = ChunkyPNG::Image.new(png_width, png_height, ChunkyPNG::Color::TRANSPARENT)
           # binding.pry
           imgs.each_with_index do |img, idx|
             png.compose!(img[:img], 0, compose_height)
             compose_height += img[:img].height
           end
           puts "full_screenshot_png: #{filename}"
           png.save("#{filename}.png")
         end

         def widnow_inner_height
           js = 'return window.innerHeight'
           bridge.execute_script(js)
         end

         def widnow_inner_width
           js = 'return window.innerWidth'
           bridge.execute_script(js)
         end

         def page_height
           js = 'return document.body.clientHeight'
           bridge.execute_script(js)
         end

         def page_width
           js = 'return document.body.clientWidth'
           bridge.execute_script(js)
         end

         def scroll_to(x, y)
           bridge.execute_script("window.scrollTo(#{x}, #{y})")
         end
       end
    end
  end
end
