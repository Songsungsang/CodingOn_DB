#include <iostream>
#include <windows.h>
#include <mysql/jdbc.h>
using namespace std;

std::unique_ptr<sql::Connection> con;

// å �����
void createBook() {
	// å ���
	string title, author, published_at;
	int price;

	cin.ignore(); // �ɼ� �������� ���� ��������
	cout << "Book Title: ";
	getline(cin, title);
	cout << "Author: ";
	getline(cin, author);
	cout << "Published at(ex.2000-01-01): ";
	getline(cin, published_at);
	cout << "Price: ";
	cin >> price;
	try {
		unique_ptr<sql::PreparedStatement> insertQuery( // insert query �غ�
			con->prepareStatement("INSERT INTO books (title, author, published_at, price) VALUES(?, ?, ?, ?)")
		); // query ���� ����
		insertQuery->setString(1, title);
		insertQuery->setString(2, author);
		insertQuery->setString(3, published_at);
		insertQuery->setInt(4, price);

		int result = insertQuery->executeUpdate(); // ����� ���� ���ڰ� ��ȯ
		cout << result << " book registered" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Insert failed " << e.what() << endl;
	}
}

// å ������ �ҷ�����
void listBooks() {
	try {
		unique_ptr<sql::PreparedStatement> selectQuery(
			con->prepareStatement("SELECT * FROM books") // ���� ���� ��
		);

		//���� ���� �� ��� ����
		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());

		// ��� ���
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

// å ������Ʈ
void updateBook() {
	// å ��ȣ ���� ���� ������Ʈ
	int book_id, price;
	string title, author, published_at;
	cin.ignore(); // ��������
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
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query �غ�
			con->prepareStatement("Update books SET title = ?, author = ?, published_at = ?, price = ? WHERE book_id = ?")
		); // query ���� ����
		updateQuery->setString(1, title);
		updateQuery->setString(2, author);
		updateQuery->setString(3, published_at);
		updateQuery->setInt(4, price);
		updateQuery->setInt(5, book_id);

		int result = updateQuery->executeUpdate(); // ����� ���� ���ڰ� ��ȯ
		cout << result << " book updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Update failed " << e.what() << endl;
	}
}

// å ����
void deleteBook() {
	// å ��ȣ �������� ����
	int book_id;
	cout << "Book id: ";
	cin >> book_id;

	try {
		unique_ptr<sql::PreparedStatement> DeleteQuery(
			con->prepareStatement("DELETE FROM books WHERE book_id = ?")
		);
		DeleteQuery->setInt(1, book_id); // where ���ǿ� �ʿ��� �� �ֱ�

		//���� ���� �� ��� ����
		unique_ptr<sql::ResultSet> res(DeleteQuery->executeQuery());

		cout << book_id << "th book was deleted" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Delete failed " << e.what() << endl;
	}
}

//ȸ�� ����
void createMember() {
	// ȸ�� ���
	string name, email, phone, registered_at;

	cin.ignore(); // �ɼ� �������� ���� ��������
	cout << "Name: ";
	getline(cin, name);
	cout << "Email: ";
	getline(cin, email);
	cout << "Phone: ";
	getline(cin, phone);
	cout << "Registered at(ex.2000-01-01): ";
	getline(cin, registered_at);

	try {
		unique_ptr<sql::PreparedStatement> insertQuery( // insert query �غ�
			con->prepareStatement("INSERT INTO members (name, email, phone, registered_at) VALUES(?, ?, ?, ?)")
		); // query ���� ����
		insertQuery->setString(1, name);
		insertQuery->setString(2, email);
		insertQuery->setString(3, phone);
		insertQuery->setString(4, registered_at);

		int result = insertQuery->executeUpdate(); // ����� ���� ���ڰ� ��ȯ
		cout << result << " member registered" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Insert failed " << e.what() << endl;
	}
}

//ȸ�� ������ �ҷ�����
void listMembers() {
	try {
		unique_ptr<sql::PreparedStatement> selectQuery(
			con->prepareStatement("SELECT * FROM members") // ���� ���� ��
		);

		//���� ���� �� ��� ����
		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());

		// ��� ���
		while (res->next()) { // ���� ������. ������ ���� ����
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

//ȸ�� ������Ʈ
void updateMember() {

	// ȸ�� ��ȣ ���� ȸ�� ������Ʈ
	int member_id;
	string name, email, phone, registered_at;

	cin.ignore(); // �ɼ� �������� ���� ��������
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
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query �غ�
			con->prepareStatement("Update members SET name = ?, email = ?, phone = ?, registered_at = ? WHERE member_id = ?")
		); // query ���� ����
		updateQuery->setString(1, name);
		updateQuery->setString(2, email);
		updateQuery->setString(3, phone);
		updateQuery->setString(4, registered_at);
		updateQuery->setInt(5, member_id);

		int result = updateQuery->executeUpdate(); // ����� ���� ���ڰ� ��ȯ
		cout << result << " member updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Update failed " << e.what() << endl;
	}
}

