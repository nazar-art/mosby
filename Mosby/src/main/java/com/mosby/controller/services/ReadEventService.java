package main.java.com.mosby.controller.services;

import java.util.ArrayList;
import java.util.List;

import main.java.com.mosby.controller.dao.ReflectionDao;
import main.java.com.mosby.model.Event;
import main.java.com.mosby.model.EventCategorie;
import main.java.com.mosby.model.EventType;

public class ReadEventService {
	
	public List<EventCategorie> readCategories (){
		List<EventCategorie> list = new ArrayList<>();
		ReflectionDao<EventCategorie> eventCatregoriesDao = new ReflectionDao<>((Class<EventCategorie>) EventCategorie.class);
		list = eventCatregoriesDao.selectObjects("", null);
		return list;
	}
	
	public List<EventType> readTypes (){
		List<EventType> list = new ArrayList<>();
		ReflectionDao<EventType> eventTypeDao = new ReflectionDao<>((Class<EventType>) EventType.class);
		list = eventTypeDao.selectObjects("", null);
		return list;
	}
	
	public List<Event> readEventList (){
		List<Event> list = new ArrayList<>();
		ReflectionDao<Event> eventDao = new ReflectionDao<>((Class<Event>) Event.class);
		list = eventDao.selectObjects("", null);
		return list;
	}
}
