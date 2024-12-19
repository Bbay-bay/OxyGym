package com.GymInfo.OxyGym.dao;

import java.util.List;
import com.GymInfo.OxyGym.bean.Feedback;

public interface FeedbackDao {
	public void saveNewFeedback(Feedback feedback);
    public List<Feedback> displayAllFeedbacks(); 
    public Long generateFeedbackId();
}