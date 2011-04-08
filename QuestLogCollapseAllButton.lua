-- AllButton click behavior
function QuestLogCollapseAllButton_OnClick(self)
	if (self.collapsed) then
		self.collapsed = nil;
		ExpandQuestHeader(0);
	else
		self.collapsed = 1;
		CollapseQuestHeader(0);
	end
end

-- Move QuestLogCount position
hooksecurefunc("QuestLog_UpdateQuestCount", function(self)
	local dailyQuestsComplete = GetDailyQuestsCompleted();
	local parent = QuestLogCount:GetParent();

	if ( dailyQuestsComplete > 0 ) then
		QuestLogCount:SetPoint("TOPLEFT", parent, "TOPLEFT", 140, -38);
	else
		QuestLogCount:SetPoint("TOPLEFT", parent, "TOPLEFT", 140, -41);
	end
end)

-- display + when collapsed all and display - when expanded all
hooksecurefunc("QuestLog_Update", function(self)
	local numEntries, numQuests = GetNumQuestLogEntries();
	
	-- Set the expand/collapse all button texture
	local numHeaders = 0;
	local notExpanded = 0;
	-- Somewhat redundant loop, but cleaner than the alternatives
	for i=1, numEntries, 1 do
		local index = i;
		local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed = GetQuestLogTitle(i);
		if ( questLogTitleText and isHeader ) then
			numHeaders = numHeaders + 1;
			if ( isCollapsed ) then
				notExpanded = notExpanded + 1;
			end
		end
	end
	-- If all headers are not expanded then show collapse button, otherwise show the expand button
	if ( notExpanded ~= numHeaders ) then
		QuestLogCollapseAllButton.collapsed = nil;
		QuestLogCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
	else
		QuestLogCollapseAllButton.collapsed = 1;
		QuestLogCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
	end
end)
