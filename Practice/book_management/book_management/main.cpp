#include <iostream>
#include <windows.h>
#include <mysql/jdbc.h>
using namespace std;

std::unique_ptr<sql::Connection> con;

// 책 만들기
void createBook() {
	// 책 등록
	string title, author, published_at;
	int price;

	cin.ignore(); // 옵션 선택으로 인한 버퍼정리
	cout << "Book Title: ";
	getline(cin, title);
	cout << "Author: ";
	getline(cin, author);
	cout << "Published at(ex.2000-01-01): ";
	getline(cin, published_at);
	cout << "Price: ";
	cin >> price;
	try {
		unique_ptr<sql::PreparedStatement> insertQuery( // insert query 준비
			con->prepareStatement("INSERT INTO books (title, author, published_at, price) VALUES(?, ?, ?, ?)")
		); // query 담을 변수
		insertQuery->setString(1, title);
		insertQuery->setString(2, author);
		insertQuery->setString(3, published_at);
		insertQuery->setInt(4, price);

		int result = insertQuery->executeUpdate(); // 결과에 대한 숫자가 반환
		cout << result << " book registered" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Insert failed " << e.what() << endl;
	}
}

// 책 정보들 불러오기
void listBooks() {
	try {
		unique_ptr<sql::PreparedStatement> selectQuery(
			con->prepareStatement("SELECT * FROM books") // 정보 전부 다
		);

		//쿼리 싱핼 및 결과 수신
		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());

		// 결과 출력
		while (res->next()) {
			cout << "[" << res->getInt("book_id") << "]"
				<< res->getString("title") << "/"
				<< res->getString("author") << "/"
				<< res->getString("published_at") << "/"
				<< res->getInt("price") << "/" 
				<< res->getString("status") << "/" << endl;
		}
	}
	catch (sql::SQLException& e) {
		cerr << "Select failed " << e.what() << endl;
	}
}

// 책 업데이트
void updateBook() {
	// 책 번호 기준 정보 업데이트
	int book_id, price;
	string title, author, published_at;
	cin.ignore(); // 버퍼정리
	cout << "Book id: ";
	cin >> book_id;
	cin.ignore();
	cout << "Title: ";
	getline(cin, title);
	cout << "Author: ";
	getline(cin, author);
	cout << "Published At: ";
	getline(cin, published_at);
	cout << "Price: ";
	cin >> price;

	try {
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query 준비
			con->prepareStatement("Update books SET title = ?, author = ?, published_at = ?, price = ? WHERE book_id = ?")
		); // query 담을 변수
		updateQuery->setString(1, title);
		updateQuery->setString(2, author);
		updateQuery->setString(3, published_at);
		updateQuery->setInt(4, price);
		updateQuery->setInt(5, book_id);

		int result = updateQuery->executeUpdate(); // 결과에 대한 숫자가 반환
		cout << result << " book updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Update failed " << e.what() << endl;
	}
}

// 책 삭제
void deleteBook() {
	// 책 번호 기준으로 삭제
	int book_id;
	cout << "Book id: ";
	cin >> book_id;

	try {
		unique_ptr<sql::PreparedStatement> DeleteQuery(
			con->prepareStatement("DELETE FROM books WHERE book_id = ?")
		);
		DeleteQuery->setInt(1, book_id); // where 조건에 필요한 값 넣기

		//쿼리 싱핼 및 결과 수신
		unique_ptr<sql::ResultSet> res(DeleteQuery->executeQuery());

		cout << book_id << "th book was deleted" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Delete failed " << e.what() << endl;
	}
}

//회원 생성
void createMember() {
	// 회원 등록
	string name, email, phone, registered_at;

	cin.ignore(); // 옵션 선택으로 인한 버퍼정리
	cout << "Name: ";
	getline(cin, name);
	cout << "Email: ";
	getline(cin, email);
	cout << "Phone: ";
	getline(cin, phone);
	cout << "Registered at(ex.2000-01-01): ";
	getline(cin, registered_at);

	try {
		unique_ptr<sql::PreparedStatement> insertQuery( // insert query 준비
			con->prepareStatement("INSERT INTO members (name, email, phone, registered_at) VALUES(?, ?, ?, ?)")
		); // query 담을 변수
		insertQuery->setString(1, name);
		insertQuery->setString(2, email);
		insertQuery->setString(3, phone);
		insertQuery->setString(4, registered_at);

		int result = insertQuery->executeUpdate(); // 결과에 대한 숫자가 반환
		cout << result << " member registered" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Insert failed " << e.what() << endl;
	}
}

