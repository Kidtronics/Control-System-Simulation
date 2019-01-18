function arr = addToArray(arr, currentSize, maxSize, newVal)
    if currentSize >= maxSize
        sizeDiff = currentSize - maxSize;
        arr = [arr(sizeDiff + 2, end) newVal];
    else
        arr(currentSize + 1) = newVal;
    end
end

