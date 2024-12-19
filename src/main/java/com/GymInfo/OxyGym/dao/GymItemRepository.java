package com.GymInfo.OxyGym.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import com.GymInfo.OxyGym.bean.GymItem;

public interface GymItemRepository extends JpaRepository<GymItem, Long> {
	@Query("select max(itemId) from GymItem")
	public Long findLastItemId();
	
	@Query("select totalSeat from GymItem where itemId=?1")
	public Integer findTotalSeatById(Long id);
}