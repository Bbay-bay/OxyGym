package com.GymInfo.OxyGym.dao;

import java.util.List;
import com.GymInfo.OxyGym.bean.GymBook;

public interface GymBookDao {
 public void save(GymBook gymBook);
 public Long generateBookingId();
 public List<GymBook> getBookList();
 public GymBook findBookInfoById(Long id);
 public void deleteById(Long id);
public List<GymBook> getBookingByUsername(String username);
public boolean isSlotBooked(Long slotId, String username);

}