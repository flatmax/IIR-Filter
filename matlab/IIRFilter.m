% Copyright (c) 2017-2019 The IIR-Filter Authors. All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%
%    * Redistributions of source code must retain the above copyright
% notice, this list of conditions and the following disclaimer.
%    * Redistributions in binary form must reproduce the above
% copyright notice, this list of conditions and the following disclaimer
% in the documentation and/or other materials provided with the
% distribution.
%    * Neither the name of mad chops coder AU nor the names of its
% contributors may be used to endorse or promote products derived from
% this software without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
% A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
% OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
% LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
% DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
% THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function IIRFilter
% convert the filters from char arrays to double arrays - these filters were found using the Siglution webapp
Bc=[0,0,0,0,0,0,240,63,92,97,61,172,152,117,7,64,22,244,144,38,31,67,17,64,255,126,223,67,126,167,17,64,160,218,193,5,251,28,16,64,153,13,24,206,145,210,14,64,119,168,207,171,54,33,10,64,100,196,229,226,163,78,0,64,153,121,5,252,107,184,235,63,140,199,171,16,201,132,205,63,78,146,42,109,32,71,159,63];
Ac=[0,0,0,0,0,0,240,63,108,235,52,52,65,245,228,63,82,36,95,165,154,15,249,63,46,106,165,75,35,121,240,63,96,109,179,103,200,180,239,63,54,127,198,95,102,78,223,63,245,94,194,170,119,173,211,63,30,178,239,110,37,155,182,63,111,166,239,44,27,62,163,63,84,95,29,19,39,154,130,63,30,58,119,188,41,70,113,63];
fn=tempname;
B=convertToDouble(Bc, fn);
A=convertToDouble(Ac, fn);

% filter a signal
N=1024;
x=zeros(N,1);
x(1)=1;
y=filter(B, A, x);
semilogx(y)
end

function d=convertToDouble(c, fn)
% converts a character array c to a double array d using file utils
[fid, msg]=fopen(fn,'w');
if fid==-1
    msg
    return;
end
fwrite(fid, c, 'uint8');
fclose(fid);

[fid, msg]=fopen(fn,'r');
if fid==-1
    msg
    return;
end
d=fread(fid, 'float64')
fclose(fid);
end
