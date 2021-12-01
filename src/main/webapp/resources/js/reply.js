console.log('reply.js 실행됨?')
var replyService = (function () {
  function add(reply, callback, error) {
    //댓글 추가하는 함수
    console.log('리플 추가......')
    // 공부할것 메모용
    // 콜백함수는 객체의 이벤트가 발생하였을경우에 함수를통해 전달하는것
    $.ajax({
      type: 'post',
      url: 'replies/new',
      data: JSON.stringify(reply),
      contentType: 'application/json; charset=utf-8',
      success: function (result, status, xhr) {
        if (callback) {
          callback(result)
        }
      },
      error: function (xhr, status, er) {
        if (error) {
          error(er)
        }
      },
    })
  }
  return {
    add: add,
  }
  function getList(param, callback, error) {
    // 목록조회하는함수
    var bno = param.bno
    var page = param.page || 1

    $.getJSON('/replies/pages' + bno + '/' + page + '.json', function (data) {
      if (callback) {
        callback(data)
      }
    }).fail(function (xhr, status, err) {
      if (error) {
        error()
      }
    })
    return {
      add: add,
      getList: getList,
    }
  }
  function update(reply, callback, error) {
    //댓글 수정기능
    console.log('댓글수정' + reply.rno)
    $.ajax({
      type: 'put',
      url: '/replies/' + reply.rno,
      data: JSON.stringify(reply),
      contentType: 'application/json; charset=utf-8',
      success: function (result, status, xhr) {
        if (callback) {
          callback(result)
        }
      },
      error: function (xhr, status, er) {
        if (error) {
          error(er)
        }
      },
    })
    return {
      add: add,
      getList: getList,
      update: update,
    }
  }
  function remove(reply, callback, error) {
    //ㄷ새글삭제기능
    console.log('댓긄삭제' + reply.rno)
    $.ajax({
      type: 'delete',
      url: '/replies/' + rno,
      data: JSON.stringify(reply),
      success: function (deleteResult, status, xhr) {
        if (callback) {
          callback(deleteResult)
        }
      },
      error: function (xhr, status, er) {
        if (error) {
          error(er)
        }
      },
    })
    return {
      add: add,
      getList: getList,
      update: update,
      remove: remove,
    }
  }
  function get(rno, callback, error) {
    //특정댓글조회하는거

    $.getJSON('/replies/' + rno + '/' + '.json', function (result) {
      if (callback) {
        callback(result)
      }
    }).fail(function (xhr, status, err) {
      if (error) {
        error()
      }
    })
    return {
      add: add,
      getList: getList,
      update: update,
      remove: remove,
      get: get,
    }
  }
  function displayTime(timeValue) {
    var today = new Date()
    var gap = today.getTime() - timeValue
    var dateObj = new Date(timeValue)
    var str = ''
    if (gap < 1000 * 60 * 60 * 24) {
      //하루보다 작으면, 오늘날짜는 시간으로
      var hh = dateObj.getHours()
      var mi = dateObj.getMinutes()
      var ss = dateObj.getSeconds()
      return [(hh > 9 ? '' : '0') + hh, (mi > 9 ? '' : '0') + mi, (ss > 9 ? '' : '0') + ss].join(':') //배열에서 하나씩 꺼내서 문자열 생성  , 결합(join) 은 ":"  로 결합해라
    } else {
      //하루 지난시간
      var yy = dateObj.getFullYear()
      var mm = dateObj.getMonth() + 1 // getMonth는 0부터 시작
      var dd = dateObj.getDate()
      return [yy, (mm > 9 ? '' : '0') + mm, (dd > 9 ? '' : '0') + dd].join('/')
    }
  }
  return {
    add: add,
    getList: getList,
    update: update,
    remove: remove,
    get: get,
    displayTime: displayTime,
  }
})()
