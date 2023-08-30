 def solution(s)
    photos = s.split("\n")


    # organize the photos by location
    photos_by_location = {}
    photos.each do |photo|
        data = photo.split(",")
        file_name = data[0]
        location = data[1].strip()
        date = data[2].strip()
        extension = file_name.split(".")[1]
        
        if photos_by_location[location]
            photos_by_location[location].push([file_name, date])
        elsif !photos_by_location[location]
            photos_by_location[location] = [[file_name, date]]
        end
    end

    # organize photos by date taken for each location
    photos_by_date = {}
    photos_by_location.each do |location|
        photos_by_date[location[0]] = location[1] if !photos_by_date[location[0]]
        photos_by_date[location[0]] = photos_by_date[location[0]].sort {|a,b| a[1] <=> b[1]}
    end
    
    # Find how many photos are at each location
    num_photos_by_location = {}
    photos_by_location.each do |location|
        num_photos_by_location[location[0].strip()] = location[1].length()
    end

    # stitch all info together for desired organized result
    organized_photos = ""
    photos.each do |photo|
        data = photo.split(",")
        file_name = data[0]
        location = data[1].strip()
        date = data[2].strip()
        extension = data[0].split(".")[1]
       
        photos_by_date.each do |key, value|
            value.each.with_index(1) do |file, idx|
                if file_name == file[0]
                    digits = Math.log10(num_photos_by_location[key]).to_i + 1
                    organized_photos += "#{key}#{sprintf "%0#{digits}d", idx}.#{extension}\n"
                end
            end
        end
    end

    return organized_photos
end

string = "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"
print solution(string)