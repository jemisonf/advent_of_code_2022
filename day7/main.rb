require 'json'

filename = ARGV[0]
contents = File.open(filename).readlines

tree = {"size" => 0, "/" => {"size" => 0, "name" => "/"}}

cd = /\$ cd (?<dir>.+)/
ls = /\$ ls/
dir = /dir (?<dir>.+)/
file = /(?<size>\d+) (?<name>.+)/

current_dir = tree

contents.each do |line| 
    if cdmatch = cd.match(line)
        new_dir = current_dir[cdmatch["dir"]]

        new_dir[".."] = current_dir if cdmatch["dir"] != ".."

        current_dir = new_dir
    elsif dirmatch = dir.match(line)
        current_dir[dirmatch["dir"]] = {"size" => 0, "name" => dirmatch["dir"]}
        next
    elsif filematch = file.match(line)
        size = filematch["size"] 

        current_dir["size"] += size.to_i
        current_dir[filematch["name"]] = size.to_i
        next
    end
end

dir_sizes = {}

def find_files (dir)
    files = []

    dir.each do |key, value|
        if value.is_a? Integer and key != "size"
            files.append(value)
        elsif value.is_a? Hash and key != ".."
            files.concat(find_files(value))
        end
    end

    return files
end

def compute_dir_size (dir, dir_sizes)
    files = find_files(dir)
    size = files.sum
    dir_sizes[dir["name"]] = size
    dir.each do |key, value|
        if value.is_a? Hash and key != ".."
            compute_dir_size(value, dir_sizes)
        end
    end
end

def print_tree (tree, indent_level=0)
    puts "#{"-"*indent_level}-> #{tree["name"]} (#{find_files(tree).sum})"
    tree.each do |key, value|
        print_tree(value, indent_level + 2) if value.is_a? Hash and key != ".."
    end

end

print_tree(tree["/"], 0)

compute_dir_size(tree, dir_sizes)

# puts dir_sizes
part_1_answer = 0
dir_sizes.each do |dir, size| 
    part_1_answer += size if size <= 100000
end

puts part_1_answer