// ȸ�� ����
void deleteMember() {
	// ȸ�� ��ȣ �������� ����
	int member_id;
	cout << "Member id: ";
	cin >> member_id;

	try {
		unique_ptr<sql::PreparedStatement> DeleteQuery(
			con->prepareStatement("DELETE FROM members WHERE member_id = ?")
		);
		DeleteQuery->setInt(1, member_id); // where ���ǿ� �ʿ��� �� �ֱ�

		//���� ���� �� ��� ����
		unique_ptr<sql::ResultSet> res(DeleteQuery->executeQuery());

		cout << member_id << "th member was deleted" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Delete failed " << e.what() << endl;
	}
}

// å ������
void rentBook() {
	// �뿩 ��� ����
	string name, phone; // å�� ������ ȸ��
	string title; // �������� å�� �̸�
	int member_id = 0, book_id = 0;

	cin.ignore(); // �ɼ� �������� ���� ��������
	cout << "Member name: ";
	getline(cin, name); // �̸��� �ڵ��� ��ȣ �Է��Ͽ� ��� �ĺ�
	cout << "Phone: ";
	getline(cin, phone);
	cout << "Book title: ";
	getline(cin, title);

	try {
		unique_ptr<sql::PreparedStatement> selectQuery( // insert query �غ�
			con->prepareStatement("SELECT member_id FROM members WHERE name = ? and phone = ?")
		); // query ���� ����
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
		unique_ptr<sql::PreparedStatement> selectQuery( // insert query �غ�
			con->prepareStatement("SELECT book_id FROM books WHERE title = ? and status = 'Rentable'")
		); // query ���� ����
		selectQuery->setString(1, title); // å �̸��� title�̰� �뿩���°� �뿩������ å ����

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
		unique_ptr<sql::PreparedStatement> insertQuery( // insert query �غ�
			con->prepareStatement("INSERT INTO rentals (book_id, member_id) VALUES(?, ?)")
		); // query ���� ����
		insertQuery->setInt(1, book_id);
		insertQuery->setInt(2, member_id);
		// �뿩 ��ȣ�� �ڵ� ����, �뿩�ð��� ���� �ð�, �ݳ��� null ����

		int result = insertQuery->executeUpdate(); // ����� ���� ���ڰ� ��ȯ
		cout << result << " rental registered" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Insert failed " << e.what() << endl;
	}

	try {
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query �غ�
			con->prepareStatement("Update books SET status = 'Renting' WHERE book_id = ?")
		);
		updateQuery->setInt(1, book_id); // ���� å�� id �Է��Ͽ� �뿩���� ������Ʈ

		int result = updateQuery->executeUpdate(); // ����� ���� ���ڰ� ��ȯ
		cout << result << " book updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Update failed " << e.what() << endl;
	}
}

void returnBook() {
	int rental_id = 0, book_id = 0;

	cin.ignore(); // �ɼ� �������� ���� ��������
	cout << "Rental_id: ";
	cin >> rental_id; // �뿩��ȣ �Է�

	//å ��ȯ
	try {
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query �غ�
			con->prepareStatement("Update rentals SET returned_at = NOW() WHERE rental_id = ?")
		);
		updateQuery->setInt(1, rental_id); // ���� å�� id �Է��Ͽ� �뿩���� ������Ʈ

		int result = updateQuery->executeUpdate(); // ����� ���� ���ڰ� ��ȯ
		cout << result << " rental updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Update failed " << e.what() << endl;
	}

	// å id ã��
	try {
		unique_ptr<sql::PreparedStatement> selectQuery( // insert query �غ�
			con->prepareStatement("SELECT book_id FROM rentals WHERE rental_id = ?")
		); // query ���� ����
		selectQuery->setInt(1, rental_id); // rental_id ���� book_id ã��

		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());
		res->next(); // 1�� ������ ������ �ѹ��� next �ؾ� ��
		book_id = res->getInt("book_id");
	}
	catch (sql::SQLException& e) {
		cerr << "Select failed " << e.what() << endl;
	}

	try {
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query �غ�
			con->prepareStatement("Update books SET status = 'Rentable' WHERE book_id = ?")
		);
		updateQuery->setInt(1, book_id); // ���� å�� id �Է��Ͽ� �뿩���� ������Ʈ

		int result = updateQuery->executeUpdate(); // ����� ���� ���ڰ� ��ȯ
		cout << result << " book updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "Update failed " << e.what() << endl;
	}
}

// �뿩���� �����ֱ�
void showRentalStatus() {
	try {
		unique_ptr<sql::PreparedStatement> selectQuery(
			con->prepareStatement("SELECT rental_id, title, name, rented_at "
								"FROM rentals r "
								"JOIN books b ON r.book_id = b.book_id "
								"JOIN members m ON r.member_id = m.member_id "
								"WHERE r.returned_at IS NULL"
			) // ���� ���ļ� �����ֱ�. å �̸��� ����, ���� ���ȴ���, ���� ���ȴ���
		);

		//���� ���� �� ��� ����
		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());

		// ��� ���
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
		// mysql�� �����ϱ� ���� ����̹��� �������ش�

	// ���� ��ü ����
		const string server = "tcp://127.0.0.1";
		const string name = "root";
		const string password = "4613mnbv";
		con.reset(driver->connect(server, name, password)); // �޼��� ü���� Ȱ���Ͽ� ����

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