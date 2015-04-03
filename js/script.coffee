class Game
    isX: true
    moves: 0
    winner: null

    field: null
    playerX: 0
    playerO: 0


    winningNumbers: [7, 56, 448, 73, 146, 292, 273, 84]

    constructor: -> 
        @field = (Math.pow(2, x) for x in [0..8])

    currentMark: ->
        if @isX then 'x' else 'o'

    currentPlayer: ->
        if @isX then @playerX else @playerO

    checkWin: ->
        for number in @winningNumbers
            if (number & @currentPlayer()) == number
                @winner = "player #{@currentMark()}"
                console.log "winner is #{@winner}"
                divs = document.getElementsByClassName 'square'
                for i in divs 
                    i.innerHTML = ''
                @reset()
        if @moves > 8
            @winner = 'nichya'
            console.log "#{@winner}"
            divs = document.getElementsByClassName 'square'
            for i in divs 
                i.innerHTML = ''
            @reset()

    updateMark: ->
        @isX = !@isX

    update: (index) ->
        if @isX 
            @playerX += @field[index]
        else
            @playerO += @field[index]
        @moves++
        @checkWin()
        @updateMark()

    reset: ->
        @playerX = 0
        @playerO = 0
        @isX = false
        @moves = 0
        @winner = null

game = new Game

divs = document.getElementsByClassName 'square'

class Square 
    constructor: (@el, @index) -> 

    onclick: -> 
        square = @
        @el.onclick = ->
            @innerHTML = game.currentMark()
            game.update square.index


for i, index in divs
    square = new Square(i, index)
    square.onclick()