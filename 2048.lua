-- created by coolsa. ver 1.4

local function win(area)
    can=false
    for a=1,4 do
        for b=1,4 do
            if area[a][b]>=11 then
                can=true
            end
        end
    end
    return can
end

local function drawPix( xPos, yPos )
	term.setCursorPos(xPos, yPos)
	term.write(" ")
end

local function compr(old,new)
    c=0
    for a=1,4 do
        for b=1,4 do
            if old[a][b]==new[a][b] then
                c=c+1
            end
        end
    end
    if c==16 then return true else return false end
end

local function cln(cln)
    c={}
    for a=1,4 do
        c[a]={}
        for b=1,4 do
            c[a][b]=cln[a][b]
        end
    end
    return c
end

local function randVal()
    if(math.random(10)%10==0) then
        return 2
    else
        return 1
    end
end

local function randTile(area)
    i=0
    while true do
        x=math.random(4)
        y=math.random(4)
        val=randVal()
        if area[x][y]==0 then
            break
        elseif area[x][y]~=0 then
            i=i+1
        end
        if i>=101 then
            break
        end
    end
    if i>=100 then
        x,y,val=0,0,"nope"
    end
    return x,y,val
end

function board()
    board={}
    for a=0,5 do
        board[a]={}
        for b=0,5 do
            board[a][b]=0
        end
    end
    return board
end
--move up -> check down -> move up
function meldUp(ar)
    for c=1,3 do
        for a=1,4 do
            for b=3,1,-1 do
                if ar[a][b]==0 then
                    ar[a][b]=ar[a][b+1]
                    ar[a][b+1]=0
                end
            end
        end
    end

    for a=1,4 do
        for b=1,3 do
            if (ar[a][b]>0 and ar[a][b]==ar[a][b+1]) then
                ar[a][b]=ar[a][b]+1
                ar[a][b+1]=0
            end
        end
    end

    for c=1,3 do
        for a=1,4 do
            for b=3,1,-1 do
                if ar[a][b]==0 then
                    ar[a][b]=ar[a][b+1]
                    ar[a][b+1]=0
                end
            end
        end
    end
    return ar
end

function meldDown(ar)
    for c=1,3 do
        for a=1,4 do
            for b=1,3 do
                if ar[a][b+1]==0 then
                    ar[a][b+1]=ar[a][b]
                    ar[a][b]=0
                end
            end
        end
    end

    for a=1,4 do
        for b=3,1,-1 do
            if (ar[a][b]>0 and ar[a][b]==ar[a][b+1]) then
                ar[a][b+1]=ar[a][b+1]+1
                ar[a][b]=0
            end
        end
    end

    for c=1,3 do
        for a=1,4 do
            for b=1,3 do
                if ar[a][b+1]==0 then
                    ar[a][b+1]=ar[a][b]
                    ar[a][b]=0
                end
            end
        end
    end
    return ar
end

function meldRight(ar)
    for c=1,3 do
        for a=1,4 do
            for b=3,1,-1 do
                if ar[b][a]==0 then
                    ar[b][a]=ar[b+1][a]
                    ar[b+1][a]=0
                end
            end
        end
    end

    for a=1,4 do
        for b=1,3 do
            if (ar[b][a]>0 and ar[b][a]==ar[b+1][a]) then
                ar[b][a]=ar[b][a]+1
                ar[b+1][a]=0
            end
        end
    end

    for c=1,3 do
        for a=1,4 do
            for b=3,1,-1 do
                if ar[b][a]==0 then
                    ar[b][a]=ar[b+1][a]
                    ar[b+1][a]=0
                end
            end
        end
    end

    return ar
end

function meldLeft(ar)
    for c=1,3 do
        for a=1,4 do
            for b=1,3 do
                if ar[b+1][a]==0 then
                    ar[b+1][a]=ar[b][a]
                    ar[b][a]=0
                end
            end
        end
    end

    for a=1,4 do
        for b=3,1,-1 do
            if (ar[b][a]>0 and ar[b][a]==ar[b+1][a]) then
                ar[b+1][a]=ar[b+1][a]+1
                ar[b][a]=0
            end
        end
    end

    for c=1,3 do
        for a=1,4 do
            for b=1,3 do
                if ar[b+1][a]==0 then
                    ar[b+1][a]=ar[b][a]
                    ar[b][a]=0
                end
            end
        end
    end

    return ar
end

board=board()
for i=1,2 do
    a,b,val=randTile(board)
    board[a][b]=val
end
while true do
    oboard=cln(board)
    local event,pra=os.pullEvent()
    term.clear()
    if pra==14 then 
        break
    elseif pra==200 then
        board=meldUp(board)
    elseif pra==205 then
        board=meldLeft(board)
    elseif pra==203 then
        board=meldRight(board)
    elseif pra==208 then
        board=meldDown(board)
    end
    
    if compr(oboard,board)==false then
       a,b,val=randTile(board)
       board[a][b]=val
    end
    for y=1,4 do
        for x=1,4 do
            term.setCursorPos(x*5-3,y*4-2)
            if board[x][y]==0 then
                term.write("     ")
            else
                term.write(2^board[x][y])
            end
        end
    end
    if win(board) then
        term.setCursorPos(1,16)
        term.write("you win!")
    end
end
term.setCursorPos(1,1)
--backspace = 14 exit.
--up = 200       1
--left 203       2
--right 205      3
--down = 208     4 
