#include <iostream>
#include <windows.h>
#include <mysql/jdbc.h>
using namespace std;

std::unique_ptr<sql::Connection> con;


// READ
void readCustomers() {

	try {
		//SELECT 쿼리 준비
		unique_ptr<sql::PreparedStatement> selectQuery(
			con->prepareStatement("SELECT customer_id, name, email, phone FROM customers")
		); // query 담을 변수

		//쿼리 싱핼 및 결과 수신
		unique_ptr<sql::ResultSet> res(selectQuery->executeQuery());

		// 결과 출력
		while (res->next()) {
			cout << "[" << res->getInt("customer_id") << "]"
				<< res->getString("name") << "/"
				<< res->getString("email") << "/"
				<< res->getString("phone") << "/" << endl;
		}
	}
	catch (sql::SQLException& e) {
		cerr << "select failed" << e.what() << endl;
	}
}

//CREATE
void createCustomers() {

	try {
		// 고객 등록
		string c_name, email, phone;
		cin.ignore(); // 버퍼정리
		cout << "Customer name: ";
		getline(cin, c_name);
		cout << "Email: ";
		getline(cin, email);
		cout << "Phone: ";
		getline(cin, phone);

		unique_ptr<sql::PreparedStatement> insertQuery( // insert query 준비
			con->prepareStatement("INSERT INTO customers (name, email, phone) VALUES(?, ?, ?)")
		); // query 담을 변수
		insertQuery->setString(1, c_name);
		insertQuery->setString(2, email);
		insertQuery->setString(3, phone);

		int result = insertQuery->executeUpdate(); // 결과에 대한 숫자가 반환
		cout << result << " customers were registered" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "insert failed" << e.what() << endl;
	}
}

//UPDATE
void updateCustomers() {

	// 고객 등록
	int customer_id;
	string c_name, email, phone;
	cin.ignore(); // 버퍼정리
	cout << "Customer id: ";
	cin >> customer_id;
	cin.ignore();
	cout << "Customer name: ";
	getline(cin, c_name);
	cout << "Email: ";
	getline(cin, email);
	cout << "Phone: ";
	getline(cin, phone);

	try {
		unique_ptr<sql::PreparedStatement> updateQuery( // insert query 준비
			con->prepareStatement("Update customers SET name = ?, email = ?, phone = ? WHERE customer_id = ?")
		); // query 담을 변수
		updateQuery->setString(1, c_name);
		updateQuery->setString(2, email);
		updateQuery->setString(3, phone);
		updateQuery->setInt(4, customer_id); // where 조건에 필요한 값 넣기

		int result = updateQuery->executeUpdate(); // 결과에 대한 숫자가 반환
		cout << result << " customers updated" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "insert failed" << e.what() << endl;
	}
}

//DELETE
void deleteCustomers() {

	// 고객 등록
	int customer_id;
	cout << "Customer id: ";
	cin >> customer_id;

	try {
		unique_ptr<sql::PreparedStatement> DeleteQuery( // insert query 준비
			con->prepareStatement("DELETE FROM customers WHERE customer_id = ?")
		); // query 담을 변수
		DeleteQuery->setInt(1, customer_id); // where 조건에 필요한 값 넣기

		cout << customer_id << "th customer was deleted" << endl;
	}
	catch (sql::SQLException& e) {
		cerr << "delete failed" << e.what() << endl;
	}
}

void showMenu() {
	cout << "\n ================ Customer management ================\n";
	cout << "1. Add customer" << endl
		<< "2. Get customers" << endl
		<< "3. Update customer" << endl
		<< "4. Delete customer" << endl
		<< "0. Exit" << endl;
	cout << "======================================================\n";
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

		con->setSchema("codingon_store_db");
		cout << "db Connect Success!!!" << endl;

		int choice;
		while (true) {
			showMenu();
			cin >> choice;
			switch(choice) {
				case 1:	createCustomers(); break;
				case 2:	readCustomers(); break;
				case 3:	updateCustomers(); break;
				case 4:	deleteCustomers(); break;
				case 0: cout << "종료합니다" << endl; return 0;
				default: cout << "잘못된 입력입니다" << endl; break;
			}
		}
	}
	catch (sql::SQLException& e) {
		cerr << "DB Connect Failed: " << e.what() << endl;
	}

	return 0;
}