function calculateVelocity(myData, myIDs)

    for i = 1:length(myIDs)
        birdIndex = find(myData{9} == myIDs(i));
        ithBirdLat = myData{4}(birdIndex);
        ithBirdLon = myData{3}(birdIndex);
        ithBirdElev = myData{6}(birdIndex);
        ithBirdOrient = myData{5}(birdIndex);
        ithBirdTime = myData{2}(birdIndex);
        
        t = datevec(ithBirdTime, 'HH:MM:SS.FFF');
        tVector = t(:,4:6) * [1; 1/60; 1/360];
        
%         timeCell = regexp(ithBirdTime,':','split')
        
%         t = str2double();
%         
%         t = t * [1; 1/60; 1/360];
%         

%         rates2D = hypot(diff(ithBirdLon),diff(ithBirdLat)) ./ diff(tVector);
        my2d = diff(sqrt(ithBirdLon.^2 + ithBirdLat.^2));
        [m, n] = size(my2d);
        if m == 0 && n == 0
            rates2D = my2d / tVector;
        else
%             rates2D = my2d(1:end - 1) ./ diff(tVector);
            rates2D = my2d ./ diff(tVector);
        end
        
        my3d = diff(sqrt(ithBirdLon.^2 + ithBirdLat.^2 + (str2double(ithBirdElev)).^2));
        [m, n] = size(my3d);
        if m == 0 && n == 0
            rates3D = my3d / tVector;
        else
%             rates3D = my3d(1:end - 1) ./ diff(tVector);
            rates3D = my3d ./ diff(tVector);
        end
        
        rates2D(rates2D == Inf) = 0;
        rates3D(rates3D == Inf) = 0;
        
        if m == 0 && n == 0
            rates2D = zeros(1, 2);
            rates2D(1, 1) = 0;
            rates2D(1, 2) = tVector;
            rates3D = zeros(1, 2);
            rates3D(1, 1) = 0;
            rates3D(1, 2) = tVector;
        else
            rates2D(:,2) = tVector(1:end-1);
            rates3D(:,2) = tVector(1:end-1);
        end

        fileName2D = strcat('bird', num2str(myIDs(i)), '2D.txt');
        dlmwrite(fileName2D, rates2D);
        
        fileName3D = strcat('bird', num2str(myIDs(i)), '3D.txt');
        dlmwrite(fileName3D, rates3D);
        
%         birdFid = fopen(fileName, 'w');
%         fprintf(birdFid, '%f %f\n', rates2D);
%         fclose(birdFid);
    end