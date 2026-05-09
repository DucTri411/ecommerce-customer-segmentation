# 📊 Data Dictionary: Online Retail II Dataset

## 📖 Bối cảnh (Context)
Dataset này chứa toàn bộ lịch sử giao dịch của một doanh nghiệp bán lẻ trực tuyến (không có cửa hàng vật lý) được đăng ký và có trụ sở tại Vương quốc Anh. 

- **Thời gian thu thập:** 01/12/2009 đến 09/12/2011.
- **Lĩnh vực kinh doanh:** Chủ yếu bán các mặt hàng quà tặng độc đáo cho mọi dịp.
- **Đối tượng khách hàng:** Rất nhiều khách hàng của công ty là **khách mua sỉ (wholesalers)**.

---

## 딕 Cấu trúc dữ liệu (Attribute Information)

Dưới đây là chi tiết ý nghĩa của từng cột trong tập dữ liệu:

| Tên cột (Column) | Loại dữ liệu (Type) | Mô tả chi tiết (Description) |
| :--- | :--- | :--- |
| **`InvoiceNo`** | Danh nghĩa (Nominal) | Số hóa đơn. Gồm 6 chữ số được gán duy nhất cho mỗi giao dịch. **Lưu ý:** Nếu mã này bắt đầu bằng chữ `c`, nó biểu thị một **đơn hàng bị hủy (cancellation)**. |
| **`StockCode`** | Danh nghĩa (Nominal) | Mã sản phẩm. Gồm 5 chữ số được gán duy nhất cho mỗi sản phẩm khác nhau. |
| **`Description`** | Danh nghĩa (Nominal) | Tên sản phẩm. |
| **`Quantity`** | Số (Numeric) | Số lượng của từng sản phẩm trên mỗi giao dịch. |
| **`InvoiceDate`** | Số (Numeric) | Ngày và giờ xuất hóa đơn (Thời điểm giao dịch được tạo). |
| **`UnitPrice`** | Số (Numeric) | Đơn giá của sản phẩm. Tính bằng đồng **Bảng Anh (£)**. |
| **`CustomerID`** | Danh nghĩa (Nominal) | Mã khách hàng. Gồm 5 chữ số được gán duy nhất cho mỗi khách hàng. |
| **`Country`** | Danh nghĩa (Nominal) | Tên quốc gia nơi khách hàng sinh sống. |

---

## ⚠️ Lưu ý quan trọng cho quá trình Phân tích & Làm sạch (Data Cleaning Notes)

Dựa trên mô tả dữ liệu, khi tiến hành Data Cleaning (Tiền xử lý), cần chú ý các điểm sau:
1. **Đơn hàng bị hủy:** Cần lọc hoặc xử lý riêng các bản ghi có `InvoiceNo` bắt đầu bằng `c` để tránh tính toán sai doanh thu.
2. **Khách hàng mua sỉ:** Do có khách sỉ, cột `Quantity` có thể xuất hiện những giá trị rất lớn (Outliers mang tính hợp lý). Cần cẩn thận khi loại bỏ ngoại lệ (outliers).
3. **Tiền tệ:** Đơn giá (`UnitPrice`) đang hiển thị ở mức Bảng Anh (£). Nếu cần quy đổi ngoại tệ để làm báo cáo, cần lưu ý tỷ giá.