%function fxResult = fx(fxPos, fxSatpos, fxSatCorr)
function fxResult = fx(fxPos, fxSatpos)

    fxSatcnt = size(fxSatpos);
    fxRho = zeros(fxSatcnt(1),1);
    for fxi=1:fxSatcnt(1)
        fxRho(fxi) = sqrt( (fxSatpos(fxi,1) - fxPos(1))^2 + (fxSatpos(fxi,2) - fxPos(2))^2 + (fxSatpos(fxi,3) - fxPos(3))^2 );
    end
    fxResult = fxRho;
    %end fx
    end