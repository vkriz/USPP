function host = getHost(url)
    host = url;
    protocolEnd = min(strfind(url, '://')) + 3;
    hostEnds = strfind(url(protocolEnd:end), '/');
    if length(hostEnds) ~= 0
        hostEnd=min(hostEnds);
        host = url(1:protocolEnd+hostEnd-2);
    endif
    disp(host);
end