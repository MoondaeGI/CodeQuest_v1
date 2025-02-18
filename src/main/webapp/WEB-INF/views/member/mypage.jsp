<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>mypage</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(function() {
            $("#editBtn").on("click", function() {
                $("input.editable").removeAttr("readonly");
                $("#findPostcode").show();
                $("#backBtn, #editBtn").hide();
                let submitBtn = $("<button>").attr("type", "submit")
                    .text("�����Ϸ�").css("margin-right", "5px");
                let btnCancel = $("<button>").attr("type", "button").text("���");
                btnCancel.on("click", function() {
                    location.reload();
                });
                $("#btn1").append(submitBtn);
                $("#btn2").append(btnCancel);
            })
        });

        function searchPostcode() {
            // �����ȣ ã�� ���� ����
            alert("�����ȣ ã�� ����� �������ּ���");
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
                <td>${member.ssn}</td>
                <td>${member.email}<input type="email" name="email" value="${member.email}" readonly class="editable"></td>
                <td>${member.phone}<input type="text" name="phone" value="${member.phone}" readonly class="editable"></td>
                <td>${member.postcode}<input type="text" name="postcode" value="${member.postcode}" readonly class="editable">
                    <button type="button" id="findPostcode" style="display: none;" onclick="searchPostcode()">ã��</button></td>
                <td>${member.address}<input type="text" name="address" value="${member.address}" readonly class="editable"></td>
                <td>${member.detail_address}<input type="text" name="detail_address" value="${member.detail_address}" readonly class="editable"></td>
                <td>${member.authority}</td>
                <td>${member.date}</td>
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