// Main JavaScripts

(function ($) {
	'use strict';
	
	// Side Nav
	function sideNav() {
		$('.side-nav .side-nav-menu li a').on('click', function(e) {
			if ($(this).parent().hasClass("open")) {

				$(this).parent().children('.dropdown-menu').slideUp(200, function() {
					$(this).parent().removeClass("open");
				});

			} else {
				$(this).parent().parent().children('li.open').children('.dropdown-menu').slideUp(200);
				$(this).parent().parent().children('li.open').children('a').removeClass('open');
				$(this).parent().parent().children('li.open').removeClass("open");
				$(this).parent().children('.dropdown-menu').slideDown(200, function() {
					$(this).parent().addClass("open");
				});
			}
		});
	}	
	
	// Side Nav Toogle
	function sideNavToggle() {
		$('.side-nav-toggle').on('click', function(e) {
	        $('.app').toggleClass("is-collapsed");
	        e.preventDefault();
	    });
	}	

	// Side Panel Toogle
	function sidePanelToggle() {
		$('.side-panel-toggle').on('click', function(e) {
	        $('.side-panel').toggleClass("side-panel-open");
	        e.preventDefault();
	    });
	}	

	// Chat Toggle
	function chatToggle() {
		$('.chat-toggle').on('click', function(e) {
	        $('.chat').toggleClass("open");
	        e.preventDefault();
	    });
	}	

	// Todo Toggle
	function todoToggle() {
		$('.todo-toggle').on('click', function(e) {
	        $('.todo-wrapper').toggleClass("open");
	        e.preventDefault();
	    });
	}	

	// Search Toggle 
	function searchToggle() {
		$('.search-toggle').on('click', function(e) {
			$('.search-box, .search-input').toggleClass("active");
			$('.search-input input').focus();
			e.preventDefault();
		});
	}	

	// Advance Search
	function advanceSearch() {
		$('.search-input input').on('keyup',function(){
			if($(this).val().length > 0) {
				$('.advanced-search').addClass("active");
			} 
			else {
		       $('.advanced-search').removeClass("active");
		    }
		    $('.serach-text-bind').html($(this).val());
		})	
	} 

	// Theme Configurator
	function themeConfig() {
		$('.theme-toggle, .config-close').on('click', function(e) {
	        $('.theme-configurator').toggleClass("theme-config-open");
	        e.preventDefault();
	    });
	}	

	// Perfect Scroll Bar
	function perfectSB() {
		$('.scrollable').perfectScrollbar();
	}

	//Card Portlet Refresh
	function cardPortletCtrl() {

		//card refresh
		$('[data-toggle=card-refresh]').on('click',function(e) {
			var cardRefreshSelector = $(this).parents('.card');
		    cardRefreshSelector.addClass('card-refresh');
		    window.setTimeout(function () {
		        cardRefreshSelector.removeClass('card-refresh');
		    }, 2000);
		    e.preventDefault();
		    e.stopPropagation();
		});

		//card delete
		$('[data-toggle=card-delete]').on('click',function(e) {
			var cardDeleteSelector = $(this).parents('.card');
		    cardDeleteSelector.addClass('animated zoomOut');
		    cardDeleteSelector.bind('animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd', function () {
		        cardDeleteSelector.remove();
		    });
		    e.preventDefault();
		    e.stopPropagation();
		});
	}

	//Theme Config 
	function themeColorConfig() {

		$(".header-default input").change(function() {
            $('.app').removeClass("header-primary header-info header-success header-danger header-dark");
		})

		$(".header-info input").change(function() {
		    $('.app').addClass("header-info")
            $('.app').removeClass("header-primary header-success header-danger header-dark");
		});

		$(".header-primary input").change(function() {
		    $('.app').addClass("header-primary")
            $('.app').removeClass("header-info header-success header-danger header-dark");
		});

		$(".header-success input").change(function() {
		    $('.app').addClass("header-success")
            $('.app').removeClass("header-info header-primary header-danger header-dark");
		});

		$(".header-danger input").change(function() {
		    $('.app').addClass("header-danger")
            $('.app').removeClass("header-info header-primary header-success header-dark");
		});

		$(".header-dark input").change(function() {
		    $('.app').addClass("header-dark")
            $('.app').removeClass("header-info header-primary header-success header-danger");
		});

		$(".theme-colors.side-nav-dark input").change(function() {
		    $('.app').addClass("side-nav-dark")
            $('.app').removeClass("side-nav-default");
		});

		$(".theme-colors.sidenav-default input").change(function() {
		    $('.app').addClass("side-nav-default")
            $('.app').removeClass("side-nav-dark");
		});

		$('#rtl-toogle').on('click', function(e) {
	        $('.app').toggleClass("rtl");
	        e.preventDefault();
	    });
	}	



	function init() {
	    sideNav();
	    sideNavToggle();
	    sidePanelToggle();
	    chatToggle();
	    todoToggle();
	    searchToggle();
	    advanceSearch();
	    themeConfig();
	    perfectSB();
	    cardPortletCtrl();
	    themeColorConfig();
	}
	init();
})(jQuery);