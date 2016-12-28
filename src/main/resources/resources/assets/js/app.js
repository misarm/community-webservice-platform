var app = angular.module('myApp', ['angularUtils.directives.dirPagination']);

app.directive('krInput', [ '$parse', function($parse) {
    return {
        priority : 2,
        restrict : 'A',
        compile : function(element) {
            element.on('compositionstart', function(e) {
                e.stopImmediatePropagation();
            });
        },
    };
} ]);

app.controller('BoardController', function($scope, $http, $log){
	$scope.pagesize = 5;
	$scope.totalElements = 0;
	
	$scope.updateModel = function (data){
		$scope.boardContents = data;
	}
	$scope.parseJson = function (json) {
        return JSON.parse(json);
    }
	$scope.move = function (value){
		location.href="/board/"+value;
	}
	$scope.pageChange = function(page){
		getInformation('',page,$scope.pagesize);
	}
	
	getInformation('',0,$scope.pagesize);
});

app.controller('DetailController', function($scope, $http, $log){
	$scope.updateModel = function (data){
		$scope.boardContent = data;
	}
	$scope.parseJson = function (json) {
        return JSON.parse(json);
    }
	$scope.requestBoardDelete = function (){
		$.ajax({
			type	: 'DELETE',
			url		: '/board/'+$scope.boardContent.id,
			dataType	: 'JSON',
			success	: function(response){
				Materialize.toast("정상적으로 삭제되었습니다.", 3000);
				location.href="/";
			},
			error	: function(response){
				console.log(response);
				alert("오류가 발생하였습니다.", 3000);
			}
		});
	}
	$scope.requestBoardUpdate = function(){
		$('#u_b_description').val($scope.boardContent.description);
		$('#u_b_title').val($scope.boardContent.title);
		var tags = JSON.parse($scope.boardContent.tags);
		$('#u_b_tags').tagging( "reset" );
		$('#u_b_tags').tagging("add",tags);
		Materialize.updateTextFields();
		$("#updateBoardModal").modal('open');
		$("#updateBoardBtn").attr('onclick', '').unbind('click'); 
		$("#updateBoardBtn").attr('onclick', '').click(function(){
			updateBoard($scope.boardContent);
		});
	}
	$scope.requestDeleteComment = function(comment){
		$.ajax({
			type	: 'DELETE',
			url		: '/comment/'+comment.id,
			dataType	: 'JSON',
			success	: function(response){
				Materialize.toast("정상적으로 삭제되었습니다.", 3000);
				var index = $scope.boardContent.comments.indexOf(comment);
				$scope.boardContent.comments.splice(index, 1);
				$scope.$apply();
			},
			error	: function(response){
				console.log(response);
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	$scope.requestUpdateComment = function(comment, index){
		//모달로 변경합시다.
		$('#u_c_description').val(comment.description);
		var tags = JSON.parse(comment.tags);
		$('#u_c_tags').tagging( "reset" );
		$('#u_c_tags').tagging("add",tags);
		Materialize.updateTextFields();
		$('#updateCommentModal').modal('open');
		$("#updateCommentBtn").attr('onclick', '').unbind('click'); 
		$("#updateCommentBtn").attr('onclick', '').click(function(){
			updateComment(comment, index);
		});
	}
	$scope.selectedComment = function(comment, index){
		var BoardObject = new Object();
		BoardObject.title = $scope.boardContent.title;
		BoardObject.description = $scope.boardContent.description;
		BoardObject.tags = $scope.boardContent.tags;
		BoardObject.id = $scope.boardContent.id;
		BoardObject.category = $scope.boardContent.category;
		BoardObject.selected = comment.id;

		$.ajax({
			type	: 'POST',
			url		: '/board/'+$scope.boardContent.id,
			data 	: JSON.stringify(BoardObject),
			contentType: 'application/json',
			dataType	: 'JSON',
			success	: function(response){
				Materialize.toast("정상적으로 선택되었습니다.", 3000);
				$scope.boardContent = response;
				$scope.$apply();
			},
			error	: function(response){
				console.log(response);
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
});

function getInformation(value, page, size){
	var scope = angular.element(document.getElementById("BoardController")).scope();
	var dataObject = {
		category : 	value,
		page : page,
		size : size,
	};
	
	$.ajax({
		type	: 'GET',
		url		: '/board',
		data	: dataObject,
		dataType	: 'JSON',
		success	: function(response){
			console.log(response);
			if(response != "" && response != null){
				scope.$apply(function () {
					scope.totalElements = response.totalElements;
					scope.updateModel(response.content);
				});
			}
		},
		error	: function(response){
			alert("오류");
		}
	});
}

function getBoardDetail(value){
	var scope = angular.element(document.getElementById("DetailController")).scope();
	$.ajax({
		type	: 'GET',
		url		: '/board/'+value,
		dataType	: 'JSON',
		success	: function(response){
			console.log(response);
			if(response != "" && response != null){
				scope.$apply(function () {
					scope.updateModel(response);
				});
			}
		},
		error	: function(response){
			alert("오류");
		}
	});
}

function comment(board){
	$('#preloader').show();
	var CommentObject = new Object();
	CommentObject.description = $('#c_description').val();
	CommentObject.tags = JSON.stringify($('#c_tags').tagging("getTags"));
	CommentObject.boardid = board;
	$.ajax({
		type	: 'POST',
		url		: '/comment',
		data	: JSON.stringify(CommentObject),
		contentType: 'application/json',
		dataType	: 'JSON',
		success	: function(response){
			$('#c_description').val("");
			$('#c_tags').material_chip({
				data:null
			});
			Materialize.updateTextFields();
			var scope = angular.element(document.getElementById("DetailController")).scope();
			scope.$apply(function () {
				scope.boardContent.comments.push(response);
			});
		},
		error : function(response){
			console.log(response);
			alert("오류");
    		}
    	});
	$('#preloader').hide();
}
function updateComment(comment, index){
	$('#preloader').show();
	var CommentObject = new Object();
	
	CommentObject.description = $('#u_c_description').val();
	CommentObject.tags = JSON.stringify($('#u_c_tags').tagging("getTags"));
	CommentObject.id = comment.id;
	CommentObject.boardid = comment.boardid;
	$.ajax({
		type	: 'POST',
		url		: '/comment/'+comment.id,
		data	: JSON.stringify(CommentObject),
		contentType: 'application/json',
		dataType	: 'JSON',
		success	: function(response){
			
			var scope = angular.element(document.getElementById("DetailController")).scope();
			scope.$apply(function () {
				scope.boardContent.comments[index] = response;
				resetUpdateCommentForm();
				$('#updateCommentModal').modal('close');
			});
		},
		error : function(response){
			console.log(response);
			alert("오류");
    		}
    	});
	$('#preloader').hide();
}
function resetUpdateCommentForm(){
	$('#u_c_description').val('');
	$('#u_c_tags').tagging( "reset" );
	Materialize.updateTextFields();
}
function updateBoard(board){
	$('#preloader').show();
	var BoardObject = new Object();
	BoardObject.title = $('#u_b_title').val();
	BoardObject.description = $('#u_b_description').val();
	BoardObject.tags = JSON.stringify($('#u_b_tags').tagging("getTags"));
	BoardObject.id = board.id;
	BoardObject.category = board.category;
	BoardObject.selected = board.selected;
	$.ajax({
		type	: 'POST',
		url		: '/board/'+board.id,
		data	: JSON.stringify(BoardObject),
		contentType: 'application/json',
		dataType	: 'JSON',
		success	: function(response){
			location.reload();
		},
		error : function(response){
			console.log(response);
			alert("오류");
    		}
    	});
	$('#preloader').hide();
}
function resetUpdateBoardForm(){
	$('#u_b_description').val('');
	$('#u_b_tags').tagging( "reset" );
	Materialize.updateTextFields();
}

