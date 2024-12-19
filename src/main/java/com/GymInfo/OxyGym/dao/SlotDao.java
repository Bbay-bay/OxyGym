package com.GymInfo.OxyGym.dao;

import java.util.List;
import com.GymInfo.OxyGym.bean.Slot;

public interface SlotDao {
    public void saveNewSlot(Slot slot);
    public List<Slot> displayAllSlots();
    public Slot findSlotById(Long id);
    public void updateSlot(Slot slot);
    public Long generateSlotId();
    
}