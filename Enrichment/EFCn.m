% Theo Knijnenburg
% Institute for Systems Biology
%
% August 2013
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Warranty Disclaimer and Copyright Notice
% 
% Copyright (C) 2003-2013 Institute for Systems Biology, Seattle, Washington, USA.
% 
% The Institute for Systems Biology and the authors make no representation about the suitability or accuracy of this software for any purpose, and makes no warranties, either express or implied, including merchantability and fitness for a particular purpose or that the use of this software will not infringe any third party patents, copyrights, trademarks, or other rights. The software is provided "as is". The Institute for Systems Biology and the authors disclaim any liability stemming from the use of this software. This software is provided to enhance knowledge and encourage progress in the scientific community. 
% 
% This is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
% 
% You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function S = EFCn(O,m,s,pth);

if nargin<4;
    pth = 1e-6;
end

%% Enrichment
Zs = -norminv(pth);
Os = Zs.*s + m;
E = O./Os;
E(E<1|isnan(E))=1;


%% Depletion
Zs = norminv(pth);
Os = Zs.*s + m;
D = O./Os;
D(D>1|isnan(D)|Os<0)=1;

%% Score =
S = ones(size(E));
S(E>1) = E(E>1);
S(D<1) = D(D<1);
S = log2(S);