//회원 정보들 불러오기
void listMembers() {
	try {
		unique_ptr<sql::PreparedStatement> selectQuery(
			con->prepareStatement("SELECT * FROM members") // 정보 전부 다
		);

		//쿼리 싱핼 및 결과 수신
		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());

		// 결과 출력
		while (res->next()) { // 다음 행으로. 없으면 실행 종료
			cout << "[" << res->getInt("member_id") << "]"
				<< res->getString("name") << "/"
				<< res->getString("email") << "/"
				<< res->getString("phone") << "/"
				<< res->getString("registered_at") << "/" << endl;
		}
	}
	catch (sql::SQLException& e) {
		cerr << "Select failed " << e.what() << endl;
	}
}

//회원 업데이트
void updateMember() {

	// 회원 번호 기준 회원 업데이트
	int member_id;
	string name, email, phone, registered_at;

	cin.ignore(); // 옵션 선택으로 인한 버퍼정리
	cout << "Member id: ";
	cin >> member_id;
	cin.ignore();
	cout << "Name: ";
	getline(cin, name);
	cout << "Email: ";
	getline(cin, email);
	cout << "Phone: ";
	getline(cin, phone);
	cout << "Registered at(ex.2000-01-01): ";
	getline(cin, registered_at);

	try {
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query 준비
			con->prepareStatement("Update members SET name = ?, email = ?, phone = ?, registered_at = ? WHERE member_id = ?")
		); // query 담을 변수
		updateQuery->setString(1, name);
		updateQuery->setString(2, email);
		updateQuery->setString(3, phone);
		updateQuery->setString(4, registered_at);
		updateQuery->setInt(5, member_id);

		int result = updateQuery->executeUpdate(); // 결과에 대한 숫자가 반환
		cout << result << " member updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Update failed " << e.what() << endl;
	}
}

// 회원 삭제
void deleteMember() {
	// 회원 번호 기준으로 삭제
	int member_id;
	cout << "Member id: ";
	cin >> member_id;

	try {
		unique_ptr<sql::PreparedStatement> DeleteQuery(
			con->prepareStatement("DELETE FROM members WHERE member_id = ?")
		);
		DeleteQuery->setInt(1, member_id); // where 조건에 필요한 값 넣기

		//쿼리 싱핼 및 결과 수신
		unique_ptr<sql::ResultSet> res(DeleteQuery->executeQuery());

		cout << member_id << "th member was deleted" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Delete failed " << e.what() << endl;
	}
}

// 책 빌리기
void rentBook() {
	// 대여 기록 생성
	string name, phone; // 책을 빌리는 회원
	string title; // 빌리려는 책의 이름
	int member_id = 0, book_id = 0;

	cin.ignore(); // 옵션 선택으로 인한 버퍼정리
	cout << "Member name: ";
	getline(cin, name); // 이름과 핸드폰 번호 입력하여 멤버 식별
	cout << "Phone: ";
	getline(cin, phone);
	cout << "Book title: ";
	getline(cin, title);

	try {
		unique_ptr<sql::PreparedStatement> selectQuery( // insert query 준비
			con->prepareStatement("SELECT member_id FROM members WHERE name = ? and phone = ?")
		); // query 담을 변수
		selectQuery->setString(1, name);
		selectQuery->setString(2, phone);

		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());
		if (!res->next()) {
			cout << "Member with the name and phone number does not exist";
			return;
		}

		member_id = res->getInt("member_id");
	}
	catch (sql::SQLException& e) {
		cerr << "Select failed " << e.what() << endl;
	}

	try {
		unique_ptr<sql::PreparedStatement> selectQuery( // insert query 준비
			con->prepareStatement("SELECT book_id FROM books WHERE title = ? and status = 'Rentable'")
		); // query 담을 변수
		selectQuery->setString(1, title); // 책 이름이 title이고 대여상태가 대여가능인 책 선택

		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());
		if (!res->next()) {
			cout << "Rentable book with the title does not exist";
			return ;
		}

		book_id = res->getInt("book_id");
	}
	catch (sql::SQLException& e) {
		cerr << "Select failed " << e.what() << endl;
	}

	try {
		unique_ptr<sql::PreparedStatement> insertQuery( // insert query 준비
			con->prepareStatement("INSERT INTO rentals (book_id, member_id) VALUES(?, ?)")
		); // query 담을 변수
		insertQuery->setInt(1, book_id);
		insertQuery->setInt(2, member_id);
		// 대여 번호는 자동 생성, 대여시간은 현재 시간, 반납은 null 상태

		int result = insertQuery->executeUpdate(); // 결과에 대한 숫자가 반환
		cout << result << " rental registered" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Insert failed " << e.what() << endl;
	}

	try {
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query 준비
			con->prepareStatement("Update books SET status = 'Renting' WHERE book_id = ?")
		);
		updateQuery->setInt(1, book_id); // 빌린 책의 id 입력하여 대여상태 업데이트

		int result = updateQuery->executeUpdate(); // 결과에 대한 숫자가 반환
		cout << result << " book updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Update failed " << e.what() << endl;
	}
}

