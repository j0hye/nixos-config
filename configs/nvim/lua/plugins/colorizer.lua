deps.add { source = 'norcalli/nvim-colorizer.lua' }
deps.later(function() 
    require('colorizer').setup() 
end)
