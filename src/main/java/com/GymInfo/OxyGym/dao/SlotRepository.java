package com.GymInfo.OxyGym.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import com.GymInfo.OxyGym.bean.Slot;

public interface SlotRepository extends JpaRepository<Slot, Long> {
  @Query("select max(slotId) from Slot")
  public Long findLastSlotId();
}