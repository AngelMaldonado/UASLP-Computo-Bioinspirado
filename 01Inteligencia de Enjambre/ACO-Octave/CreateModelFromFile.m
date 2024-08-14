function model=CreateModelFromFile(fileName)
    coords=dlmread(strrep(fileName, '.txt', '.coord.txt'));
    x=coords(:,1); % coordenadas x
    y=coords(:,2); % coordenadas y

    D=dlmread(fileName); % matriz de costos
    n=numel(x);

    model.n=n;
    model.x=x;
    model.y=y;
    model.D=D;
end
