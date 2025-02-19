<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>mypage</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
     <script>
        $(function() {
            $("#editBtn").on("click", function() {
                $("input.editable").removeAttr("readonly"); // �ʵ� ���� �����ϰ�
                $("#findPostcode").show();
                $("#backBtn, #editBtn").hide(); // ���� ��ư �����

                let submitBtn = $("<button>").attr("type", "submit")
                    .text("�����Ϸ�").css("margin-right", "5px");
                let btnCancel = $("<button>").attr("type", "button").text("���");
                btnCancel.on("click", function() {
                    location.reload();
                });
                $("#btn1").append(submitBtn);
                $("#btn2").append(btnCancel);
            });
        });

        function openPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    $("#postcode").val(data.zonecode); 
                    $("#address").val(data.roadAddress); 
                    $("#detail_address").focus(); 
                }
            }).open();
        }
    </script>
</head>
<body>
    ${member.name}�� ȯ���մϴ�!
    <form action="/member/update.do" method="post">
        <table border="1" align="center">
            <tr>
                <th>���̵�</th>
                <th>�̸�</th>
                <th>�г���</th>
                <th>�ֹι�ȣ</th>
                <th>�̸���</th>
                <th>��ȭ��ȣ</th>
                <th>�����ȣ</th>
                <th>�ּ�</th>
                <th>���ּ�</th>
                <th>����</th>
                <th>������</th>
            </tr>
            <tr>
                <td>${member.id}<input type="hidden" name="id" value="${member.id}"></td>
                <td>${member.name}</td>
                <td><input type = "text" name = "nickname" value = "${member.nickName}" readonly class = "editable"></td>
                <td>${member.ssn}</td>
                <td><input type="email" name="email" value="${member.email}" readonly class="editable"></td>
                <td><input type="text" name="phone" value="${member.phone}" readonly class="editable"></td>
                <td><input type="text" name="postcode" id = "postcode" value="${member.zipCode}" readonly class="editable">
                   <button type="button" id="findPostcode" style="display: none;" onclick="openPostcode()">ã��</button>
                <td>${member.address}</td>
                <td><input type="text" name="detail_address" id = "detail_address" value="${member.detailAddress}" readonly class="editable"></td>
                <td>${member.role}</td>
                <td>${member.regDate}</td>
            </tr>
            <tr>
                <td colspan="5" align="center" id="btn1">
                    <button type="button" id="editBtn">ȸ������ ����</button>
                </td>
                <td colspan="5" align="center" id="btn2">
                    <button type="button" id="backBtn">�ڷΰ���</button>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>