void returnBook() {
	int rental_id = 0, book_id = 0;

	cin.ignore(); // 옵션 선택으로 인한 버퍼정리
	cout << "Rental_id: ";
	cin >> rental_id; // 대여번호 입력

	//책 반환
	try {
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query 준비
			con->prepareStatement("Update rentals SET returned_at = NOW() WHERE rental_id = ?")
		);
		updateQuery->setInt(1, rental_id); // 빌린 책의 id 입력하여 대여상태 업데이트

		int result = updateQuery->executeUpdate(); // 결과에 대한 숫자가 반환
		cout << result << " rental updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Update failed " << e.what() << endl;
	}

	// 책 id 찾기
	try {
		unique_ptr<sql::PreparedStatement> selectQuery( // insert query 준비
			con->prepareStatement("SELECT book_id FROM rentals WHERE rental_id = ?")
		); // query 담을 변수
		selectQuery->setInt(1, rental_id); // rental_id 통해 book_id 찾기

		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());
		res->next(); // 1번 행으로 가려면 한번은 next 해야 함
		book_id = res->getInt("book_id");
	}
	catch (sql::SQLException& e) {
		cerr << "Select failed " << e.what() << endl;
	}

	try {
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query 준비
			con->prepareStatement("Update books SET status = 'Rentable' WHERE book_id = ?")
		);
		updateQuery->setInt(1, book_id); // 빌린 책의 id 입력하여 대여상태 업데이트

		int result = updateQuery->executeUpdate(); // 결과에 대한 숫자가 반환
		cout << result << " book updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Update failed " << e.what() << endl;
	}
}

// 대여상태 보여주기
void showRentalStatus() {
	try {
		unique_ptr<sql::PreparedStatement> selectQuery(
			con->prepareStatement("SELECT rental_id, title, name, rented_at "
								"FROM rentals r "
								"JOIN books b ON r.book_id = b.book_id "
								"JOIN members m ON r.member_id = m.member_id "
								"WHERE r.returned_at IS NULL"
			) // 정보 합쳐서 보여주기. 책 이름이 뭔지, 누가 빌렸는지, 언제 빌렸는지
		);

		//쿼리 싱핼 및 결과 수신
		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());

		// 결과 출력
		while (res->next()) {
			cout << "[" << res->getInt("rental_id") << "]"
				<< res->getString("title") << "/"
				<< res->getString("name") << "/"
				<< res->getString("rented_at") << "/" << endl;
		}
	}
	catch (sql::SQLException& e) {
		cerr << "Select failed " << e.what() << endl;
	}
}

void showMenu() {
	cout << "\n==== Book Store management ====\n";
	cout << "1. Add book" << endl
		<< "2. Show book list" << endl
		<< "3. Change book info" << endl
		<< "4. Remove book" << endl
		<< "5. Add member" << endl
		<< "6. Show member list" << endl
		<< "7. Change member info" << endl
		<< "8. Remove member" << endl
		<< "9. Rent book" << endl
		<< "10. Return book" << endl
		<< "11. Show rent list" << endl
		<< "0. Exit" << endl;
	cout << "===============================\n";
	cout << "Select: ";
}

int main() {
	SetConsoleCP(CP_UTF8);
	SetConsoleOutputCP(CP_UTF8);
	try {
		sql::mysql::MySQL_Driver* driver = sql::mysql::get_mysql_driver_instance();
		// mysql과 연결하기 위한 드라이버를 생성해준다

	// 연결 객체 생성
		const string server = "tcp://127.0.0.1";
		const string name = "root";
		const string password = "4613mnbv";
		con.reset(driver->connect(server, name, password)); // 메서드 체인을 활용하여 연결

		con->setSchema("book_management_db");
		cout << "db Connect Success!!!" << endl;

		int choice;
		while (true) {
			showMenu();
			cin >> choice;
			switch (choice) {
			case 1:	createBook(); break;
			case 2:	listBooks(); break;
			case 3:	updateBook(); break;
			case 4:	deleteBook(); break;
			case 5:	createMember(); break;
			case 6:	listMembers(); break;
			case 7:	updateMember(); break;
			case 8:	deleteMember(); break;
			case 9:	rentBook(); break;
			case 10: returnBook(); break;
			case 11: showRentalStatus(); break;
			case 0: cout << "Closing system" << endl; return 0;
			default: cout << "Wrong input" << endl; break;
			}
		}
	}
	catch (sql::SQLException& e) {
		cerr << "DB Connect Failed: " << e.what() << endl;
	}

	return 0;
}