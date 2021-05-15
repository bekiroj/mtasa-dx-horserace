Racing = Service:new('horse-race')
author = 'github.com/bekiroj'
font = DxFont('components/Roboto.ttf', 9)
screen = Vector2(guiGetScreenSize())
show = false
dxDrawRectangle = dxDrawRectangle
dxDrawImage = dxDrawImage
dxDrawText = dxDrawText

Racing.constructor = function()
	show = true
	active = false
	finish = false
	maxX = 600
	redX = 0
	yellowX = 0
	blueX = 0
	selected = 'N/A'
	winner = 'N/A'
	showCursor(true)

	Racing.render = Timer(
		function()
			if show and localPlayer:getData('money') > 5000 then
				dxDrawOuterBorder(screen.x/2-650/2, screen.y/2-350/2, 700, 400, 2, tocolor(10,10,10,250))
				dxDrawRectangle(screen.x/2-650/2, screen.y/2-350/2, 700, 400, tocolor(0,0,0,255))
				dxDrawRectangle(screen.x/2-650/2, screen.y/2-350/2, 700, 400, tocolor(5,5,5,225))
				dxDrawRectangle(screen.x/2-600/2, screen.y/2-250/2, 650, 150, tocolor(58,87,58,225))
				dxDrawImage(screen.x/2-625/2, screen.y/2-375/2, 75, 75, 'components/logo.png')
				dxDrawText('Oynamak İstediğiniz Atı Seçin:',screen.x/2-575/2, screen.y/2+100/2, 650, 150, tocolor(200,200,200,250), 1, font)

				if isMouseInPosition(screen.x/2+600/2, screen.y/2-325/2, 50, 30) and getKeyState("mouse1") then
					dxDrawRectangle(screen.x/2+600/2, screen.y/2-325/2, 50, 30, tocolor(100,25,25,250))
					dxDrawText('Kapat',screen.x/2+622/2, screen.y/2-320/2, 650, 150, tocolor(200,200,200,250), 1, font)
					Racing.close()
				else
					dxDrawRectangle(screen.x/2+600/2, screen.y/2-325/2, 50, 30, tocolor(100,25,25,200))
					dxDrawText('Kapat',screen.x/2+622/2, screen.y/2-320/2, 650, 150, tocolor(200,200,200,250), 1, font)
				end

				if isMouseInPosition(screen.x/2-575/2, screen.y/2+137/2, 150, 30) and getKeyState("mouse1") then
					dxDrawRectangle(screen.x/2-575/2, screen.y/2+137/2, 150, 30, tocolor(10,10,10,250))
					dxDrawText('Kırmızı',screen.x/2-465/2, screen.y/2+148/2, 650, 150, tocolor(200,200,200,250), 1, font)
					if not active and not finish then
						localPlayer:setData("money", tonumber(localPlayer:getData('money') - 5000))
						selected = 'Kırmızı'
						active = true
					end
				else
					dxDrawRectangle(screen.x/2-575/2, screen.y/2+137/2, 150, 30, tocolor(10,10,10,200))
					dxDrawText('Kırmızı',screen.x/2-465/2, screen.y/2+148/2, 650, 150, tocolor(200,200,200,250), 1, font)
				end

				if isMouseInPosition(screen.x/2-575/2, screen.y/2+200/2, 150, 30) and getKeyState("mouse1") then
					dxDrawRectangle(screen.x/2-575/2, screen.y/2+200/2, 150, 30, tocolor(10,10,10,250))
					dxDrawText('Sarı',screen.x/2-465/2, screen.y/2+211/2, 650, 150, tocolor(200,200,200,250), 1, font)
					if not active and not finish then
						localPlayer:setData("money", tonumber(localPlayer:getData('money') - 5000))
						selected = 'Sarı'
						active = true
					end
				else
					dxDrawRectangle(screen.x/2-575/2, screen.y/2+200/2, 150, 30, tocolor(10,10,10,200))
					dxDrawText('Sarı',screen.x/2-465/2, screen.y/2+211/2, 650, 150, tocolor(200,200,200,250), 1, font)
				end

				if isMouseInPosition(screen.x/2-575/2, screen.y/2+265/2, 150, 30) and getKeyState("mouse1") then
					dxDrawRectangle(screen.x/2-575/2, screen.y/2+265/2, 150, 30, tocolor(10,10,10,250))
					dxDrawText('Mavi',screen.x/2-465/2, screen.y/2+276/2, 650, 150, tocolor(200,200,200,250), 1, font)
					if not active and not finish then
						localPlayer:setData("money", tonumber(localPlayer:getData('money') - 5000))
						selected = 'Mavi'
						active = true
					end
				else
					dxDrawRectangle(screen.x/2-575/2, screen.y/2+265/2, 150, 30, tocolor(10,10,10,200))
					dxDrawText('Mavi',screen.x/2-465/2, screen.y/2+276/2, 650, 150, tocolor(200,200,200,250), 1, font)
				end

				dxDrawText('At yarışına hoşgeldin, burada istediğin bir ata bahis oynayabilir,',screen.x/2-75/2, screen.y/2+100/2, 650, 150, tocolor(200,200,200,250), 1, font)
				dxDrawText('şansın varsa kazanabilirsin, bahis tutarı $5000, kazanırsan eğer $12500 senindir!',screen.x/2-75/2, screen.y/2+130/2, 650, 150, tocolor(200,200,200,250), 1, font)
				dxDrawText('Seçtiğin At: '..selected,screen.x/2-75/2, screen.y/2+180/2, 650, 150, tocolor(200,200,200,250), 1, font)
				dxDrawText('Kazanan At: '..winner,screen.x/2-75/2, screen.y/2+225/2, 650, 150, tocolor(200,200,200,250), 1, font)
				dxDrawText('At Yarışı @sourcelua',screen.x/2-75/2, screen.y/2+410/2, 650, 150, tocolor(200,200,200,250), 1, font)

				if active then
					if redX < maxX then
						redX = redX + math.random(0, 4)
					else
						winner = 'Kırmızı'
						active = false
						finish = true
						Racing.check()
					end

					if yellowX < maxX then
						yellowX = yellowX + math.random(0, 4)
					else
						winner = 'Sarı'
						active = false
						finish = true
						Racing.check()
					end

					if blueX < maxX then
						blueX = blueX + math.random(0, 4)
					else
						winner = 'Mavi'
						active = false
						finish = true
						Racing.check()
					end
				end

				dxDrawImage(screen.x/2-625/2+redX, screen.y/2-255/2, 75, 50, 'components/red.png')
				dxDrawImage(screen.x/2-625/2+yellowX, screen.y/2-155/2, 75, 50, 'components/yellow.png')
				dxDrawImage(screen.x/2-625/2+blueX, screen.y/2-55/2, 75, 50, 'components/blue.png')
			else
				Racing.close()
			end
		end,
	7, 0)
end

Racing.check = function()
	if winner == selected then
		outputChatBox('[!]#D0D0D0 Seçtiğin at kazandı ve $12500 kazandın, iyi şanslar!',195,184,116,true)
		localPlayer:setData("money", tonumber(localPlayer:getData('money') + 12500))
	end
end

Racing.close = function()
	showCursor(false)
	show = false
	killTimer(Racing.render)
end

Racing.constructor()
