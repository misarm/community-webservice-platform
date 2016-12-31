package com.kdev.app.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.kdev.app.domain.Board;
import com.kdev.app.domain.UserVO;

public interface BoardRepository extends JpaRepository<Board, Integer> {
	public Page<Board> findAllByUser(UserVO userVO, Pageable pageable);
	public Page<Board> findAllByCategory(String category, Pageable pageable);
}
