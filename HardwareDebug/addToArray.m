function arr = addToArray(arr, currentSize, maxSize, newVal)
    if currentSize >= maxSize
        arr = [arr(2:end) newVal];
    else
        arr(currentSize + 1) = newVal;
    end
end

