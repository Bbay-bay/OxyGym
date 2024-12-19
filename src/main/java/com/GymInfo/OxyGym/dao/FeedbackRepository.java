package com.GymInfo.OxyGym.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import com.GymInfo.OxyGym.bean.Feedback;

public interface FeedbackRepository extends JpaRepository<Feedback , Long> {
	@Query("select max(fId) from Feedback")
	  public Long findLastFeedbackId();

}