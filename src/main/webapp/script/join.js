// 프사를 선택하면 사진을 출력하는 코드 : 그냥 복붙해서 사용
function showProfile() {
  const profile = $('#profile')[0].files[0];
  // document.querySelector('#profile').files[0] 
  
  // <input type='file' id='profile'>
  // const profile = document.querySelector('#profile')이라고 선택하면
  // 파일 input요소를 찍어보면 files라는 속성이 선택한 파일들의 배열이다(사진을 여러장 선택 가능)
  // 보통은 사진은 한번에 1장씩 선택한다 -> files[0]
  
  // jQuery는 JS로 선택한 요소에 양념한 것인다
  // $('#profile')이라고 하면 #profile 요소를 가져와서 jQuery 기능을 추가한 객체이다
  // jQuery 객체가 가진 html요소에는 [0]이라고 접근하다
  
  const maxSize = 1024*1024;
  if(profile.size>maxSize) {
    alert('사진 크기는 1MB이하여야 합니다');
    $('#profile')[0].files[0] = '';
  }
  // 파일리더 객체의 기본 작업대상은 this
  let reader = new FileReader();
  // 파일을 로딩했을 때 동작할 콜백함수 지정
  reader.onload = function() {
    $('#show-profile').css('display','inline').attr('src', reader.result);
  }
  // 파일을 로딩한다
  reader.readAsDataURL(profile);
}

async function usernameCheck() {
  const pattern = /^[a-z0-9]{6,10}$/
  $('#username-msg').text('');
  const username = $('#username').val();
  if(username==='') {
    $('#username-msg').text('아이디를 입력하세요').attr('class','fail');
    return false;
  }  
  if(pattern.test(username)===false) {
    $('#username-msg').text('아이디는 영숫자 6~10자입니다').attr('class','fail');
    return false;
  }
  try {
    await $.ajax('/member/username/available/' + username);
    return true;
  } catch(err) {
    console.log(err);
    $('#username-msg').text('사용중인 아이디입니다').attr('class','fail');
    return false;
  }
}

function passwordCheck() {
  $('#password-msg').text('');
  const pattern = /^[A-Za-z0-9]{8,10}$/;
  const password= $('#password').val();
  if(password==='') {
    $('#password-msg').text('비밀번호를 입력하세요').attr('class','fail');
    return false;
  }
  if(pattern.test(password)===false) {
    $('#passowrd-msg').text('비밀번호는 영숫자 8~10자입니다').attr('class','fail');
    return false;
  }
  return true;
}

function emailCheck() {
  const pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
  $('#email-msg').text('');
  const email= $('#email').val();
  if(email==='') {
    $('#email-msg').text('이메일을 입력하세요').attr('class','fail');
    return false;
  }
  if(pattern.test(email)===false) {
    $('#email-msg').text('이메일을 올바르게 입력하세요').attr('class','fail');
    return false;
  }  
  return true;
}

function birthdayCheck() {
  $('#birthday-msg').text('');
  const birthday= $('#birthday').val();
  if(birthday==='') {
    $('#birthday-msg').text('생일을 입력하세요').attr('class','fail');
    return false;
  }
  return true;
}


$(document).ready(function() {
   $('#profile').on('change', showProfile);
  
   $('#username').on('blur', usernameCheck);
   $('#password').on('blur', passwordCheck);
   $('#email').on('blur', emailCheck);
   $('#birthday').on('blur', birthdayCheck);

   
   $('#join').on('click', async function() {
     let 조건체크 = await usernameCheck();
     console.log(조건체크);
     조건체크 = passwordCheck() && 조건체크;
     console.log(조건체크);
     조건체크 = emailCheck() && 조건체크;
     console.log(조건체크);
     조건체크 = birthdayCheck() && 조건체크;
     console.log(조건체크);
     if(조건체크===true)
       $('#join-form').submit();
   });
})

