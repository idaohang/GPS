function fxResult = fsx(fxPos, fxSatpos, fxSatCorr)

    fxSatcnt = length(fxSatCorr);
    fxRho = zeros(fxSatcnt,1);
    for fxi=1:fxSatcnt
        fxRho(fxi) = sqrt( (fxSatpos(fxi,1) - fxPos(1))^2 + (fxSatpos(fxi,2) - fxPos(2))^2 + (fxSatpos(fxi,3) - fxPos(3))^2 ) - fxSatCorr(fxi,1);
    end
    fxResult = fxRho;
    %end fx
    end
