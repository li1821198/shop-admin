package com.fh.shop.admin.controller;


import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.Product;
import com.fh.shop.admin.util.AliyunOSSUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("uploadFile/")
public class UploadFile {

	/**
     * 图片文件上传
     */

    //上传商品图片
    @RequestMapping("uploadFile")
    @ResponseBody
    public ServerResponse uploadFile(@RequestParam("image") MultipartFile image, HttpServletRequest request){



		String originalFileName = image.getOriginalFilename();
		try {

			String url = AliyunOSSUtil.uploadFile(image.getInputStream(), originalFileName);
			return ServerResponse.success(url);
		} catch (IOException e) {
			e.printStackTrace();
			return  ServerResponse.error();
		}



    }



	//上传商品图片
	@RequestMapping("uploadFile1")
	@ResponseBody
	public ServerResponse uploadFile1( @RequestParam("image") MultipartFile image, HttpServletRequest request ){




		String originalFileName = image.getOriginalFilename();

		try {



			String url = AliyunOSSUtil.uploadFile(image.getInputStream(), originalFileName);
			return ServerResponse.success(url);
		} catch (IOException e) {
			e.printStackTrace();
			return  ServerResponse.error();
		}}

    /**
	 * <pre>copyFile(上传文件时的文件复制)   
	 * @return</pre>
	 */
	public static String upload(InputStream fis, String fileName, String folderPath,HttpServletRequest request) {
		String realPath = request.getServletContext().getRealPath("/");
		// 上传物理文件到服务器硬盘
		
		BufferedInputStream bis = null;
		FileOutputStream fos = null;
		BufferedOutputStream bos = null;
		String uploadFileName = null;
		String path = realPath+folderPath;
		try {
			
			// 构建输入缓冲区，提高读取文件的性能
			bis = new BufferedInputStream(fis);
			// 自动建立文件夹
			File folder = new File(path);
			
			if (!folder.exists()) {
				folder.mkdirs();
			}
			// 为了保证上传文件的唯一性，可以通过uuid来解决
			// 为了避免中文乱码问题则新生成的文件名为uuid+原来文件名的后缀
			uploadFileName = UUID.randomUUID().toString()+getSuffix(fileName);
			// 构建写文件的流即输出流
			fos = new FileOutputStream(new File(path+"/"+uploadFileName));
			// 构建输出缓冲区，提高写文件的性能
			bos = new BufferedOutputStream(fos);
			// 通过输入流读取数据并将数据通过输出流写到硬盘文件中
			byte[] buffer = new byte[4096];// 构建4k的缓冲区
			int s = 0;
			while ((s=bis.read(buffer)) != -1) {
				bos.write(buffer, 0, s);
				bos.flush();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (bos != null) {
				try {
					bos.close();
					bos = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			if (fos != null) {
				try {
					fos.close();
					fos = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			if (bis != null) {
				try {
					bis.close();
					bis = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			if (fis != null) {
				try {
					fis.close();
					fis = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
		}
		return folderPath+"/"+uploadFileName;
	}
	
	/**
	 * <pre>getSuffix(获取后缀名)   
	 * @param fileName
	 * @return</pre>
	 */
	private static String getSuffix(String fileName) {
		int index = fileName.lastIndexOf(".");
		String suffix = fileName.substring(index);
		return suffix;
	}
    
}
