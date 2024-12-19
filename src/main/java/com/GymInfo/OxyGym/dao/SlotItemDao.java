package com.GymInfo.OxyGym.dao;

import java.util.List;
import java.util.Set;
import com.GymInfo.OxyGym.bean.SlotItem;
import com.GymInfo.OxyGym.bean.SlotItemEmbed;

public interface SlotItemDao {
	public void save(SlotItem slotItem);
	public Integer findSeatBookedById(SlotItemEmbed id);
	public Set<SlotItemEmbed> findAllEmbeds();
	public SlotItem findById(SlotItemEmbed embed);
	public List<SlotItem> displayEmptySlots();
	public List<SlotItem> displayBookedSlots();
}