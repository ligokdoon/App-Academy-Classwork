def select_even_nums(arr)
    arr.select { |num| num.even? }
end

def reject_puppies(arr)
    arr.reject { |hash| hash["age"] < 3 }
end

def count_positive_subarrays(arr)
    arr.select! { |subarr| subarr.sum > 0}
    arr.count
end

def aba_translate(str)
  vowels = "aeiouAEIOU"
  new_str = ""
  str.each_char do |char|
    if vowels.include?(char)
      new_str += char + "b" + char
    else
      new_str += char
    end
  end
  new_str
end

def aba_array(arr)
    arr.map {|word| aba_translate(word) }
end