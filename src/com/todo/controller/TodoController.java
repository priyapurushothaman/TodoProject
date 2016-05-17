package com.todo.controller;

import java.util.Date;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.todo.jdo.PMF;
import com.todo.jdo.TodoListJdo;


@Controller
public class TodoController {
	@RequestMapping("/")
	public String homePage() {
		return "index";
	}

	@RequestMapping(value = "/addNotes", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public  String createTodoList(@RequestBody String todoNotes,HttpServletRequest req, ModelMap model )
	{
		System.out.println("begin here");
		PersistenceManager pm = com.todo.jdo.PMF.get().getPersistenceManager();

		JSONParser parser = new JSONParser();
		JSONObject jsonObject = null;
		try {
			jsonObject = (JSONObject) parser.parse(todoNotes);
		}
		catch(Exception e)
		{
			e.printStackTrace();

		}
		String noteFromJson = (String) jsonObject.get("taskNotes");
		System.out.println(noteFromJson);
		
		
		Date date = new Date();
		Date createdOn = date; 
		String status = "inProcess"; 
		Boolean isDeleted = false; 

		
		System.out.println("content"+noteFromJson+"date "+createdOn);
		
		TodoListJdo todolistObj = new TodoListJdo();
		todolistObj.setNotes(noteFromJson);
		todolistObj.setCreatedOn(createdOn);
		todolistObj.setIsDeleted(isDeleted);
		todolistObj.setStatus(status);
		 try {
				pm.makePersistent(todolistObj);
			} finally {
				pm.close();
			}
		
		Gson gson = new Gson();
       
		String jsonData = gson.toJson(todolistObj);
		
		
		System.out.println("JSON Value   "+jsonData);
	    return jsonData;
			}


@SuppressWarnings("unchecked")
@RequestMapping(value = "/getNotes", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
@ResponseBody
public  String getTodoList(@RequestBody String todoNotes,HttpServletRequest req, ModelMap model )
{
	System.out.println("inside getTodoList");
	PersistenceManager pm = com.todo.jdo.PMF.get().getPersistenceManager();

	JSONParser parser = new JSONParser();
	JSONObject jsonObject = null;

		String queryStr = "SELECT FROM " + TodoListJdo.class.getName();
		Query q = pm.newQuery(queryStr);
		List<TodoListJdo> notesList = (List<TodoListJdo>) q.execute();

		Gson gson = new GsonBuilder().create();
		JsonArray valInArray = gson.toJsonTree(notesList).getAsJsonArray();

   
	String jsonData = gson.toJson(valInArray);
	System.out.println("gettot ==="+jsonData);
		
    return jsonData;

}
@RequestMapping(value = "/deleteNote", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
@ResponseBody
public  String deleteTodoList(@RequestBody String noteId,HttpServletRequest req, ModelMap model )
{
	JSONParser parser = new JSONParser();
	JSONObject jsonObject = null;
	try {
		jsonObject = (JSONObject) parser.parse(noteId);
	}
	catch(Exception e)
	{
		e.printStackTrace();

	}
	Long key = (Long) jsonObject.get("noteId");
	System.out.println(key);
	PersistenceManager pm = PMF.get().getPersistenceManager();

	

		TodoListJdo deleteNote = pm.getObjectById(TodoListJdo.class, key);
        //deleteNote.setIsDeleted(true);
        pm.deletePersistent(deleteNote);
        System.out.println("deleted");

    	String jsonData = "success";
    	System.out.println("success / Failed ==="+jsonData);
    	
        return jsonData;
	}

@RequestMapping(value = "/updateNote", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
@ResponseBody
public  String updateTodoList(@RequestBody String noteId,HttpServletRequest req, ModelMap model )
{
	JSONParser parser = new JSONParser();
	JSONObject jsonObject = null;
	try {
		jsonObject = (JSONObject) parser.parse(noteId);
	}
	catch(Exception e)
	{
		e.printStackTrace();

	}
	Long key = (Long) jsonObject.get("noteId");
	String notes = (String) jsonObject.get("notes");

	System.out.println(key);
	System.out.println(notes);

	PersistenceManager pm = PMF.get().getPersistenceManager();

	try {
		TodoListJdo updateObj = pm.getObjectById(TodoListJdo.class, key);
		updateObj.setNotes(notes);
	} finally {
		pm.close();
	}

        System.out.println("updated");

    	String jsonData = "success";
    	System.out.println("success / Failed ==="+jsonData);
    	
        return jsonData;
	}

}
