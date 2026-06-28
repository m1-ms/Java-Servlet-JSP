 package com.item.service;

import java.util.List;

import com.item.model.Item;
import com.item.model.ItemDetail;

public interface ItemService {
	
	/*
	List<Item> getItems();
	Item getItem(long id);
	void addItem(Item item);
	void updateItem(Item item);
	void deleteItem(long id);
	*/


	
	boolean addItem(Item item);
    boolean updateItem(Item item);
    Item selectItemById(Long id);
    List <Item> getItems();
    boolean removeItemById(Long id);

    
    // Item Details
    ItemDetail getItemDetail(long itemId);
    boolean addItemDetail(ItemDetail itemDetail);
    boolean updateItemDetail(ItemDetail itemDetail);

}