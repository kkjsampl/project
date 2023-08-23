package com.example.demo.product.service;

import java.io.*;
import java.util.*;

import org.apache.commons.io.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.web.multipart.*;

import com.example.demo.product.dao.*;
import com.example.demo.product.dto.*;
import com.example.demo.product.entity.*;

@Service
public class ProductAdminService {
	@Autowired
	private ProductDao productDao;
	@Autowired
	private ImageDao imageDao;
	@Autowired
	private ReviewDao reviewDao;
	@Value("${imageFolder}")
	private String imageFolder;
	@Value("${imageUrl}")
	private String imageUrl;
	
	public Long add(ProductDto.Create dto) {
		Product product = new Product(null, dto.getVendor(), dto.getName(), dto.getInfo(), dto.getPrice(), 0L, 0L, 0L);
		productDao.save(product);
		
		List<MultipartFile> images = dto.getImages();
		int index=1;
		for(int i=0; i<images.size(); i++) {
			if(images.get(i).isEmpty()==false) {
				String ext = FilenameUtils.getExtension(images.get(i).getOriginalFilename());
				String fileName = imageUrl + product.getPno() + "-" + (index++)  + "." + ext;
				Image image = new Image(product.getPno(), fileName);
				File file = new File(imageFolder, fileName);
				imageDao.save(image);
				try {
					images.get(i).transferTo(file);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		return product.getPno();
	}

	@Transactional
	public Boolean delete(Long pno) {
		reviewDao.deleteByPno(pno);
		productDao.deleteById(pno);
		List<Image> images = imageDao.findByPno(pno);
		for(Image i:images) {
			File file = new File(imageFolder, i.getName());
			if(file.exists())
				file.delete();
		}
		imageDao.deleteByPno(pno);
		return true;
	}
}
