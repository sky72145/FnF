package store.fnfm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import store.fnfm.service.ProductsService;
import store.fnfm.vo.Criteria;
import store.fnfm.vo.Criteria2;
import store.fnfm.vo.Criteria3;
import store.fnfm.vo.PageDTO;
import store.fnfm.vo.PageDTO2;
import store.fnfm.vo.PageDTO3;
import store.fnfm.vo.PageDTO4;
import store.fnfm.vo.PageDTO5;

@Controller
public class ProductsController {
	@Autowired
	private ProductsService service;
	
	@GetMapping("/products")
	public void products(Criteria cri, Model model) {
	
		model.addAttribute("products",service.products(cri));
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker",new PageDTO(cri, total));
		model.addAttribute("productsf",service.productsf());
	}
	@GetMapping("/products2")
	public void products2(Criteria2 cri2, Model model) {
		
		model.addAttribute("products2",service.products2(cri2));
		int total = service.getTotal2(cri2);
		
		model.addAttribute("pageMaker2",new PageDTO2(cri2, total));
		model.addAttribute("productsf",service.productsf());
	}
	
	@GetMapping("/productc")
	public void productc(Criteria3 cri3,Model model) {
		
		model.addAttribute("productc",service.productc(cri3));
		int total = service.getTotal4(cri3);
		
		model.addAttribute("pageMaker4",new PageDTO4(cri3, total));
		model.addAttribute("productsf",service.productsf());
	}
	@GetMapping("/productf")
	public void productf(Criteria3 cri3,Model model) {
		
		model.addAttribute("productf",service.productf(cri3));
		int total = service.getTotal3(cri3);
		
		model.addAttribute("pageMaker4",new PageDTO4(cri3, total));
		model.addAttribute("productsf",service.productsf());
	}
	@GetMapping("/productc2")
	public void productc2(Criteria cri, Model model) {
		
		model.addAttribute("productc2",service.productc2(cri));
		int total = service.getTotal5(cri);
		
		model.addAttribute("pageMaker3",new PageDTO5(cri, total));
		model.addAttribute("productsf",service.productsf());
	}
	@GetMapping("/productf2")
	public void productf2(Criteria cri, Model model) {
		
		model.addAttribute("productf2",service.productf2(cri));
		int total = service.getTotal(cri);
		
		model.addAttribute("pageMaker3",new PageDTO3(cri, total));
		model.addAttribute("productsf",service.productsf());
	}
}
