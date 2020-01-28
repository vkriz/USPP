function newUrl = clean(url)
    https = regexp(url, 'https://');
    if ~isempty(https)
        newUrl = url(9:end);
    else
        http = regexp(url, 'http://');
        newUrl = url(8:end);
    end
    www = regexp(newUrl, 'www.');
    if ~isempty(www)
        newUrl = newUrl(5:end);
    end
    disp(newUrl);
end