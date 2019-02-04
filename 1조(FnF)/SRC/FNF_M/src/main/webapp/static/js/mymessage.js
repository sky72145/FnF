console.log("Message Module.....");

var messageService = (function(){
	function add(message, callback, error){
		console.log("add reply");
		$.ajax({
			type : 'POST',
			url : '/MyMessagecreate',
			data : JSON.stringify(message),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr){
				if (callback){
					callback(result);
				}
			},
			error : function(xhr, status, er){
				if (error){
					error(er);
				}
			}
		})
	}
	function getsedList(param,callback,error){
		console.log('send')
		var send_id = param.send_id;
		var page = param.page || 1;
		$.getJSON("/Mysendview/"+send_id+"/"+page+".json",
				function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	function getrecList(param,callback,error){
		console.log('receive')
		var receive_id = param.receive_id;
		var page = param.page || 1;
		$.get("/Myreceiveview/"+receive_id+"/"+page+".json",
				function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	function removesed(idx, callback, error){
		$.get("/MyDeletesedView/"+idx+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status,err){
			if(error){
				error();
			}
		});
	}
	function removerec(idx, callback, error){
		$.get("/MyDeleterecView/"+idx+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status,err){
			if(error){
				error();
			}
		});
	}
	function getsed(idx, callback, error){
		$.get("/MysendMessageview/"+idx+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status,err){
			if(error){
				error();
			}
		});
	}
	function getrec(idx, callback, error){
		$.get("/MyrecMessageview/"+idx+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status,err){
			if(error){
				error();
			}
		});
	}
	return{ 
		add : add,
		getsedList : getsedList,
		getrecList : getrecList,
		removesed : removesed,
		removerec : removerec,
		getsed : getsed,
		getrec : getrec
		};
})();