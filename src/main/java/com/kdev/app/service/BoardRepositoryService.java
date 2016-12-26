package com.kdev.app.service;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdev.app.domain.BoardDTO;
import com.kdev.app.domain.BoardVO;
import com.kdev.app.domain.UserVO;
import com.kdev.app.exception.NotCreatedException;
import com.kdev.app.exception.UserNotFoundException;
import com.kdev.app.repository.BoardRepository;

@Service
@Transactional
public class BoardRepositoryService {
	@Autowired
	private BoardRepository boardRepository;
	
	@Autowired 
	ModelMapper modelMapper;
	
	public BoardVO create(BoardDTO.Create createBoard){
		UserVO userVO = createBoard.getUser();
		if(userVO == null)
			throw new UserNotFoundException("Can't Found User");
		
		BoardVO createdBoard = boardRepository.save(modelMapper.map(createBoard, BoardVO.class));
		
		if(createdBoard == null)
			throw new NotCreatedException("Board Not Created");
			
		return createdBoard;
	}
	
	public Page<BoardVO> findByAll(Pageable pageable){
		 return boardRepository.findAll(pageable);
	}
	
	public Page<BoardVO> findAllByUser(UserVO userVO, Pageable pageable){
		return boardRepository.findAllByUser(userVO, pageable);
	}
	
	public BoardVO update(BoardDTO.Update update){
		return boardRepository.saveAndFlush(modelMapper.map(update, BoardVO.class));
	}
	
	public boolean delete(int id){
		try{
			boardRepository.delete(id);
		}catch (IllegalArgumentException e) {
			return false;
		}
		return true;
	}
	
	public BoardVO findOne(int id){
		return boardRepository.findOne(id);
	}
}
